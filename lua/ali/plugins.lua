---@diagnostic disable-next-line: undefined-global

local vim = vim
require("lazy").setup({
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
        }
    },
    {
        "xiyaowong/transparent.nvim",
        config = function()
            require("transparent").setup({
                -- table: default groups
                groups = {
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer',
                },
                -- table: additional groups that should be cleared
                extra_groups = {
                    "TelescopeNormal",
                    "TelescopeBorder",
                    "TelescopePromptBorder",
                    "TelescopeResultsBorder",
                    "NvimTreeNormal",
                    "NvimTreeNormalNC",
                    "NvimTreeEndOfBuffer",
                    "NvimTreeWinSeparator",
                    "TelescopePreviewBorder",
                    "Pmenu", -- The suggestion list background
                    -- "PmenuSel", -- The selected item (you might want to keep a color here!)
                    -- "PmenuSbar", -- The scrollbar
                    -- "PmenuThumb", -- The scrollbar handle
                    "CmpDoc",       -- The documentation window background
                    "CmpDocBorder", -- The border of the doc window
                    "NormalFloat",  -- General floating windows
                    "FloatBorder",  -- General borders
                    "lualine_c_normal",
                    "lualine_c_insert",
                    "lualine_c_visual",
                    "lualine_c_replace",
                    "lualine_c_command",
                    "lualine_c_inactive",
                },
                -- table: groups you don't want to clear
                exclude_groups = {},
                -- function: code to be executed after highlight groups are cleared
                -- Also the user event "TransparentClear" will be triggered
                on_clear = function() end,
            })
        end
    },
    { 'mg979/vim-visual-multi', branch = 'master' },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use main branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty for defaults
            })
        end
    },
    {
        'stevearc/conform.nvim',
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    enable_close = true,
                    enable_rename = true, -- Auto-rename closing tag when you change opening tag
                    enable_close_on_slash = true,
                },
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end
    },
    -- 1. THEME: Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },

    -- 2. TREESITTER: High-quality syntax highlighting (Fixed for 2026 API)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- 1. Define the blade parser configuration
            local parser_config = require("nvim-treesitter.parsers")
            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            }

            -- 2. Call setup using your working module name
            require("nvim-treesitter").setup({
                ensure_installed = { "php", "javascript", "typescript", "html", "css", "lua", "json" },
                highlight = { enable = true },
                indent = { enable = true },
                additional_vim_regex_highlighting = false,
            })
        end,
    },

    -- 3. MASON: Binary manager for LSP servers
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- 4. LSP: The "Brain" (Fixed for Neovim 0.11+ Built-in API)
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local mason_lsp = require("mason-lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            mason_lsp.setup({
                ensure_installed = { "intelephense", "tailwindcss", "ts_ls", "lua_ls" }
            })

            -- Modern v0.11 loop: Bypasses problematic 'setup_handlers'
            local servers = { "intelephense", "tailwindcss", "ts_ls", "lua_ls" }

            for _, server in ipairs(servers) do
                -- 1. Define the config in the new built-in table
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
                -- 2. Enable it
                vim.lsp.enable(server)
            end
        end,
    },

    -- 5. AUTO-COMPLETION: The dropdown menu
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args) require('luasnip').lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-a>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                })
            })
        end
    },

    -- 6. UI: Status bar and icons
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = { theme = 'catppuccin' }
            })
        end
    },

    -- 7. FUZZY FINDER: Telescope (Switched to master for Neovim 0.11 compatibility)
    {
        'nvim-telescope/telescope.nvim',
        branch = 'master', -- Use master to get the absolute latest compatibility fixes
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local actions = require("telescope.actions")
            require('telescope').setup({
                defaults = {
                    -- This is the fallback fix:
                    -- If the previewer still crashes, it forces it to use the stable highlighter
                    preview = {
                        treesitter = false,
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            ["<C-d>"] = actions.delete_buffer
                        },
                        n = {
                            ["<C-d>"] = actions.delete_buffer
                        }
                    }
                }
            })
        end
    },

    -- 8. FILE EXPLORER: Nvim-Tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = { width = 40, side = "left" },
                actions = {
                    change_dir = {
                        enable = false,
                        global = false
                    }
                },
                renderer = {
                    highlight_opened_files = "all",
                    root_folder_label = false,
                }
            })
        end
    },

    -- 9. GIT: Signs in the gutter
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },
    -- 10. Errors Panel
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup()
        end
    },
})
