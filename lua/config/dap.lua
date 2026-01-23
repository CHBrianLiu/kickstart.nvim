-- Language-specific debug adapter configurations
local dap = require 'dap'
local mason_registry_ok, mason_registry = pcall(require, 'mason-registry')

-- Python debugging
local debugpy_path = nil
if mason_registry_ok and mason_registry.has_package 'debugpy' then
  local debugpy = mason_registry.get_package 'debugpy'
  if debugpy and debugpy:is_installed() then
    debugpy_path = vim.fn.expand '$MASON/packages/debugpy' .. '/venv/bin/python'
  end
end

dap.adapters.python = {
  type = 'executable',
  command = debugpy_path or 'python',
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

-- Go debugging
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = { 'dap', '-l', '127.0.0.1:${port}' },
  },
}

dap.configurations.go = {
  {
    type = 'delve',
    name = 'Debug',
    request = 'launch',
    program = '${file}',
  },
  {
    type = 'delve',
    name = 'Debug test',
    request = 'launch',
    mode = 'test',
    program = '${file}',
  },
  {
    type = 'go',
    name = 'Debug test (all)',
    request = 'launch',
    mode = 'test',
    program = './${relativeFileDirname}',
  },
}
