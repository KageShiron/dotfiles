#Include %A_ScriptDir%
#Include IME.ahk

get_modifiers() {
	modifiers := ""
	if GetKeyState("Ctrl", "P")
		modifiers = %modifiers%^
	if GetKeyState("Shift", "P")
		modifiers = %modifiers%+
	if GetKeyState("Alt", "P")
		modifiers = %modifiers%!
	if GetKeyState("Win", "P")
		modifiers = %modifiers%`#
	return %modifiers%
}

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
F24 & a::
    modifiers := get_modifiers()
    Send, %modifiers%{Tab}
    return
F24 & s:: Send,{{}
F24 & d:: Send,{}}
F24 & f:: IME_SET(0)
F24 & g:: IME_SET(1)
F24 & z:: Send,\
F24 & x:: Send,~
F24 & h::
    modifiers := get_modifiers()
    Send, %modifiers%{Left}
    return
F24 & j::
    modifiers := get_modifiers()
    Send, %modifiers%{Up}
    return
F24 & k::
    modifiers := get_modifiers()
    Send, %modifiers%{Down}
    return
F24 & l::
    modifiers := get_modifiers()
    Send, %modifiers%{Left}
    return

F24 & BS:: Send, {Del}

