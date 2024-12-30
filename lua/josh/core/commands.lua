vim.cmd([[command! LsModified lua vim.fn.execute('buffers | filter "&modified" ls!')]])
