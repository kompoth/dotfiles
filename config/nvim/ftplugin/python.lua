-- Fixes weird indent behaviour after opening parenthesis 
vim.g.pyindent_open_paren = vim.bo.shiftwidth

require("dap-python").setup("debugpy-adapter")
