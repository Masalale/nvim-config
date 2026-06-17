-- Test running. Enables LazyVim's neotest stack (+ the <leader>t keymaps) and
-- adds the C#/.NET adapter, wired to the coreclr dap adapter from dap.lua so
-- `<leader>td` debugs the test under the cursor.

return {
  { import = "lazyvim.plugins.extras.test.core" },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "Issafalcon/neotest-dotnet" },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          dap = { adapter_name = "coreclr" },
        },
      },
    },
  },
}
