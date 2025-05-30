-- plugin setup and configuration

local config_path = "~/.config/nvim/plugins/"
if jit.os == "Windows" then
    config_path = "~/AppData/Local/nvim/plugins/"
end

-- tokyonight theme
vim.cmd.colorscheme("tokyonight")

-- which-key
local wk = require("which-key")
wk.setup({ preset = "helix" })

-- lualine
local lualine = require("lualine")
lualine.setup()

-- hop
require("hop").setup()

-- neogit
local neogit = require("neogit")
neogit.setup()

-- nvim-tree
require("nvim-tree").setup()

-- treesitter
require("nvim-treesitter").setup({
    -- enable better syntax highlighting
    highlight = {
        enable = true,
    },
    -- enable indentation
    indent = {
        enable = true,
    },
    ensure_installed = {
        "json",
        "lua",
        "rust",
        "c",
        "python",
        "bash",
        "markdown"
    }
})

-- indentguide
require("ibl").setup()

-- autopairs
require("nvim-autopairs").setup()

-- comment
require('Comment').setup({
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = '<space>c',
        ---Block-comment toggle keymap
        block = '<space>C',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = '<space>c',
        ---Block-comment keymap
        block = '<space>C',
    },
})

-- lspconfig
local lspconfig = require("lspconfig")
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.diagnostic.config({ virtual_text = true })

-- setup Rust
lspconfig.rust_analyzer.setup {
    capabilities = lsp_capabilities,
    settings = {
        ['rust-analyzer'] = {
            cargo = { all_features = true },
            checkOnSave = {
                command = "clippy",
            },
        },
    }
}

-- setup lua
lspconfig.lua_ls.setup({
    capabilities = lsp_capabilities,
})

-- autocomplete stuff
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local cmp = require('cmp')

local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer",   keyword_length = 3 },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),

        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),
    },
})
