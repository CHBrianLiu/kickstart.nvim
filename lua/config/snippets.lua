local ls = require 'luasnip'
local postfix = require('luasnip.extras.postfix').postfix
local f = ls.function_node
local i = ls.insert_node
local t = ls.text_node

-- Python Postfix Snippets
ls.add_snippets('python', {
  postfix('.print', {
    f(function(_, parent) return 'print(' .. parent.snippet.env.POSTFIX_MATCH .. ')' end, {}),
  }),
  postfix('.if', {
    f(function(_, parent) return 'if ' .. parent.snippet.env.POSTFIX_MATCH .. ':' end, {}),
    t { '', '    ' },
    i(0),
  }),
  postfix('.while', {
    f(function(_, parent) return 'while ' .. parent.snippet.env.POSTFIX_MATCH .. ':' end, {}),
    t { '', '    ' },
    i(0),
  }),
  postfix('.for', {
    t 'for ',
    i(1, 'item'),
    t ' in ',
    f(function(_, parent) return parent.snippet.env.POSTFIX_MATCH .. ':' end, {}),
    t { '', '    ' },
    i(0),
  }),
  postfix('.len', {
    f(function(_, parent) return 'len(' .. parent.snippet.env.POSTFIX_MATCH .. ')' end, {}),
  }),
  postfix('.return', {
    f(function(_, parent) return 'return ' .. parent.snippet.env.POSTFIX_MATCH end, {}),
  }),
  postfix('.par', {
    f(function(_, parent) return '(' .. parent.snippet.env.POSTFIX_MATCH .. ')' end, {}),
  }),
  postfix('.br', {
    f(function(_, parent) return '[' .. parent.snippet.env.POSTFIX_MATCH .. ']' end, {}),
  }),
})

-- Go Postfix Snippets (mimicking some gopls features or adding new ones)
ls.add_snippets('go', {
  postfix('.print', {
    f(function(_, parent) return 'fmt.Println(' .. parent.snippet.env.POSTFIX_MATCH .. ')' end, {}),
  }),
})
