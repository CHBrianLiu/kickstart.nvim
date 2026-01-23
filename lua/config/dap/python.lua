local dap = require 'dap'
local mason_registry_ok, mason_registry = pcall(require, 'mason-registry')

if not mason_registry_ok then
  return
end

if not mason_registry.has_package 'debugpy' then
  return
end

local debugpy = mason_registry.get_package 'debugpy'
if not debugpy:is_installed() then
  return
end

local debugpy_path = vim.fn.expand '$MASON/packages/debugpy' .. '/venv/bin/python'

dap.adapters.python = {
  type = 'executable',
  command = debugpy_path,
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      -- Use python3 if available, otherwise python
      if vim.fn.executable 'python3' == 1 then
        return 'python3'
      else
        return 'python'
      end
    end,
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Launch with arguments',
    program = '${file}',
    args = function()
      local args_string = vim.fn.input 'Arguments: '
      return vim.split(args_string, ' ')
    end,
    pythonPath = function()
      if vim.fn.executable 'python3' == 1 then
        return 'python3'
      else
        return 'python'
      end
    end,
  },
}
