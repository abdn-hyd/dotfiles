return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        stylua = { enabled = false },
        lua_ls = {
          mason = true,
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        ruff = { enabled = false },
        basedpyright = {
          mason = true,
          filetypes = { "python" },
          settings = {
            basedpyright = {
              analysis = vim.tbl_deep_extend("force", {}, {
                typeCheckingMode = "basic",
                diagnosticSeverityOverrides = {
                  reportPrivateImportUsage = "none",
                  reportAttributeAccessIssue = "none",
                },
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                autoSearchPaths = true,
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                  callArgumentNames = true,
                },
              }),
            },
          },
        },
      },
    },
  },
}
