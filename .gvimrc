
gui
if has("mac")
    set guifont="Ricty Diminished Discard 12"
elseif has("linux")
    set guifont="Ricty Diminished Discard 12"
elseif has("win32")
    set guifont=Inconsolata:h12:cSHIFTJIS
    set guifontwide=MeiryoKe_Console:h11:cSHIFTJIS
    set transparency=180
endif

set lines=40
set columns=120


colorscheme desert
set guioptions-=Tm
