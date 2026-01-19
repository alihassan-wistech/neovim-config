---@diagnostic disable-next-line: undefined-global
local vim = vim
local keymap = vim.keymap
local builtin = require("telescope.builtin")

-- Ctrl + p: Search files (Like VS Code/Sublime)
keymap.set('n', '<C-p>', builtin.find_files, { desc = "Fuzzy find files" })

-- Ctrl + f: Live Grep (Search text inside all files)
-- Note: Requires 'ripgrep' installed on your system
keymap.set('n', '<C-f>', builtin.live_grep, { desc = "Search text in project" })

-- Ctrl + b: Search open buffers (Current open files)
keymap.set('n', '<C-b>', builtin.buffers, { desc = "Search buffers" })

-- Ctrl + h: Search help tags
keymap.set('n', '<C-S-h>', builtin.help_tags, { desc = "Search help" })
-- 1. SAVE OPERATIONS (Ctrl + s)

-- Save in Normal and Visual Mode
keymap.set({'n', 'v'}, '<C-s>', '<cmd>write<CR>', { desc = "Save file" })
-- Save in Insert Mode (Escapes, saves, then goes back to Insert mode)
keymap.set('i', '<C-s>', '<Esc><cmd>write<CR>', { desc = "Save file" })

-- 2. SELECTION (Ctrl + a)
-- Select all text in the file across all modes
keymap.set({'n', 'v', 'i'}, '<C-a>', '<Esc>ggVG', { desc = "Select all" })

-- 3. FILE EXPLORER (Ctrl + e)
-- Toggle the file explorer
keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
-- keymap.set("n", "<C-e>", "<cmd>NvimTreeFocus<CR>", { desc = "Toggle Explorer" })

-- 4. WINDOW MANAGEMENT (Ctrl + v, h, x)
-- Vertical split
keymap.set("n", "<C-v>", "<cmd>vsplit<CR>", { desc = "Split Vertical" })
-- Horizontal split
keymap.set("n", "<C-h>", "<cmd>split<CR>", { desc = "Split Horizontal" })
-- Close split
keymap.set("n", "<C-x>", "<cmd>close<CR>", { desc = "Close Split" })

-- 5. NAVIGATION BETWEEN SPLITS (Standard Ctrl + hjkl)
keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')
keymap.set('n', '<C-l>', '<C-w>l')

-- 6. SEARCH & REPLACE (Ctrl + r + p)
-- This replaces the word under the cursor globally
keymap.set("n", "<C-r>p", ":%s/\\<<C-r><C-w>\\>/", { desc = "Replace word under cursor" })

-- 7. MODE TOGGLES (Ctrl + Space)
-- Enter/Exit Insert mode
keymap.set({'n', 'v'}, '<C-Space>', 'i', { desc = "Enter Insert Mode" })
keymap.set({'n', 'v'}, '<C-@>', 'i') 
keymap.set('i', '<C-Space>', '<Esc>', { desc = "Exit Insert Mode" })
keymap.set('i', '<C-@>', '<Esc>')

-- Go to definition on F12
-- Normal mode: jumps to the code
keymap.set('n', '<F12>', require('telescope.builtin').lsp_definitions, { desc = "LSP: Go to Definition" })

-- Optional: Go to declaration or type definition on Shift+F12
keymap.set('n', '<S-F12>', require('telescope.builtin').lsp_type_definitions, { desc = "LSP: Type Definition" })

-- F2: Rename variable (Global rename)
keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = "LSP: Rename variable" })

-- Alt + Enter: Code Actions (Fix errors/Import classes)
keymap.set('n', '<A-CR>', vim.lsp.buf.code_action, { desc = "LSP: Code Actions" })
