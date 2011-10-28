"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                                 VIMRC FILE                              """
"""                                                                         """
"""               Author : Andrew Watson <andy@watsons.ch>                  """
"""                                                                         """
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""" LANGUAGE-DEPENDENT INDENTATION ***
        filetype plugin indent on

" Pathogen {
  filetype off

  " place all addons in .vim/bundles
  call pathogen#runtime_append_all_bundles()
  call pathogen#helptags()
" }

" General {
  set ttyfast                           " Ensure smoother transitions
  set backspace=indent,eol,start        " Allow backspacing over everything
  set nocompatible                      " Break compatilibity with vi
  set fileencoding=utf-8                " UTF-8 should be the default encoding
  set clipboard=unnamedplus             " Share clipboard between windows

" }

" UI {
  set t_Co=256                          " 256 colours in terminal!
  colorscheme vibrant_new               " set colour scheme
  set wildmenu                          " 'graphical' menu in the status bar
  set mouse=a                           " allow use of mouse
  set number                            " line numbering
  set ruler                             " show the cursor position all the time
  set showcmd                           " display incomplete commands
  set showmatch                         " highlight matching brackets
  set background=dark                   " run in dark terminal mode
  syntax on                             " enable syntax detection
  set cursorline                        " coloured line to show cursor position
  hi cursorline guibg=#333333           " make that line dark
  if version >= 703                     " new stuff for vim 7.0.3
    set colorcolumn=80                  " line length marker
    set rnu                             " relative line numbering
  endif
" }

" GUI options {
  if has("gui_running")
    set columns=555                     " maximize window
    set lines=555                       " maximize window
    set guioptions-=m                   " remove menu bar
    set guioptions-=r                   " remove scrollbar
    set guioptions-=t                   " remove toolbar
  endif
" }

" Formatting {
  map Q gq                              " quick paragraph formatting
  set formatoptions=r                   " insert comment leader after enter
  set formatoptions+=c                  " recognize comments using textwidth
  set formatoptions+=q                  " allow formatting of comments with gq
  set formatoptions+=n                  " recognize numbered lists
  set formatoptions+=1                  " no break after one-letter word
  set formatoptions-=o                  " no comment marker after 'o' or 'O'
  set expandtab                         " replace tabs with spaces
  set shiftround                        " indent to nearest tabstops
  set shiftwidth=2                      " auto-indent amount
  set softtabstop=2                     " number of spaces in a tab
  set tabstop=2                         " number of spaces in an actual tab
  set autoindent                        " enable auto-indentation 
  set smartindent                       " language-dependent indentation
" }

" Folding {
  set foldenable                        " enable folding
  set foldcolumn=3                      " fold markers in left column
  set foldmethod=marker                 " fold by default
  set foldlevelstart=10                 " only fold code after level 10
  set foldmarker={,}                    " C-style folds
" }

" Search {
  set ignorecase smartcase              " see :help 27.1
  set incsearch                         " do incremental searching
  set nohlsearch                        " turn off search highlighting
                                        " Use :hlsearch to use it once.
" }


" set Grep to always generate a filename (for vim-latex)

" Utilities {
  set grepprg=grep\ -nH\ $*             " grep always prefixes the filename
" }

" Latex {
  let g:tex_flavor='latex'              " fix for vim-latex on empty .tex files
" }

" Doxygen {
  let g:load_doxygen_syntax=1            " load syntax highlighting by default
  let g:DoxygenToolkit_briefTag_pre="@brief  "
  let g:DoxygenToolkit_paramTag_pre="@param "
  let g:DoxygenToolkit_returnTag="@returns   "
  let g:DoxygenToolkit_authorName="Andrew Watson (andy@watsons.ch)"
  let g:DoxygenToolkit_licenseTag="My own license"
" }


""" ADD-ONS ***
filetype plugin on
filetype indent on
let mapleader = "§"


""" FILETYPES ***
au FileType tex         call FT_latex()
au FileType ruby        call FT_ruby()
au FileType c           call FT_c()
au FileType python      call FT_python()

" Special functions for AVR C source files
au BufRead,BufNewFile */avr/*.[ch] call FT_avr()
au BufRead,BufNewFile */avr/*.cpp call FT_avr()

" Temp functions for c tutorials
au BufRead,BufNewFile */learning-c/*.c call FT_lrnc()

" Coloured syntax for apache2 config files
au BufRead,BufNewFile /etc/apache2/* set syntax=apache

au FileType mkd         call FT_markdown()

function FT_markdown()
        set ai formatoptions=tcroqn2 comments=n:&gt;
endfunction



""" LATEX-SUITE ***

function FT_latex()
  " Specific LaTeX commands
  "
  " Compile and display a tex file WITH BIBLIOGRAPHY
