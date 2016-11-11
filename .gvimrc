<<<<<<< HEAD
if has("max")
    set guifont="Ricty Diminished Discard 12"
elseif has("linux")
    set guifont="Ricty Diminished Discard 12"
elseif has("win")
    set guifont=Inconsolata:h12:cSHIFTJIS
    set guifontwide=MeiryoKe_Console:h11:cSHIFTJIS
    set transparency=180
endif

=======
if(has("win"))
    set guifont=Inconsolata:h12:cSHIFTJIS
    set guifontwide=MeiryoKe_Console:h11:cSHIFTJIS
else
    set guifont=Inconsolata\ Medium\ 12
end
>>>>>>> some fix for linux
set lines=40
set columns=120


gui
colorscheme desert
set guioptions-=Tm
