-- Keybinds using which-key

local wk = require("which-key")

vim.g.mapleader = " "

wk.add({
    mode = { "n", "v" },
    -- File related keymaps
    { "<leader>f",        group = "file" },
    { "<leader>fe",       vim.cmd.Ex,                desc = "open explorer" },
    { "<leader>ff",       "<cmd>Files<cr>",          desc = "Find file" },
    { "<leader>fg",       "<cmd>Rg<cr>",             desc = "Find file using RipGrep" },

    -- Buffer  related keymaps
    { "<leader>b",        group = "buffer" },
    { "<leader>bb",       "<cmd>Buffers<cr>",        desc = "List open buffers" },
    { "<leader>bs",       "<cmd>w<cr>",              desc = "Save buffer" },
    { "<leader>bk",       "<cmd>q<cr>",              desc = "Close buffer" },

    -- Vim fugitive
    { "<leader>g",        group = "git" },
    { "<leader>gs",       "<cmd>Neogit<cr>",         desc = "Git status" },
    { "<leader>gc",       "<cmd>Neogit commit<cr>",  desc = "Git commit" },

    -- Window related command
    { "<leader>w",        group = "window" },
    { "<leader>we",       "<cmd>NvimTreeToggle<cr>", desc = "Toggle explorer" },
    { "<leader>ww",       "<C-w>w",                  desc = "Switch window" },
    { "<leader>wv",       "<cmd>vsplit<cr>",         desc = "Split window vertically" },
    { "<leader>ws",       "<cmd>split<cr>",          desc = "Split window" },
    { "<leader>wt",       "<cmd>terminal<cr>",       desc = "Open terminal in current window" },
    { "<C-h>",            "<C-w>h",                  desc = "Switch window left" },
    { "<C-l>",            "<C-w>l",                  desc = "Switch window right" },
    { "<C-j>",            "<C-w>j",                  desc = "Switch window down" },
    { "<C-k>",            "<C-w>k",                  desc = "Switch window up" },

    -- Others
    { "<leader>q",        group = "quit" },
    { "<leader>qq",       "<cmd>qa<cr>",             desc = "Quit all" },
    { "s",                require("hop").hint_words, desc = "Jump to a word" },
    { "<leader>e",        "<cmd>NvimTreeFocus<cr>",  desc = "Focus explorer" },
    { "<leader><leader>", "<cmd>Commands<cr>",       desc = "Search for commands" },

    {
        -- not working ?
        { "<leader>c", "gcc", desc = "Comment current line",       mode = "n" },
        { "<leader>C", "gbc", desc = "Block comment current line", mode = "n" },
        { "<leader>c", "gc",  desc = "Comment selection",          mode = "v" },
        { "<leader>C", "gb",  desc = "Block comment selection",    mode = "v" },
    }
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = "LSP actions",
    callback = function()
        wk.add({
            mode = { "n", "v" },
            { "K",    "<cmd>lua vim.lsp.buf.hover()<cr>",          desc = "Display hover information" },
            { "gd",   "<cmd>lua vim.lsp.buf.definition()<cr>",     desc = "Jump to definition" },
            { "gD",   "<cmd>lua vim.lsp.buf.declaration()<cr>",    desc = "Jump to declaration" },
            { "gi",   "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "List all implementations" },
            { "gr",   "<cmd>lua vim.lsp.buf.references()<cr>",     desc = "List all references" },
            { "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>",         desc = "Rename all occurences" },
            { "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>",    desc = "Select a code action available" },

            { "gl",   "<cmd>lua vim.diagnostic.open_float()<cr>",  desc = "Show diagnostic" },
            { "[d",   "<cmd>lua vim.diagnostic.goto_prev()<cr>",   desc = "Go to the previous diagnostic" },
            { "]d",   "<cmd>lua vim.diagnostic.goto_next()<cr>",   desc = "Go to the next diagnostic" },
        })

        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
    end
})