"map <F3> :w<CR>:!pdflatex % && pdflatex % && bibtex %:t:r
"    \ && pdflatex % && evince %:t:r.pdf<CR>

map <F3> :w<CR>:!make pdf<CR>
map <F12> :w<CR>:!make pdfquiet<CR>
map <S-F12> :w<CR>:!make bib<CR>

" parse tex files for todo items
map <F10> :!make todo<CR>

endfunction



""" NAVIGATION ***

" spacebar moves forward one screen
map <space> <c-f>
" backspace moves back one screen
map <backspace> <c-b>

" use - to jump between windows in split mode
map - <c-w>w

" navigate errors
map <F2> :cp<CR>
map <F3> :cn<CR>

""" CODE COMMENTING ***

":map <F2> I/*<esc>A*/<esc>       " PHP, CSS, C comment

":map <F3> 0f*Xx$F*df/          " uncomment

""" FILE BROWSER ***

map <F4> :vertical split .<CR>:vertical resize 30<CR>

""" C Project keys ***

function FT_c()
  map <F5> :w<CR>:make<CR>
endfunction

" make && launch project
" map <F5> :w<CR>:!make && ./project.x<CR>

" lazy mode - return to vim directly
" map <F6> :w<CR>:!make && ./project.x<CR><CR>
"
function FT_lrnc()
  map <F5> :w<CR>:!gcc -Wall % -o %:t:r.x && ./%:t:r.x<CR>
  retab 4 | set shiftwidth=4
  set expandtab
  set tabstop=4
  set softtabstop=4
endfunction


""" AVR MICROCONTROLLER keys ***

function FT_avr()

  call FT_lrnc()
  "echo "Including AVR C macros! F5 to make hex, F6 to download"
  " make hex file
  map <F5> :w<CR>:make hex<CR>

  " make hex and download to microcontroller
  map <F6> :w<CR>:make install<CR>

endfunction


""" REPLACE THOSE FOR RAILS ***
function FT_rails()

  " Phusion passenger : save all and restart server
  map <F3> :wall<CR>:!touch tmp/restart.txt<CR><CR>
  " TODO : make this less of a hack (base dir)

  " run default rake action (usually unit test)
  map <F5> :Rake<CR>

  " run all tests
  map <F6> :Rake test<CR>
endfunction 

""" TABBED EDITING ***

map  <F7> :tabprevious<CR>
map  <F8> :tabnext<CR>

nnoremap <silent> <F9> :TlistToggle<CR>
" exit if taglist is the last window open
let Tlist_Exit_OnlyWindow = 1
" only show tags for the current buffer
let Tlist_Show_One_File = 1

""" SESSIONS ***

map <F10> :mksession! session.vim<CR>
map <F11> :source session.vim<CR>:tabdo :windo :e<CR>
map <C-F11> :tabdo :windo :e<CR>
" :td :wd :e makes vim reload all files,
" necessary for the rails plugin to work

try
  source session.vim
catch /E484:/
  "echo "couldn't find session.vim in current folder"
endtry

" quit close all files
map <C-F12> :qall<CR>

" save and quit all files
map <A-F12> :wqall<CR>



""" RAILS CONFIGURATION ***

let g:rails_level=4
let g:rails_subversion=1

iab forin for @element@ in @collection@<CR>@element@.@@<CR>end<Esc><<kk/@[^@]*<CR>li

imap <S-Tab> <Esc>/@[^@]*@/<CR>li
imap <S-Del> <Esc>ld/@<CR>xF@x/@[^@]*@<CR>li<C-Y>

autocmd BufNewFile,BufRead *.dryml setlocal filetype=eruby
autocmd BufNewFile,BufRead *.dryml syn match htmlTagName contained "\<\([a-zA-Z0-9_]\+\)\>"

""" RUBY ***
"autocmd Filetype ruby source ~/.vim/ruby-macros.vim
"au Filetype ruby map <F10> !ruby %<CR>

""" RUBY CONFIGURATION ***

function FT_ruby()
  source ~/.vim/ruby-macros.vim
  map <F5> :w<CR>:!ruby %<CR>
endfunction

""" PYTHON CONFIGURATION ***

function FT_python()
  "source ~/.vim/python-macros.vim " ( file doesn't exist yet)
  map <F5> :w<CR>:!python %<CR>
  map <F6> :w<CR>:!python3 %<CR>
  " make sure Python source code is tabbed correctly
  " changed from 2 to 4. cf. PEP 8
  retab 4 | set shiftwidth=4
  set expandtab
  set tabstop=4
  set softtabstop=4
  " max line width = 79 (PEP 8)
  " recommended 72 for flowing text (docstrings & comments)
  set tw=79
endfunction

"" LILYPOND

set runtimepath+=/usr/share/lilypond/2.10.5/vim/
