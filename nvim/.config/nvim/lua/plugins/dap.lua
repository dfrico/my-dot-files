-- dont need debugging for now
if true then
  return {}
end

return {
  -- Debugging
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      -- DAP UI setup
      -- optionally - customize layouts
      -- dapui.setup({
      --   layouts = {
      --     {
      --       elements = {
      --         { id = "scopes", size = 0.3 },
      --         { id = "breakpoints", size = 0.2 },
      --         { id = "stacks", size = 0.3 },
      --         { id = "watches", size = 0.2 },
      --       },
      --       size = 40,
      --       position = "left",
      --     },
      --     {
      --       elements = {
      --         "repl",
      --         "console",
      --       },
      --       size = 10,
      --       position = "bottom",
      --     },
      --   },
      -- })
      dapui.setup()

      -- Open/close DAP UI automatically
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- DAP configuration for LLDB
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- Update path if needed
        name = "lldb",
      }

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
    end,
  },
}
