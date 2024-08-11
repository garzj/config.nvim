local o = vim.opt

o.shortmess:append("I")

o.nu = true
o.relativenumber = true
o.signcolumn = "yes"

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true

o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.scrolloff = 8
o.wrap = false

o.colorcolumn = "80"

o.updatetime = 100

o.undofile = true

o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

o.isfname:append("@-@")
o.termguicolors = true
