pool()	;init variables
menu.Spot()	;show mSpot
Return
EditMenu:
	Run, Notepad MenuText.txt
	Return
demo1:
	msgbox, this is demo1
	return
demo2:
	msgbox, this is demo2 this is demo2
	return
demo3(){
	msgbox, this is demo3 this is demo3 this is demo3
}
demo4(p){
	msgbox, % p
}
demo5(p1, p2){
	msgbox, % p1 "`n`n=========================`n`n" p2
}

$RButton::keyRButton()
$RButton up::Return
#IfWinActive, Select A Shape Please
	Space::
	Enter::
	`::menu.Pick()
#If

pool(param = "") {	;written by SundayProgrammer
	static
	static clsid1 := "{A3C04B39-0465-4460-8CA0-7BFFF481FF98}", s1l := "a := ComObjActive(""" clsid1 """)`n"
	static dummy1 := "i am param the first"
	static dummy2 := "i am param the second"
If StrLen(param)
	If IsGetSet(param, action, varname, value)
	{	If (action = "Set:")
			%varname% := value
		v := %varname%
		Return v
	}Else{}
Else{
	ObjRegisterActive(agent, clsid1)
	IfExist, MenuText.txt
		FileRead, _menu_, MenuText.txt
	Else{
_menu_=
(
= = = Top = = =
^#{Left}	Switch Desktop	(Send)
^#{Right}	Switch Desktop	(Send)
#{Tab}	Windows Switcher	(Send)
[:\s- Microsoft.+?Edge:] m{Enter}	MyActivity.Google	(Send)
[:\s- Microsoft.+?Edge:] +^u	Rald Toggle	(Send)
^f	Find	(Send)
[:\s- Microsoft.+?Edge:] ^r	Reload Web Page	(Send)
^w	Close Tab	(Send)
[:\s- YouTube:] j	10s Backward	(Send)
[:\s- Microsoft.+?Edge:] !{Left}	Previous Web Page	(Send)
[:\s- Microsoft.+?Edge:] !{Right}	Next Web Page	(Send)
{Enter}	Enter	(Send)
[:\s- YouTube:] f	Fullscreen Toggle	(Send)
{Space}	Space	(Send)
{Del}	Delete	(Send)
{Esc}	Escape	(Send)
[:\s- Sublime Text:] ^g	Go To Line	(Send)
[:\s- Sublime Text:] !d	Duplicate	(Send)
^z	Undo	(Send)
^x	Cut	(Send)
^c	Copy	(Send)
^v	Paste	(Send)
^s	Save File	(Send)
^a	Select All	(Send)
- - - - - - - - - - - - - - - -
Close Menu	{menu.Gui_OnEscape}	Return To mSpot	(Function)
Reload Menu	{menu.Reload}	Reflect The Latest Content	(Function)
Edit Menu	{EditMenu}	(Gosub)
Demo One	{demo1}	hello world	(Gosub)
Demo Two	{demo2}	foobar	(Gosub)
Demo Three	{demo3}	blablabla	(Function)
Demo Four	{demo4}	bla bla	(Func+Param)	dummy1
Demo Five	{demo5}	bla bla bla	(Func+Param)	dummy1,dummy2
Script I	(Script)	msgbox `% "remote: " a.call("var","dummy1@pool")
Script II	(Script)	msgbox `% "remote: " a.call("var","dummy2@pool")
Script III	(Script)	a.call("var","Set:dummy3@pool",a_tickcount)|| ||msgbox `% "remote: " a.call("var","dummy3@pool")
Verify	{demo4}	(Func+Param)	dummy3
Script IV	(Script)	{Apart}
[:Text Filter:RICHEDIT50W1:] Script V	(Script)	{fghij}
Script VI	(Script)	{menuDemo}
= = = Bottom = = =
;
{Script Apart}
a.call("var","Set:dummy3@pool",a_tickcount "(a)")
msgbox `% "remote: " a.call("var","dummy3@pool")
{/Script}

{Script fghij}
a.call("demo5", "p1p", "p2p")
If InStr(a.call("var","dummy3@pool"), "(a)")
	msgbox found "(a)" in dummy3
{/Script}
)
FileAppend, %_menu_%, MenuText.txt, UTF-8
		}
	IfNotExist, menuDemo.ahk
FileAppend, msgbox im an island, menuDemo.ahk, UTF-8
	}
}

IsGetSet(Param, ByRef a, ByRef v, ByRef value) {	;written by SundayProgrammer
	a := SubStr(Param, 1, 4)
	If (a = "Set:") or (a = "Get:")
	{	v := Trim((p := InStr(Param, "=")) ? (SubStr(Param, 5, p - 5), value := SubStr(Param, p + 1)) : SubStr(Param, 5))
		Return True
	}Return False
}
var(name, value = "") {	;written by SundayProgrammer
	global
	local p, a, v, m1, m2, m3, segc
	If p := InStr(name, "@")
	{	a := SubStr(name, 1, 4), v := Trim(SubStr(name, 1, p - 1)), name := Trim(SubStr(name, p + 1))
		If (a = "Set:") or (a = "Get:")
			v := Trim(SubStr(v, 5))
		Else a := StrLen(value) ? "Set:" : "Get:"
		If StrLen(v) and StrLen(name)
		{	v := a v, v .= (a = "Set:") ? "=" value : ""
			If InStr(name, ".")
			{	Loop, Parse, name, .
					m%A_Index% := A_LoopField, segc := A_Index
				If segc = 2
					v := %m1%[m2](v)
				Else If segc = 3
					v := %m1%[m2][m3](v)
				Else v = Error: Segments More Than Allowed.
			}Else v := %name%(v)
		}Else v = Error: Invalid Parameter "%v%@%name%"
	}Else
	{	a := SubStr(name, 1, 4)
		If (a = "Set:") or (a = "Get:")
			name := Trim(SubStr(name, 5))
		If InStr(name, ".")
		{	Loop, Parse, name, .
				m%A_Index% := A_LoopField, segc := A_Index
			If segc = 2
			{	If (a = "Set:") or StrLen(value)
					%m1%[m2] := value
				v := %m1%[m2]
			}Else If segc = 3
			{	If (a = "Set:") or StrLen(value)
					%m1%[m2][m3] := value
				v := %m1%[m2][m3]
			}Else v = Error: Segments More Than Allowed.
		}Else
		{	If (a = "Set:") or StrLen(value)
				%name% := value
			v := %name%
		}
	}
	Return v
}

