-- Test running. The LazyVim neotest stack (+ the <leader>t keymaps) is enabled
-- via the `lazyvim.plugins.extras.test.core` extra in lazyvim.json; this file
-- adds the C#/.NET adapter, wired to the coreclr dap adapter from dap.lua so
-- `<leader>td` debugs the test under the cursor.

return {
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
