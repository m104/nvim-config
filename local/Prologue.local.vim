" enable 24-bit color
set termguicolors

let g:jellybeans_use_lowcolor_black = 1
let g:jellybeans_overrides = {
\    'Todo': { 'guifg': 'ffb964',
\              'ctermfg': 'Yellow',
\              'attr': 'bold' }
\}

colorscheme jellybeans

" black Python code formatter max line length
let g:black_linelength=110

" run black formatter before saving python files
autocmd BufWritePre *.py execute ':Black'
