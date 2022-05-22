local M = {}

local rust = require "rust-tools"
local runnables = require "rust-tools.runnables"
local expand = require "rust-tools.expand_macro"
local cargo = require "rust-tools.open_cargo_toml"
local parent = require "rust-tools.parent_module"
local wk = require "which-key"

M.settings = {
    ["rust-analyzer"] = {
        assist = {
            importGranularity = "module",
        },
        cargo = {
            loadOutDirsFromCheck = true,
        },
        procMacro = {
            enable = true
        },
        checkOnSave = {
            AllTargets = true,
            AllFeatures = true,
            command = "clippy"
        },
        hover = {
            linksInHover = false,
        }
    }
}

local function set_keybinds(_, bufnr)
    wk.register({
        c = {
            R = { runnables.runnables, "Runnables", buffer = bufnr },
            E = { expand.expand_macro, "Expand macro", buffer = bufnr },
            J = { require "rust-tools.join_lines".join_lines, "Join lines", buffer = bufnr },
            G = { require "rust-tools.crate_graph".view_crate_graph, "Graph", buffer = bufnr },
        },
        j = {
            c = { cargo.open_cargo_toml, "Cargo.toml", buffer = bufnr },
            p = { parent.parent_module, "Parent module", buffer = bufnr },
        }
    }, { prefix = "<Leader>" })
end

function M.setup(opts)
    local opts_attach = opts.on_attach
    local function on_attach(client, bufnr)
        opts_attach(client, bufnr)
        set_keybinds(client, bufnr)
    end

    opts.on_attach = on_attach

    rust.setup {
        inlay_hints = {
            show_parameter_hints = true,
        },
        server = opts
    }
end

return M
