-- ~/.config/nvim/lua/ali/plugins.lua

require("lazy").setup({
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
      -- Directly calling the main module (not .configs)
      require("nvim-treesitter").setup({
        ensure_installed = { "php", "javascript", "typescript", "html", "css", "lua", "json" },
        highlight = { enable = true },
        indent = { enable = true },
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
          ['<C-Space>'] = cmp.mapping.complete(),
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
              ["<C-k>"] = "move_selection_previous"
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
        view = { width = 40, side = "left" }
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
