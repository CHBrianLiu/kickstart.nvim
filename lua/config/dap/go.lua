local dap = require 'dap'

if vim.fn.executable 'dlv' == 0 then
  return
end

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
