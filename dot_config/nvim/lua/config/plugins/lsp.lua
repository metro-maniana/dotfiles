return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    config = function()
      vim.lsp.config('*', {
        capabilities = {
          textDocument = {
            semanticTokens = {
              multilineTokenSupport = true,
            },
          },
        },
        root_markers = { ".git" },
      })

      vim.lsp.config("tailwindcss", {})
      vim.lsp.config("ts_ls", {})
      vim.lsp.config("lua_ls", {})
      vim.lsp.config('pyrefly', {
        settings = {
          pyrefly = {

          }

        },
        filetypes = { "python" },
      })
      vim.lsp.config("djlsp", {})
      vim.lsp.config("ruff", {})

      vim.lsp.config("rust-analyzer", {
        cmd = { "rust-analyzer" },
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            procMacro = {
              enable = true,
            },
            checkOnSave = true,
          },
        },
        filetypes = { "rust" },
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
        desc = "LSP: Disable hover capability from Ruff",
      })

      vim.lsp.enable({
        "lua_ls",

        "zls",
        "rust-analyzer",

        "tailwindcss",
        "ts_ls",

        "djlsp",
        "ruff",
        "pyrefly",
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
