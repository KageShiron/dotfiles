set lines=40
set columns=120

if(has("unix"))
    set guifont=Inconsolata\ Medium\ 15"
elseif( has("win") )
    set guifont=Inconsolata:h12:cSHIFTJIS
    set guifontwide=MeiryoKe_Console:h11:cSHIFTJIS
endif

gui
if( has("kaoriya"))
    set transparency=180
end
colorscheme desert
set guioptions-=Tm
