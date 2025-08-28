local lsp = require('lsp-zero').preset({
    name = 'minimal',
})

lsp.ensure_installed({
    'ts_ls',
    'eslint',
    'rust_analyzer'
})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })

    lsp.buffer_autoformat({ buffer = bufnr })
end)


-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('lspconfig').gopls.setup {
    settings = {
        gopls = {
            gofumpt = true,
        }
    },
}

vim.lsp.set_log_level 'debug'

-- require('lspconfig.configs').tekton = {
--     default_config = {
--         cmd = { "tekton-ls" },
--         filetypes = { 'yaml' },
--         root_dir = util.root_pattern(".git"),
--         settings = {},
--     }
-- }
-- require('lspconfig').tekton.setup {}

require('lspconfig').yamlls.setup {
    settings = {
        yaml = {
            format = {
                enable = true,
                singleQuote = true,
                printWidth = 120,
            },
            hover = true,
            completion = true,
            validate = true,
            schemas = {
                kubernetes = { "*.yaml", "*.yml" },
            },
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/json",
            },
        }
    }
}

lsp.skip_server_setup({ 'rust_analyzer' })

lsp.setup()

local rust_tools = require('rust-tools')

rust_tools.setup({
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
        end
    }
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' },
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    }
})

local lspconfig = require('lspconfig')
lspconfig.pyright.setup({
    root_dir = function(fname)
        return vim.fn.getcwd()
    end,
    settings = {
    },
})
