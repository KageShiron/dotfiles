#Include %A_ScriptDir%
#Include IME.ahk
AppsKey::MButton
F24 & q:: Send, {!}
F24 & w:: Send,@
F24 & e:: Send,{#}
F24 & r:: Send,$
F24 & t:: Send,`%
F24 & y:: Send,{^}
F24 & u:: Send,&
F24 & i:: Send,*
F24 & o:: Send,(
F24 & p:: Send,)
F24 & a:: Send,{Tab}
F24 & s:: Send,{{}
F24 & d:: Send,{}}
F24 & f:: Send,{Esc}
F24 & g:: 
IME_SET(0)
return
F24 & z:: Send,\
F24 & x:: Send,~
F24 & h::AltTab
F24 & j::Up
F24 & k:: Send, {Down}
F24 & l:: Send, {Right}
F24 & BS:: Send, {Del}

