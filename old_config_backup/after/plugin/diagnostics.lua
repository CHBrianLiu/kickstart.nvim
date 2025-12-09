-- Diagnostic icons
for name, icon in pairs { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' } do
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
