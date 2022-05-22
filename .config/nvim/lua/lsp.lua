local notify = require 'notify'
local lsp_installer = require 'nvim-lsp-installer'
local lsp_format = require 'lsp-format'
local lsp = require 'lspconfig'
local wk = require 'which-key'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

local messages = {}

local function format_msg(val)
    local message = val.title
    if val.message ~= '' then
        message = table.concat({ message, val.message }, ': ')
    end
    if val.percentage ~= nil then
        local percentage = tostring(val.percentage) .. '%'
        if message == '' then
            message = percentage
        else
            message = message .. ' (' .. percentage .. ')'
        end
    end

    return message
end

function messages.begin(msg, ctx)
    if messages[ctx.client_id] == nil then
        messages[ctx.client_id] = {}
    end
    local client = messages[ctx.client_id]

    if client[msg.token] == nil then
        client[msg.token] = {}
    end
    local data = client[msg.token]

    local val = vim.tbl_extend('keep', msg.value, { message = '', title = '' })

    local opts = {
        icon = '\u{f64f} ',
        title = 'LSP Progress',
        timeout = 5000,
        on_close = function() data.id = nil end
    }

    if data.id ~= nil then
        opts.replace = data.id
    end

    data.id = notify(format_msg(val), 'info', opts).id
    data.title = val.title
end

function messages.report(msg, ctx)
    local client = messages[ctx.client_id]
    if client == nil then return end

    local data = client[msg.token]
    if data == nil then return end

    local val = msg.value
    val.title = data.title
    local opts = { replace = data.id }

    data.id = notify(format_msg(val), 'info', opts)
end

function messages.mend(msg, ctx)
    local client = messages[ctx.client_id]
    if client == nil then return end

    local data = client[msg.token]
    if data == nil then return end

    local val = msg.value
    val.title = data.title

    local opts = {
        icon = '\u{2713} ',
        replace = data.id,
        timeout = 500,
    }

    data.id = notify(format_msg(val), 'info', opts)
    data.title = ''
end

function messages.generic(msg)
    local val = vim.tbl_extend('keep', msg.value, { message = '', title = '' })
    notify(format_msg(val), 'info', { title = 'LSP Progress' })
end

function messages.handle(msg, ctx)
    local val = msg.value

    if val.kind == 'begin' then messages.begin(msg, ctx)
    elseif val.kind == 'report' then messages.report(msg, ctx)
    elseif val.kind == 'end' then messages.mend(msg, ctx)
    else messages.generic(msg) end
end

local function mk_handler(fn)
    return function(...)
        local config_or_client_id = select(4, ...)
        local is_new = type(config_or_client_id) ~= 'number'
        if is_new then
            fn(...)
        else
            local err = select(1, ...)
            local method = select(2, ...)
            local result = select(3, ...)
            local client_id = select(4, ...)
            local bufnr = select(5, ...)
            local config = select(6, ...)
            fn(err, result, { method = method, client_id = client_id, bufnr = bufnr }, config)
        end
    end
end

local function progress_callback(_, msg, ctx)
    messages.handle(msg, ctx)
end

local function register_progress()
    vim.lsp.handlers['$/progress'] = mk_handler(progress_callback)
end

local M = {}

local function set_keybinds(_, bufnr)
    local telescope = require('telescope.builtin')
    local cursor = require('telescope.themes').get_cursor
    local dropdown = require('telescope.themes').get_dropdown

    wk.register({
        d = {
            name = "diag",
            l = { telescope.diagnostics, "List Diagnostics", buffer = bufnr },
            h = { function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" }) end, "Hover", buffer = bufnr },
        },
        j = {
            name = "jump",
            d = { function() telescope.lsp_definitions(cursor()) end, "Definition", buffer = bufnr },
            D = { vim.lsp.buf.declaration, "Declaration", buffer = bufnr },
            t = { function() telescope.lsp_type_definitions(dropdown()) end, "Type", buffer = bufnr },
            i = { function() telescope.lsp_implementations(dropdown()) end, "Implementation", buffer = bufnr },
            r = { function() telescope.lsp_references(dropdown()) end, "References", buffer = bufnr },
        },
        c = {
            name = "code",
            a = { vim.lsp.buf.code_action, "Actions", buffer = bufnr },
            h = { vim.lsp.buf.hover, "Hover", buffer = bufnr },
            hh = { function() vim.lsp.buf.hover() vim.lsp.buf.hover() end, "Hover and jump", buffer = bufnr },
            s = { vim.lsp.buf.signature_help, "Signature", buffer = bufnr },
            r = { vim.lsp.buf.rename, "Rename", buffer = bufnr },
            f = { vim.lsp.buf.formatting, "Format", buffer = bufnr },
            S = { function() telescope.lsp_document_symbols(dropdown()) end, "Symbols", buffer = bufnr },

            w = {
                name = "workspace",
                a = { vim.lsp.buf.add_workspace_folder, "Add folder", buffer = bufnr },
                r = { vim.lsp.buf.remove_workspace_folder, "Remove folder", buffer = bufnr },
                l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List", buffer = bufnr },
            }
        },
    }, { prefix = "<Leader>" })
end

local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.bim.lsp.omnifunc')
    lsp_format.on_attach(client)
    set_keybinds(client, bufnr)

    notify("LSP Server attached: " .. client.name, "info", { title = "LSP" })
end

function M.setup()
    register_progress()

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    vim.diagnostic.config {
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },

    }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

    lsp_installer.setup({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

    lsp.flow.setup {}

    local servers = lsp_installer.get_installed_servers();
    for _, config in pairs(servers) do
        local setup_opts = {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        local status, user_config = pcall(require, 'lsp/settings/' .. config.name)
        if status then
            if user_config.settings ~= nil then
                setup_opts.settings = user_config.settings
            end
        end

        local setup = function(_) notify("No setup function for LSP server `" .. config.name .. "`", "warn", { title = "LSP" }) end

        if user_config.setup ~= nil then
            setup = user_config.setup
        elseif lsp[config.name] ~= nil then
            setup = lsp[config.name].setup
        end

        local status, error = pcall(setup, setup_opts)
        if not status then
            notify("LSP Server `" .. config.name .. "` configuration failed: " .. error, "warn", { title = "LSP" })
        end


        lsp_format.setup()
    end
end

return M
