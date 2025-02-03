return {
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--header-insertion=never",
            "--query-driver=/usr/bin/clang++,/opt/homebrew/opt/llvm/bin/clang++", -- Update to your drivers
            "--compile-commands-dir=./project_native", -- Path to compile_commands.json
          },

          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true -- Enable formatting
            local buf_map = vim.api.nvim_buf_set_keymap
            local opts = { noremap = true, silent = true }
            buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            buf_map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            buf_map(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format File" })
          end,
        },
      },
    },
  },

  -- Autocompletion - optional, TBD
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     { "hrsh7th/cmp-nvim-lsp" },
  --     { "hrsh7th/cmp-buffer" },
  --     { "hrsh7th/cmp-path" },
  --     { "L3MON4D3/LuaSnip" },
  --   },
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
  --       { name = "path" }, -- File path suggestions
  --       { name = "buffer" }, -- Suggestions from the current buffer
  --     }))
  --     opts.mapping = cmp.mapping.preset.insert({
  --       ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
  --       ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
  --       ["<Tab>"] = cmp.mapping.select_next_item(), -- Next suggestion
  --       ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
  --     })
  --   end,
  -- },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "cpp", "c" }) -- Add parsers for C and C++
    end,
  },
}