Class agent {	;written by SundayProgrammer who got the idea from this post https://www.autohotkey.com/boards/viewtopic.php?p=200597#p200597
	Call(name, p*) {	;allows you to call any function in this script
		If InStr(name, ".")
		{	Loop, Parse, name, .
				m%A_Index% := A_LoopField, segc := A_Index
			If segc = 2
				Return %m1%[m2](p*)
			Else If segc = 3
				Return %m1%[m2][m3](p*)
			Else Return "Error: Segments More Than Allowed."
		}Return %name%(p*)
	}
}

#IfWinActive ahk_group SpotMenu
	WheelUp::
	WheelDown::
	+WheelUp::
	+WheelDown::OnScroll(InStr(A_ThisHotkey, "Down") ? 1 : 0, 0, GetKeyState("Shift") ? 0x114 : 0x115, WinExist())
#If

WM_DISPLAYCHANGE() {
	WinGetPos, x, y,,, mSpot
	If (x > A_ScreenWidth - 50)
		x := A_ScreenWidth - 100
	If (y > A_ScreenHeight - 125)
		y := A_ScreenHeight - 175
	Gui, mSpot:Show, x%x% y%y% NoActivate
}

WM_ACTIVATE() {
	IfWinActive, mSpot
		WinSet, TransColor, White, mSpot
	Else WinSet, TransColor, White 64, mSpot
}

