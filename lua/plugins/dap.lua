-- C# / .NET debugging. The LazyVim DAP stack (nvim-dap, dap-ui, virtual-text,
-- mason-nvim-dap + the <leader>d / F5-F11 keymaps) is enabled via the
-- `lazyvim.plugins.extras.dap.core` extra in lazyvim.json; this file just wires
-- the netcoredbg adapter you install via Mason.

return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      -- Prefer the Mason-installed binary; fall back to one on $PATH.
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"
      dap.adapters.coreclr = dap.adapters.coreclr
        or {
          type = "executable",
          command = vim.fn.executable(mason_bin) == 1 and mason_bin or "netcoredbg",
          args = { "--interpreter=vscode" },
        }

      -- Auto-pick the freshest build dll under the project; prompt if none found.
      local function dll_path()
        local root = LazyVim.root()
        local newest, newest_mt = nil, -1
        for _, f in ipairs(vim.fn.glob(root .. "/**/bin/Debug/**/*.dll", true, true)) do
          if not f:match("%.deps%.dll$") then
            local mt = vim.fn.getftime(f)
            if mt > newest_mt then
              newest, newest_mt = f, mt
            end
          end
        end
        return newest or vim.fn.input("Path to dll: ", root .. "/bin/Debug/", "file")
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch (netcoredbg)",
          request = "launch",
          program = dll_path,
        },
      }
    end,
  },
}
