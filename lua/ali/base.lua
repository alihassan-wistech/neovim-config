---@diagnostic disable-next-line: undefined-global
local vim = vim

local opt = vim.opt

-- Line Numbers
opt.number = true            -- Show absolute line number on current line
opt.relativenumber = false -- Show relative numbers on other lines
opt.signcolumn = "yes"       -- Always show the side column (prevents 'jumping')

-- Tabs & Indentation
opt.tabstop = 4              -- 1 tab = 4 spaces
opt.shiftwidth = 4           -- Number of spaces for auto-indent
opt.expandtab = true         -- Use spaces instead of tabs
opt.smartindent = true       -- Insert indents automatically

-- Search Behavior
opt.ignorecase = true        -- Ignore case when searching
opt.smartcase = true         -- Don't ignore case if search has capitals
opt.hlsearch = false         -- Remove highlight after search is done

-- UI & Performance
opt.termguicolors = true     -- Enable 24-bit RGB colors (important for Alacritty)
opt.cursorline = true        -- Highlight the line the cursor is on
opt.scrolloff = 8            -- Keep 8 lines above/below cursor when scrolling
opt.mouse = "a"              -- Allow mouse support (useful for resizing)
opt.clipboard = "unnamedplus" -- Use system clipboard (requires xclip/wl-clipboard)


if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0
    vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h:16"
end
