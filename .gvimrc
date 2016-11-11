if(has("win"))
    set guifont=Inconsolata:h12:cSHIFTJIS
    set guifontwide=MeiryoKe_Console:h11:cSHIFTJIS
else
    set guifont=Inconsolata\ Medium\ 12
end
set lines=40
set columns=120


gui
if( has("kaoriya"))
    set transparency=180
end
colorscheme desert
set guioptions-=Tm