Class menu {	;written by SundayProgrammer
Spot() {
	Gui, mSpot:New
	Gui, +LastFound -Caption +AlwaysOnTop +ToolWindow
	Gui, Color, White
	Gui, Margin, 0, 0
	Gui, Font, s150, Consolas
	Gui, Add, Text, x0 y0 cFFB10F BackgroundTrans, ●
	OnSuch := this.HitEvent.Bind(this)
	GuiControl +g, Static1, % OnSuch
	WinSet, TransColor, White 64
	x := A_ScreenWidth - 100, y := A_ScreenHeight - 530
	Gui, Show, x%x% y%y% NoActivate, mSpot
	this.HitEvent() ; Init sPos
	OnMessage(0x7E, "WM_DISPLAYCHANGE")
	OnMessage(0x06, "WM_ACTIVATE")
}
HitEvent(hwnd := "") {
	static sPos
	If not StrLen(sPos)
	{	WinGetPos, x, y,,, mSpot
		sPos := x "," y
	}If not StrLen(hwnd)
		Return sPos
	SendMessage, 0xA1, 2,,, A ; WM_NCLBUTTONDOWN
	GuiControlGet, wHwnd, Hwnd, %hwnd%
	WinGetPos, x, y,,, ahk_id %wHwnd%
	If x "," y = sPos
	{	Gui, mSpot:Hide
		this.SpotMenu(var("_menu_@pool"))
	}Else
	{	sPos := x "," y
		SetTimer, Deactivate, -500
	}Return
	Deactivate:
		Gui, mSpot:Hide
		Gui, mSpot:Show, NoActivate
		WinSet, TransColor, White 64, mSpot
		Return
}
SpotMenu(t) {
	global TT
	WinWaitNotActive, mSpot
	WinGetActiveTitle, sWin
	ControlGetFocus, sCtl, A
	Loop, Parse, t, `n
		If SubStr(Trim(A_LoopField), 1, 1) not = ";"
		If RegExMatch(A_LoopField, "i)^\s*{\s*Script\s+[^}]+?\s*}")
			Break
		Else If RegExMatch(A_LoopField, "[^\t]+(?=\t)", m)
			w%A_Index% := this.GetButtonWidth(Trim(RegExReplace(m, "\s*\[([^\]]+)]")), "30 bold", "Consolas")
	OnMessage(0x115, "OnScroll") ; WM_VSCROLL
	OnMessage(0x114, "OnScroll") ; WM_HSCROLL
	OnMessage(0x20A, "OnScroll") ; WM_MOUSEWHEEL
	OnMessage(0x20E, "OnScroll") ; WM_MOUSEHWHEEL
	OnMessage(0x119, "gHandler") ; WM_GESTURE
	Gui, menu:New, hwndHmenu +Labelmenu.Gui_On
	Gui, +Resize +0x300000	; WS_VSCROLL | WS_HSCROLL
	TT := New GuiControlTips(Hmenu), TT.SetDelayTimes(1000, 15000, -1)
	Gui, Font, s30 bold, Consolas
	ci := nl := 1
	Loop, Parse, t, `n
		If SubStr(Trim(A_LoopField), 1, 1) not = ";"
		If RegExMatch(A_LoopField, "[^\t]+(?=\t)", m)
		{	Passed := False
			If RegExMatch(m, "\s*\[([^\]]+)]", mm)
			If RegExMatch(Trim(mm1), ":([^:]+(:[^:]+)?):", mm)
			If pos := InStr(mm1, ":")
				If not RegExMatch(sWin, Trim(SubStr(mm1, 1, pos - 1))) or not RegExMatch(sCtl, Trim(SubStr(mm1, pos + 1)))
					Continue
				Else Passed := True
			Else If not RegExMatch(sWin, Trim(mm1))
				Continue
			Else Passed := True
			If Passed
				m := Trim(RegExReplace(m, "\s*\[([^\]]+)]"))
			If not nl
				nl := (gx + gw + 25 + w%A_Index%) > A_ScreenWidth - 40
			p := nl ? "" : "+", y := nl ? "y+28" : ""
			Gui, Add, Button, HwndhBtn%ci% x%p%25 %y% h57, % (m, pi := ci, ci++)
			OnSuch := this.MenuClick.Bind(this)
			GuiControl +g, Button%pi%, % OnSuch
			GuiControlGet, g, Pos, Button%pi%
			TT.Attach(hBtn%pi%, RegExReplace(RegExReplace(SubStr(A_LoopField, 0) = "`r" ? SubStr(A_LoopField, 1, -1) : A_LoopField, "[^\t]+\t",,, 1), "\t", "`n"))
			nl := (gx + gw) > (A_ScreenWidth - 116)
		}Else If RegExMatch(A_LoopField, "i)^\s*{\s*Script\s+[^}]+?\s*}")
			Break
		Else
		{	Gui, Add, Text, x25 cWhite, % SubStr(A_LoopField, 0) = "`r" ? SubStr(A_LoopField, 1, -1) : A_LoopField
			nl := True
		}
	Gui, Color, Black
	TT.SetTitle("Descriptions", LoadPicture("shell32.dll", "Icon222", ImageType))
	SetCtrlFont(TT.HTIP, "s20", "Arial New")
	Gui, +LastFound
	WinSet, Transparent, 180
	Gui, Show,, Touch Friendly Menu
	GroupAdd, SpotMenu, % "ahk_id " . WinExist()
	this.t := t
}
Gui_OnSize() {
	UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight)
}
Gui_OnEscape() {
	menu.OnClose()
	Gui, mSpot:Show, NoActivate
	WinSet, TransColor, White 64, mSpot
}
Gui_OnClose() {
	ObjRegisterActive(agent, "")
	ExitApp
}
OnClose() {
	OnMessage(0x115, "") ; WM_VSCROLL
	OnMessage(0x114, "") ; WM_HSCROLL
	OnMessage(0x20A, "") ; WM_MOUSEWHEEL
	OnMessage(0x20E, "") ; WM_MOUSEHWHEEL
	OnMessage(0x119, "") ; WM_GESTURE
	Gui, menu:Destroy
}
GetButtonWidth(t, s, f) {
	Gui, New
	Gui, Font, s%s%, % f
	Gui, Add, Button,, % t
	GuiControlGet, g, Pos, Button1
	Gui, Destroy
	Return gW
}
MenuClick(h) {
	global TT
	theText := A_GuiControl
	this.OnClose()
	WinWaitNotActive, Touch Friendly Menu
	Sleep, 500
	this.do(theText, TT.GetText(h))
	Gui, mSpot:Show, NoActivate
	WinSet, TransColor, White 64, mSpot
}
do(theText, t) {
	If RegExMatch(t, "{\K[^}]+(?=})", m)
		If not InStr(t, "(Send)")
			theText := m
	If InStr(t, "(Send)")
		Send, %theText%
	Else If InStr(t, "(Gosub)")
		Gosub, %theText%
	Else If InStr(t, "(Function)")
		If pos := InStr(theText, ".")
			className := SubStr(theText, 1, pos - 1), method := SubStr(theText, pos + 1), %className%[method]()
		Else %theText%()
	Else If InStr(t, "(Func+Param)")
	{	RegExMatch(t, "[^\n]+$", m)
		If InStr(m, ",")
		{	Loop, Parse, m, `,
				p%A_Index% := var(A_LoopField "@pool")
			StrReplace(m, ",",, c)
			If c = 1
				%theText%(p1, p2)
			Else If c = 2
				%theText%(p1, p2, p3)
			Else If c = 3
				%theText%(p1, p2, p3, p4)
			Else If c = 4
				%theText%(p1, p2, p3, p4, p5)
			Else If c = 5
				%theText%(p1, p2, p3, p4, p5, p6)
			Else If c = 6
				%theText%(p1, p2, p3, p4, p5, p6, p7)
			Else If c = 7
				%theText%(p1, p2, p3, p4, p5, p6, p7, p8)
			Else If c = 8
				%theText%(p1, p2, p3, p4, p5, p6, p7, p8, p9)
			Else If c = 9
				%theText%(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10)
			Else{}	;more than 10 parameters is not supported
		}Else %theText%(var(m "@pool"))
	}Else If InStr(t, "(Script)")
		If RegExMatch(t, "{\K[^}]+(?=})", m)
			If RegExMatch(this.t, "is){\s*Script\s+" m "\s*}(.+?){\s*/\s*Script\s*}", mm)
				ExecScript(var("s1l@pool") this.HandleInclude(mm1),, A_AhkPath)
			Else IfExist, % m := (SubStr(Trim(m), -3) = ".ahk" ? m : Trim(m) ".ahk")
			{	FileRead, mm1, %m%
				ExecScript(var("s1l@pool") mm1,, A_AhkPath)
			}Else{}
		Else RegExMatch(t, "\(Script\)[\n\t]+\K.*$", m), m := StrReplace(m, "|| ||", "`n"), ExecScript(var("s1l@pool") this.HandleInclude(m),, A_AhkPath)
}
HandleInclude(s) {
	If RegExMatch(s, "is)#\s*Include\s+[^#]+#")
	{	RegExReplace(s, "is)#\s*Include\s+[^#]+#",, n), pos := 1, m := ""
		Loop, %n%
			pos := RegExMatch(s, "is)#\s*Include\s+\K[^#]+(?=#)", m, pos + StrLen(m)), RegExMatch(this.t, "is){\s*Script\s+" Trim(m) "\s*}(.+?){\s*/\s*Script\s*}", mm), s := RegExReplace(s, "is)#\s*Include\s+" Trim(m) "\s*#", RegExMatch(mm1, "is)#\s*Include\s+[^#]+#") ? this.HandleInclude(mm1) : mm1)
	}
	Return s
}
ExtraSpot() {
	btn := "B" A_TickCount
	MouseGetPos,,, mow, moc
	WinGetTitle, mow, ahk_id %mow%
	ControlGetText, m, %moc%, %mow%
	MouseGetPos,,,, h, 2
	t := agent.Call("TT.GetText", h)
	menu.Gui_OnEscape()
	Gui, shape:New, +ToolWindow
	Gui, Font, s30, Consolas
	Gui, Add, ListBox, r15, ●|◆|◼|◉|◈|▣|◙|▲|▼|◀|▶|◢|◥|◣|◤
	OnSuch := this.Pick.Bind(this)
	GuiControl +g, ListBox1, % OnSuch
	Gui, Show,, Select A Shape Please
	var("Set:Shape@pool", False), this.CurItem := "●"
	While, not var("Shape@pool") and WinExist("Select A Shape Please")
		Sleep, 100
	If not var("Shape@pool")
		var("Set:Shape@pool", this.CurItem)
	Gui, shape:Destroy
	Gui, %btn%:New, hwndHspot
	Gui, +LastFound -Caption +AlwaysOnTop +ToolWindow
	Gui, Color, White
	Gui, Margin, 0, 0
	Gui, Font, s120, Consolas
	Gui, Add, Text, x0 y0 cB2D6F3 BackgroundTrans, % var("Shape@pool")
	OnSuch := this.xHit.Bind(this)
	GuiControl +g, Static1, % OnSuch
	Gui, Add, Text, Hidden, %m%
	Gui, Add, Text, Hidden, %t%
	WinSet, TransColor, White 64
	x := A_ScreenWidth - 100
	Gui, Show, x%x% NoActivate, %btn%spot
	this.wt := btn "spot"
	ControlGet, sid, hwnd,, Static1, %btn%spot
	this.xHit(sid + 0) ; Init sPos
}
xHit(hwnd := "") {
	static sPos := []
	If not StrLen(sPos[hwnd])
	{	WinGetPos, x, y,,, % this.wt
		sPos[hwnd] := x "," y
		Return
	}SendMessage, 0xA1, 2,,, A ; WM_NCLBUTTONDOWN
	GuiControlGet, wHwnd, Hwnd, %hwnd%
	WinGetPos, x, y,,, ahk_id %wHwnd%
	WinGetActiveTitle, wt
	var("Set:wName@pool", wName := SubStr(wt, 1, -4))
	If x "," y = sPos[hwnd]
	{	GuiControlGet, theText,, Static2
		GuiControlGet, t,, Static3
		Gui, %wName%:Hide
		menu.do(theText, t)
	}Else sPos[hwnd] := x "," y
	SetTimer, DeactivateIt, -500
	Return
	DeactivateIt:
		wName := var("wName@pool")
		Gui, %wName%:Hide
		Gui, %wName%:Show, NoActivate
		Return
}
Pick(hwnd := "") {
	GuiControlGet, Choice,, ListBox1
	If StrLen(Choice)
	{	this.CurItem := Choice
		If not InStr(A_PriorKey, "LButton")
			Return
	}Else If A_ThisHotkey in Space,Enter,``
		Choice := this.CurItem
	var("Set:Shape@pool", Choice)
}
Reload() {
	FileRead, _menu_, MenuText.txt
	var("Set:_menu_@pool", _menu_)
	SetTimer, ReloadMenu, -500
	Return
	ReloadMenu:
		Gui, mSpot:Hide
		menu.SpotMenu(var("_menu_@pool"))
		Return
}
}	;end of class

keyRButton() {
	IfWinNotExist, mSpot
	{	beg := A_TickCount
		While, GetKeyState("RButton", "P")
			If A_TickCount - beg > 1000
			{	IfWinNotExist, Touch Friendly Menu
				{	menu.Spot(), beg := False
					SoundBeep
				}Break
			}
		If not beg
			Return
	}
	MouseGetPos,,, mow, moc
	WinGetTitle, mow, ahk_id %mow%
	If SubStr(mow, -3) = "Spot" and moc = "Static1"
		WinClose, %mow%
	Else If mow = Touch Friendly Menu
		If SubStr(moc, 1, 6) = "Button"
			menu.ExtraSpot()
		Else{}
	Else Send, {RButton}
}

SetCtrlFont(CtrlHwnd, FontOptions := "", FontName := "") {	;written by iPhilip
   static WM_SETFONT := 0x0030, WM_GETFONT := 0x0031
   DefaultGui := A_DefaultGui
   Gui, New
   Gui, Font, % FontOptions, % FontName
   Gui, Add, Text, hwndhText, Text
   hFont := DllCall("SendMessage", "Ptr", hText, "UInt", WM_GETFONT, "Ptr", 0, "Ptr", 0, "Ptr")
   Gui, Destroy
   Gui, %DefaultGui%:Default
   DllCall("SendMessage", "Ptr", CtrlHwnd, "UInt", WM_SETFONT, "Ptr", hFont, "Ptr", true)
   Return hFont
}

; ======================================================================================================================
; Namespace:      GuiControlTips
; AHK version:    AHK 1.1.14.03
; Function:       Helper object to simply assign ToolTips for GUI controls
; Tested on:      Win 7 (x64)
; Change history:
;                 1.1.00.01/2020-06-03/just me - fixed missing Static WS_EX_TOPMOST
;                 1.1.00.00/2014-03-06/just me - Added SetDelayTimes()
;                 1.0.01.00/2012-07-29/just me
; ======================================================================================================================
; CLASS GuiControlTips
;
; The class provides four public methods to register (Attach), unregister (Detach), update (Update), and
; disable/enable (Suspend) common ToolTips for GUI controls.
;
; Usage:
; To assign ToolTips to GUI controls you have to create a new instance of GuiControlTips per GUI with
;     MyToolTipObject := New GuiControlTips(HGUI)
; passing the HWND of the GUI.
;
; After this you may assign ToolTips to your GUI controls by calling
;     MyToolTipObject.Attach(HCTRL, "ToolTip text")
; passing the HWND of the control and the ToolTip's text. Pass True/1 for the optional third parameter if you
; want the ToolTip to be shown centered below the control.
;
; To remove a ToolTip call
;     MyToolTipObject.Detach(HCTRL)
; passing the HWND of the control.
;
; To update the ToolTip's text call
;     MyToolTipObject.Update(HCTRL, "New text!")
; passing the HWND of the control and the new text.
;
; To deactivate the ToolTips call
;     MyToolTipObject.Suspend(True),
; to activate them again afterwards call
;     MyToolTipObject.Suspend(False).
;
; To adjust the ToolTips delay times call
;     MyToolTipObject.SetDelayTimesd(),
; specifying the delay times in milliseconds.
;
; That's all you can / have to do!
; ======================================================================================================================
Class GuiControlTips {	;written by @"just me"
   ; ===================================================================================================================
   ; INSTANCE variables
   ; ===================================================================================================================
   HTIP := 0
   HGUI := 0
   CTRL := {}
   ; ===================================================================================================================
   ; CONSTRUCTOR           __New()
   ; ===================================================================================================================
   __New(HGUI) {
      Static CLASS_TOOLTIP      := "tooltips_class32"
      Static CW_USEDEFAULT      := 0x80000000
      Static TTM_SETMAXTIPWIDTH := 0x0418
      Static TTM_SETMARGIN      := 0x041A
      Static WS_EX_TOPMOST      := 0x00000008
      Static WS_STYLES          := 0x80000002 ; WS_POPUP | TTS_NOPREFIX
      ; Create a Tooltip control ...
      HTIP := DllCall("User32.dll\CreateWindowEx", "UInt", WS_EX_TOPMOST, "Str", CLASS_TOOLTIP, "Ptr", 0
                    , "UInt", WS_STYLES
                    , "Int", CW_USEDEFAULT, "Int", CW_USEDEFAULT, "Int", CW_USEDEFAULT, "Int", CW_USEDEFAULT
                    , "Ptr", HGUI, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Ptr")
      If ((ErrorLevel) || !(HTIP))
         Return False
      ; ... prepare it to display multiple lines if required
      DllCall("User32.dll\SendMessage", "Ptr", HTIP, "Int", TTM_SETMAXTIPWIDTH, "Ptr", 0, "Ptr", A_ScreenWidth*96//A_ScreenDPI)	;touched by SundayProgrammer who took it from iPhilip response for AddTooltip v2.0
      ; ... set the instance variables
      This.HTIP := HTIP
      This.HGUI := HGUI
      If (DllCall("Kernel32.dll\GetVersion", "UInt") & 0xFF) < 6 ; to avoid some XP issues ...
         This.Attach(HGUI, "") ; ... register the GUI with an empty tiptext
   }
   ; ===================================================================================================================
   ; DESTRUCTOR            __Delete()
   ; ===================================================================================================================
   __Delete() {
      If (This.HTIP) {
         DllCall("User32.dll\DestroyWindow", "Ptr", This.HTIP)
      }
   }
   ; ===================================================================================================================
   ; PRIVATE METHOD        SetToolInfo - Create and fill a TOOLINFO structure
   ; ===================================================================================================================
   SetToolInfo(ByRef TOOLINFO, HCTRL, TipTextAddr, CenterTip = 0) {
      Static TTF_IDISHWND  := 0x0001
      Static TTF_CENTERTIP := 0x0002
      Static TTF_SUBCLASS  := 0x0010
      Static OffsetSize  := 0
      Static OffsetFlags := 4
      Static OffsetHwnd  := 8
      Static OffsetID    := OffsetHwnd + A_PtrSize
      Static OffsetRect  := OffsetID + A_PtrSize
      Static OffsetInst  := OffsetRect + 16
      Static OffsetText  := OffsetInst + A_PtrSize
      Static StructSize  := (4 * 6) + (A_PtrSize * 6)
      Flags := TTF_IDISHWND | TTF_SUBCLASS
      If (CenterTip)
         Flags |= TTF_CENTERTIP
      VarSetCapacity(TOOLINFO, StructSize, 0)
      NumPut(StructSize, TOOLINFO, OffsetSize, "UInt")
      NumPut(Flags, TOOLINFO, OffsetFlags, "UInt")
      NumPut(This.HGUI, TOOLINFO, OffsetHwnd, "Ptr")
      NumPut(HCTRL, TOOLINFO, OffsetID, "Ptr")
      NumPut(TipTextAddr, TOOLINFO, OffsetText, "Ptr")
      Return True
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         Attach         -  Assign a ToolTip to a certain control
   ; Parameters:           HWND           -  Control's HWND
   ;                       TipText        -  ToolTip's text
   ;                       Optional:      ------------------------------------------------------------------------------
   ;                       CenterTip      -  Centers the tooltip window below the control
   ;                                         Values:  True/False
   ;                                         Default: False
   ; Return values:        On success: True
   ;                       On failure: False
   ; ===================================================================================================================
   Attach(HCTRL, TipText, CenterTip = False) {
      Static TTM_ADDTOOL  := A_IsUnicode ? 0x0432 : 0x0404 ; TTM_ADDTOOLW : TTM_ADDTOOLA
      If !(This.HTIP) {
         Return False
      }
      If This.CTRL.HasKey(HCTRL)
         Return False
      TOOLINFO := ""
      This.SetToolInfo(TOOLINFO, HCTRL, &TipText, CenterTip)
      If DllCall("User32.dll\SendMessage", "Ptr", This.HTIP, "Int", TTM_ADDTOOL, "Ptr", 0, "Ptr", &TOOLINFO) {
         This.CTRL[HCTRL] := 1
		 This.TTT[HCTRL] := TipText	;added by SundayProgrammer
         Return True
      } Else {
        Return False
      }
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         Detach         -  Remove the ToolTip for a certain control
   ; Parameters:           HWND           -  Control's HWND
   ; Return values:        On success: True
   ;                       On failure: False
   ; ===================================================================================================================
   Detach(HCTRL) {
      Static TTM_DELTOOL  := A_IsUnicode ? 0x0433 : 0x0405 ; TTM_DELTOOLW : TTM_DELTOOLA
      If !This.CTRL.HasKey(HCTRL)
         Return False
      TOOLINFO := ""
      This.SetToolInfo(TOOLINFO, HCTRL, 0)
      DllCall("User32.dll\SendMessage", "Ptr", This.HTIP, "Int", TTM_DELTOOL, "Ptr", 0, "Ptr", &TOOLINFO)
      This.CTRL.Remove(HCTRL, "")
	  This.TTT.Remove(HCTRL, "")	;added by SundayProgrammer
      Return True
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         Update         -  Update the ToolTip's text for a certain control
   ; Parameters:           HWND           -  Control's HWND
   ;                       TipText        -  New text                                                      
   ; Return values:        On success: True
   ;                       On failure: False
   ; ===================================================================================================================
   Update(HCTRL, TipText) {
      Static TTM_UPDATETIPTEXT  := A_IsUnicode ? 0x0439 : 0x040C ; TTM_UPDATETIPTEXTW : TTM_UPDATETIPTEXTA
      If !This.CTRL.HasKey(HCTRL)
         Return False
      TOOLINFO := ""
      This.SetToolInfo(TOOLINFO, HCTRL, &TipText)
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_UPDATETIPTEXT, "Ptr", 0, "Ptr", &TOOLINFO)
	  This.TTT[HCTRL] := TipText	;added by SundayProgrammer
      Return True
   }
   ;added by SundayProgrammer
   GetText(HCTRL) {
      If !This.CTRL.HasKey(HCTRL)
         Return ""
      Return This.TTT[HCTRL]
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         Suspend        -  Disable/enable the ToolTip control (don't show / show ToolTips)
   ; Parameters:           Mode           -  True/False (1/0)
   ;                                         Default: True/1
   ; Return values:        On success: True
   ;                       On failure: False
   ; Remarks:              ToolTips are enabled automatically on creation.
   ; ===================================================================================================================
   Suspend(Mode = True) {
      Static TTM_ACTIVATE := 0x0401
      If !(This.HTIP)
         Return False
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_ACTIVATE, "Ptr", !Mode, "Ptr", 0)
      Return True
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         SetDelayTimes  -  Set the initial, pop-up, and reshow durations for a tooltip control.
   ; Parameters:           Init           -  Amount of time, in milliseconds, a pointer must remain stationary within
   ;                                         a tool's bounding rectangle before the tooltip window appears.
   ;                                         Default: -1 (system default time)
   ;                       PopUp          -  Amount of time, in milliseconds, a tooltip window remains visible if the
   ;                                         pointer is stationary within a tool's bounding rectangle.
   ;                                         Default: -1 (system default time)
   ;                       ReShow         -  Amount of time, in milliseconds, it takes for subsequent tooltip windows
   ;                                         to appear as the pointer moves from one tool to another.
   ;                                         Default: -1 (system default time)
   ; Return values:        On success: True
   ;                       On failure: False
   ; Remarks:              Times are set per ToolTip control and applied to all added tools.
   ; ===================================================================================================================
   SetDelayTimes(Init = -1, PopUp = -1, ReShow = -1) {
      Static TTM_SETDELAYTIME   := 0x0403
      Static TTDT_RESHOW   := 1
      Static TTDT_AUTOPOP  := 2
      Static TTDT_INITIAL  := 3
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_SETDELAYTIME, "Ptr", TTDT_INITIAL, "Ptr", Init)
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_SETDELAYTIME, "Ptr", TTDT_AUTOPOP, "Ptr", PopUp)
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_SETDELAYTIME, "Ptr", TTDT_RESHOW , "Ptr", ReShow)
   }
   ;added by SundayProgrammer who largely took it from AddTooltip v2.0
   SetTitle(theTitle := "", theIcon := 0) {
      Static TTM_SETTITLE := A_IsUnicode ? 0x421 : 0x420 ; TTM_SETTITLEW : TTM_SETTITLEA
      If StrLen(theTitle) > 99
         theTitle := SubStr(theTitle, 1, 99)
      If theIcon is not Integer
         theIcon := 0
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_SETTITLE, "Ptr", theIcon, "Ptr", &theTitle)
   }
}

UpdateScrollBars(GuiNum, GuiWidth, GuiHeight) {	;written by lexikos
    static SIF_RANGE=0x1, SIF_PAGE=0x2, SIF_DISABLENOSCROLL=0x8, SB_HORZ=0, SB_VERT=1
   
    Gui, %GuiNum%:Default
    Gui, +LastFound
   
    ; Calculate scrolling area.
    Left := Top := 9999
    Right := Bottom := 0
    WinGet, ControlList, ControlList
    Loop, Parse, ControlList, `n
    {
        GuiControlGet, c, Pos, %A_LoopField%
        if (cX < Left)
            Left := cX
        if (cY < Top)
            Top := cY
        if (cX + cW > Right)
            Right := cX + cW
        if (cY + cH > Bottom)
            Bottom := cY + cH
    }
    Left -= 8
    Top -= 8
    Right += 8
    Bottom += 8
    ScrollWidth := Right-Left
    ScrollHeight := Bottom-Top
   
    ; Initialize SCROLLINFO.
    VarSetCapacity(si, 28, 0)
    NumPut(28, si) ; cbSize
    NumPut(SIF_RANGE | SIF_PAGE, si, 4) ; fMask
   
    ; Update horizontal scroll bar.
    NumPut(ScrollWidth, si, 12) ; nMax
    NumPut(GuiWidth, si, 16) ; nPage
    DllCall("SetScrollInfo", "uint", WinExist(), "uint", SB_HORZ, "uint", &si, "int", 1)
   
    ; Update vertical scroll bar.
;     NumPut(SIF_RANGE | SIF_PAGE | SIF_DISABLENOSCROLL, si, 4) ; fMask
    NumPut(ScrollHeight, si, 12) ; nMax
    NumPut(GuiHeight, si, 16) ; nPage
    DllCall("SetScrollInfo", "uint", WinExist(), "uint", SB_VERT, "uint", &si, "int", 1)
   
    if (Left < 0 && Right < GuiWidth)
        x := Abs(Left) > GuiWidth-Right ? GuiWidth-Right : Abs(Left)
    if (Top < 0 && Bottom < GuiHeight)
        y := Abs(Top) > GuiHeight-Bottom ? GuiHeight-Bottom : Abs(Top)
    if (x || y)
        DllCall("ScrollWindow", "uint", WinExist(), "int", x, "int", y, "uint", 0, "uint", 0)
}

OnScroll(wParam, lParam, msg, hwnd) {	;written by lexikos
    static SIF_ALL=0x17, SCROLL_STEP=85 ;changed by SundayProgrammer from 10 to 85 for a more practical outcome
	static xpos := 0, ypos := 0	;added by SundayProgrammer - for touch gesture scrolling
	global gFlag	;added by SundayProgrammer - for touch gesture scrolling
if DllCall("GetParent", "uint", hwnd)	;added by SundayProgrammer - a quick fix for the scenario when any scrollable control is involved
	return	;added by SundayProgrammer - a quick fix for the scenario when any scrollable control is involved
   
    bar := (msg=0x115) or (msg=0x20A) ; (SB_HORZ=0, SB_VERT=1) or (WM_MOUSEHWHEEL=0, WM_MOUSEWHEEL=1)	;changed by SundayProgrammer - for WM_MOUSEWHEEL and WM_MOUSEHWHEEL
   
	if gFlag	;added by SundayProgrammer - for touch gesture scrolling
	{	gAction(xpos, ypos, bar, hwnd)	;added by SundayProgrammer - for touch gesture scrolling
		return	;added by SundayProgrammer - for touch gesture scrolling
	}	;added by SundayProgrammer - for touch gesture scrolling
   
    VarSetCapacity(si, 28, 0)
    NumPut(28, si) ; cbSize
    NumPut(SIF_ALL, si, 4) ; fMask
    if !DllCall("GetScrollInfo", "uint", hwnd, "int", bar, "uint", &si)
        return
   
    VarSetCapacity(rect, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rect)
   
    new_pos := NumGet(si, 20) ; nPos (saw "25" in another version, which exhibited a bug in my testing, whereas "20" (this version) worked fine so far)
   
    if msg=0x20A	;added by SundayProgrammer - for WM_MOUSEWHEEL
        wParam := wParam>0x780000	;added by SundayProgrammer - for WM_MOUSEWHEEL
    else if msg=0x20E	;added by SundayProgrammer - for WM_MOUSEHWHEEL
        wParam := wParam=0x780000	;added by SundayProgrammer - for WM_MOUSEHWHEEL
    action := wParam & 0xFFFF
    if action = 0 ; SB_LINEUP
        new_pos -= SCROLL_STEP
    else if action = 1 ; SB_LINEDOWN
        new_pos += SCROLL_STEP
    else if action = 2 ; SB_PAGEUP
        new_pos -= NumGet(rect, 12, "int") - SCROLL_STEP
    else if action = 3 ; SB_PAGEDOWN
        new_pos += NumGet(rect, 12, "int") - SCROLL_STEP
    else if (action = 5 || action = 4) ; SB_THUMBTRACK || SB_THUMBPOSITION
        new_pos := wParam>>16
    else if action = 6 ; SB_TOP
        new_pos := NumGet(si, 8, "int") ; nMin
    else if action = 7 ; SB_BOTTOM
        new_pos := NumGet(si, 12, "int") ; nMax
    else
        return
   
    min := NumGet(si, 8, "int") ; nMin
    max := NumGet(si, 12, "int") - NumGet(si, 16) ; nMax-nPage
    new_pos := new_pos > max ? max : new_pos
    new_pos := new_pos < min ? min : new_pos
   
    old_pos := NumGet(si, 20, "int") ; nPos (saw "25" in another version, which exhibited a bug in my testing, whereas "20" (this version) worked fine so far)
   
    x := y := 0
    if bar = 0 ; SB_HORZ
        x := old_pos-new_pos
    else
        y := old_pos-new_pos
    ; Scroll contents of window and invalidate uncovered area.
    DllCall("ScrollWindow", "uint", hwnd, "int", x, "int", y, "uint", 0, "uint", 0)
   
    ; Update scroll bar.
    NumPut(new_pos, si, 20, "int") ; nPos (saw "25" in another version, which exhibited a bug in my testing, whereas "20" (this version) worked fine so far)
    DllCall("SetScrollInfo", "uint", hwnd, "int", bar, "uint", &si, "int", 1)

	z := bar ? "y" : "x", %z%pos := new_pos	;added by SundayProgrammer - for touch gesture scrolling
}
gAction(byref xpos, byref ypos, bar, hwnd) {	;written by SundayProgrammer - for touch gesture scrolling
	VarSetCapacity(si, 28, 0), NumPut(28, si), NumPut(0x17, si, 4), DllCall("GetScrollInfo", "uint", hwnd, "int", bar, "uint", &si), aPos := NumGet(si, 20, "int"), z := bar ? "y" : "x"
	if not (%z%pos = aPos)
		x := y := 0, %z% := %z%pos - aPos, DllCall("ScrollWindow", "uint", hwnd, "int", x, "int", y, "uint", 0, "uint", 0), %z%pos := aPos
}
gHandler(wParam, lParam, msg, hwnd) {	;written by SundayProgrammer - for touch gesture scrolling
	global gFlag
	gFlag := true
	settimer, Reset_gFlag, -100
	return
	Reset_gFlag:
		gFlag := false
		return
}

ObjRegisterActive(Object, CLSID, Flags:=0) {	;written by Lexikos
    static cookieJar := {}
    if (!CLSID) {
        if (cookie := cookieJar.Remove(Object)) != ""
            DllCall("oleaut32\RevokeActiveObject", "uint", cookie, "ptr", 0)
        return
    }
    if cookieJar[Object]
        throw Exception("Object is already registered", -1)
    VarSetCapacity(_clsid, 16, 0)
    if (hr := DllCall("ole32\CLSIDFromString", "wstr", CLSID, "ptr", &_clsid)) < 0
        throw Exception("Invalid CLSID", -1, CLSID)
    hr := DllCall("oleaut32\RegisterActiveObject"
        , "ptr", &Object, "ptr", &_clsid, "uint", Flags, "uint*", cookie
        , "uint")
    if hr < 0
        throw Exception(format("Error 0x{:x}", hr), -1)
    cookieJar[Object] := cookie
}

;Function Ripped out of CodeQuickTester written by GeekDude https://github.com/G33kDude/CodeQuickTester
ExecScript(Script, Params="", AhkPath="")	;copy from "Execute code stored in a variable (dynamic variable?)" https://www.reddit.com/r/AutoHotkey/comments/ebwora/comment/fbcwvuy/?utm_source=share&utm_medium=web2x&context=3
{
	static Shell := ComObjCreate("WScript.Shell")
	Name := "\\.\pipe\AHK_CQT_" A_TickCount
	Pipe := []
	Loop, 3
	{
		Pipe[A_Index] := DllCall("CreateNamedPipe"
		, "Str", Name
		, "UInt", 2, "UInt", 0
		, "UInt", 255, "UInt", 0
		, "UInt", 0, "UPtr", 0
		, "UPtr", 0, "UPtr")
	}
	if !FileExist(AhkPath)
		throw Exception("AutoHotkey runtime not found: " AhkPath)
	if (A_IsCompiled && AhkPath == A_ScriptFullPath)
		AhkPath .= " /E"
	if FileExist(Name)
	{
		Exec := Shell.Exec(AhkPath " /CP65001 " Name " " Params)
		DllCall("ConnectNamedPipe", "UPtr", Pipe[2], "UPtr", 0)
		DllCall("ConnectNamedPipe", "UPtr", Pipe[3], "UPtr", 0)
		FileOpen(Pipe[3], "h", "UTF-8").Write(Script)
	}
	else ; Running under WINE with improperly implemented pipes
	{
		FileOpen(Name := "AHK_CQT_TMP.ahk", "w").Write(Script)
		Exec := Shell.Exec(AhkPath " /CP65001 " Name " " Params)
	}
	Loop, 3
		DllCall("CloseHandle", "UPtr", Pipe[A_Index])
	return Exec
}