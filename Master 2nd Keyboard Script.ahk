#NoEnv
; KeyHistory
; SendMode Input
; #UseHook On ;<-- Fuck this Hook. This causes the Jabber Copy/Cut Bug.
; #InstallKeybdHook ;<-- Use this one instead.
Menu, Tray, Icon, shell32.dll, 317 ; this changes the tray icon to a little settings icon
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm
global guiShown = false
global headX = 0
global headY = 0
global mouseX = 0
global mouseY = 0
$^+J::
start:
/*
					╭───────────────────────────────────────────────────────────────────╮
					│																	│
					│						AHK Master script.							│
					│																	│
					│		Boilerplate from TaranVH, modified heavily by Ryah.			│
					│	Premiere functions work mostly as intended so those were left 	│
					│	  unedited except for removing a few comments to save space.	│
					│																	│
					├───────────────────────────────────────────────────────────────────┤
					│																	│
					│ * TODO: 	Add all scripts to be called from this master script	│
					│																	│
					│ * TODO:	Add Position instantVFX to F7/F8 (horizontal is easy,	│
					│			vertical is the challenging one.)						│
					│																	│							
					│																	│
					╰───────────────────────────────────────────────────────────────────╯
*/

#IfWinActive ahk_exe AfterFX.exe

^c::SendInput ^c
^x::SendInput ^x

/*
			╔═══════════════════════════════════════════════════════════════════════════════════════╗
			║																						║	
			║	                              Premiere Shortcuts                                 	║	
			║																						║	
			╚═══════════════════════════════════════════════════════════════════════════════════════╝
*/

#IfWinActive ahk_exe Adobe Premiere Pro.exe

$^c::SendInput ^!+{F24}
$^x::SendInput ^!+{F23}

; Normal Keyboard Start
~F1::
	tippy("Excalibur")
	send,!{Space}
return

~F2::
	tippy("Instant Cut at Cursor")
	send, b ;RAZOR tool
	send, {shift down} ;makes the blade tool affect all (unlocked) tracks
	keywait, F1 ;waits for the key to go UP.
	send, {lbutton} ;makes a CUT
	send, {shift up}
	sleep 10
	send, v ;SELECTION tool
return

~F3::
	tippy("Delete Clip at Cursor")
	prFocus("timeline") ;This will bring focus to the timeline
	send, ^!d ;DESELECT. This shortcut only works if the timeline is in focus
	send, v ;SELECT
	send, {alt down}
	send, {lbutton}
	send, {alt up}
	send, c ; CLEAR

return

~F4::
	tippy("Ripple Delete at Cursor")
	BlockInput, On 
	BlockInput, MouseMove
	prFocus("timeline") ;This will bring focus to the timeline
	SavePHPos()
	sleep 50
	Send \
	Send ^!s ;ctrl alt s  is assigned to [select clip at playhead]
	Send ^+!d ;ctrl alt shift d  is [ripple delete]
	sleep 50
	MouseMove, headX+7, headY, 0 ; 7 pixels on the X axis is important. For some reason loading the mouse position isn't exactly accurate. It's 7 pixels off.
	MouseClick, left
	MouseMove, mouseX, mouseY, 0
	blockinput, off
	blockinput, MouseMoveOff
return

~F5::
	tippy("Ripple Cut at Cursor")
	BlockInput, On 
	BlockInput, MouseMove
	prFocus("timeline") ;This will bring focus to the timeline
	SavePHPos()
	sleep 50
	Send \
	Send ^!s ;ctrl alt s  is assigned to [select clip at playhead]
	sleep 1
	Send ^c
	sleep 1
	Send ^+!d ;ctrl alt shift d  is [ripple delete]
	sleep 50
	MouseMove, headX+7, headY, 0 ; 7 pixels on the X axis is important. For some reason loading the mouse position isn't exactly accurate. It's 7 pixels off.
	sleep 1
	MouseClick, left
	sleep 1
	MouseMove, mouseX, mouseY, 0
	blockinput, off
	blockinput, MouseMoveOff
return

~F6::
	tippy("F6")
return

~F7::
	tippy("Ease In")
	; Premiere Shortcut
return

~F8::
	tippy("Ease Out")
	; Premiere Shortcut
return

~F9::
	tippy("F9")
return

~F10::
	tippy("F10")
return

~F11::
	tippy("F11")
return

~F12::
	tippy("F12")
return

;2nd Keyboard Start

~F13:: ;1
	tippy("F13")
return

~F14:: ;2
	tippy("F14")
return

~F15:: ;3
	tippy("F15")
return

~F16:: ;4
	tippy("F16")
return

~F17:: ;5
	tippy("F17")
return

~F18:: ;6
	tippy("F18")
return

~F19:: ;7
	tippy("F19")
return

~F20:: ;8
	tippy("F20")
return

~F21:: ;9
	tippy("F21")
return

~F22:: ;0
	tippy("F22")
return

~F23:: ;-
	tippy("F23")
return

~F24:: ;=
	tippy("F24")
return


~^F13:: ;Q
	tippy("^F13")
return

~^F14:: ;W
	tippy("^F14")
return

~^F15:: ;E
	tippy("^F15")
return

~^F16:: ;R
	tippy("^F16")
return

~^F17:: ;T
	tippy("^F17")
return

~^F18:: ;Y
	tippy("^F18")
return

~^F19:: ;U
	tippy("^F19")
return

~^F20:: ;I
	tippy("^F20")
return

~^F21:: ;O
	tippy("^F21")
return

~^F22:: ;P
	tippy("^F22")
return

~^F23:: ;[
	tippy("^F23")
return

~^F24:: ;]
	tippy("^F24")
return


~^!F13:: ;A
	tippy("^!F13")
return

~^!F14:: ;S
	tippy("^!F14")
return

~^!F15:: ;D
	tippy("^!F15")
return

~^!F16:: ;F
	tippy("^!F16")
return

~^!F17:: ;G
	tippy("^!F17")
return

~^!F18:: ;H
	tippy("^!F18")
return

~^!F19:: ;J
	tippy("^!F19")
return

~^!F20:: ;K
	tippy("^!F20")
return

~^!F21:: ;L
	tippy("^!F21")
return

~^!F22:: ;;
	tippy("^!F22")
return

~^!F23:: ;'
	tippy("^!F23")
return

~^!F24:: ;Z
	tippy("^!F24")
return

~^+!F13:: ;X
	tippy("^+!F13")
return

~^+!F14:: ;C
	tippy("^+!F14")
return

~^+!F15:: ;V
	tippy("^+!F15")
return

~^+!F16:: ;B
	tippy("^+!F16")
return

~^+!F17:: ;N
	tippy("^+!F17")
return

~^+!F18:: ;M
	tippy("^+!F18")
return

~^+!F19:: ;,
	tippy("^+!F19")
return

~^+!F20:: ;.
	tippy("^+!F20")
return

~^+!F21:: ;/
	tippy("^+!F21")
return

~^+!F22:: ;{SPACE}
	tippy("^+!F22")
return

~^+!F23:: ;{ALT}
	tippy("^+!F23")
return

~^+!F24:: ;{RIGHT CLICK MENU BUTTON THING}
	tippy("^+!F24")
return

/*
			╔═══════════════════════════════════════════════════════════════════════════════════════╗
			║																						║	
			║	                            Non-Premiere Shortcuts                                	║	
			║																						║	
			╚═══════════════════════════════════════════════════════════════════════════════════════╝
*/
#IfWinActive


;Normal Keyboard Start
$~F1::
	tippy("F1")
return

$~F2::
	tippy("Rename")
return

~F3::
	tippy("F3")
return

~F4::
	tippy("F4")
return

~F5::
	tippy("Refresh/Debug")
return

~F6::
	tippy("F6")
return

~F7::
	tippy("F7")
return

~F8::
	tippy("F8")
return

~F9::
	tippy("F9")
return

~F10::
	tippy("F10")
return

~F11::
	tippy("F11")
return

~F12::
	tippy("F12")
return

;2nd Keyboard Start

~F13:: ;1
	tippy("F13")
return

~F14:: ;2
	tippy("F14")
return

~F15:: ;3
	tippy("F15")
return

~F16:: ;4
	tippy("F16")
return

~F17:: ;5
	tippy("F17")
return

~F18:: ;6
	tippy("F18")
return

~F19:: ;7
	tippy("F19")
return

~F20:: ;8
	tippy("F20")
return

~F21:: ;9
	tippy("F21")
return

~F22:: ;0
	tippy("F22")
return

~F23:: ;-
	tippy("F23")
return

~F24:: ;=
	tippy("F24")
return


~^F13:: ;Q
	tippy("^F13")
return

~^F14:: ;W
	tippy("^F14")
return

~^F15:: ;E
	tippy("^F15")
return

~^F16:: ;R
	tippy("^F16")
return

~^F17:: ;T
	tippy("^F17")
return

~^F18:: ;Y
	tippy("^F18")
return

~^F19:: ;U
	tippy("^F19")
return

~^F20:: ;I
	tippy("^F20")
return

~^F21:: ;O
	tippy("^F21")
return

~^F22:: ;P
	tippy("^F22")
return

~^F23:: ;[
	tippy("^F23")
return

~^F24:: ;]
	tippy("^F24")
return


~^!F13:: ;A
	tippy("^!F13")
return

~^!F14:: ;S
	tippy("^!F14")
return

~^!F15:: ;D[]
	tippy("^!F15")
return

~^!F16:: ;F
	tippy("^!F16")
return

~^!F17:: ;G
	tippy("^!F17")
return

~^!F18:: ;H
	tippy("^!F18")
return

~^!F19:: ;J
	tippy("^!F19")
return

~^!F20:: ;K
	tippy("^!F20")
return

~^!F21:: ;L
	tippy("^!F21")
return

~^!F22:: ;;
	tippy("^!F22")
return

~^!F23:: ;'
	tippy("^!F23")
return

~^!F24:: ;Z
	tippy("^!F24")
return

~^+!F13:: ;X
	tippy("^+!F13")
return

~^+!F14:: ;C
	tippy("^+!F14")
return

~^+!F15:: ;V
	tippy("^+!F15")
return

~^+!F16:: ;B
	tippy("^+!F16")
return

~^+!F17:: ;N
	tippy("^+!F17")
return

~^+!F18:: ;M
	tippy("^+!F18")
return

~^+!F19:: ;,
	tippy("^+!F19")
return

~^+!F20:: ;.
	tippy("^+!F20")
return

~^+!F21:: ;/
	tippy("^+!F21")
return

~^+!F22:: ;{SPACE}
	tippy("^+!F22")
return

~^+!F23:: ;{ALT}
	tippy("^+!F23")
return

~^+!F24:: ;{RIGHT CLICK MENU BUTTON THING}
	tippy("^+!F24")
return

/*
			╔═══════════════════════════════════════════════════════════════════════════════════════╗
			║																						║	
			║	                                 	Functions                                		║	
			║																						║	
			╚═══════════════════════════════════════════════════════════════════════════════════════╝
*/

SavePHPos() {
	ControlGetPos, xTimeCorner, yTimeCorner, Width, Height, DroverLord - Window Class48, ahk_class Premiere Pro
	timeY := yTimeCorner+20
	timeX := xTimeCorner+235 
	;MouseMove, timeX, timeY, 0
	;MsgBox, test
	PixelSearch, headX, headY, timeX, timeY, timeX+1265, timeY+30, 0x2D8CEB, 30, Fast RGB
	;msgbox, %headX% %headY% 
	MouseGetPos, mouseX, mouseY
}

LoadPHPos() {
	; MouseMove, headX, headY, 0
	; MouseClick, left
	; MouseMove, mouseX, mouseY, 0
}

; Focus Panel Functions
prFocus(panel) {
	Sendinput, ^!+7 ;bring focus to the effects panel OR, if any panel had been maximized this will unmaximize that panel.
	sleep 12
	Sendinput, ^!+7 ;Bring focus to the effects panel AGAIN. Just in case some panel somewhere was maximized.
	sleep 5
	sendinput, {blind}{SC0EA} ;scan code of an unassigned key. Used for debugging. You do not need this.

	if (panel = "effects")
		goto theEnd ;do nothing. The shortcut has already been sent.
	else if (panel = "timeline")
		Sendinput, ^!+3 ;if focus had already been on the timeline, this would have switched to the "next" sequence (in some unpredictable order.)
	else if (panel = "program") ;program monitor
		Sendinput, ^!+4
	else if (panel = "source") ;source monitor
	{
		Sendinput, ^!+2
	}
	else if (panel = "project") ; bin
		Sendinput, ^!+1
	else if (panel = "effect controls")
		Sendinput, ^!+5

	theEnd:
		sendinput, {blind}{SC0EB} ;more debugging - you don't need this.
}


preset(item) {
	keywait, %A_PriorHotKey% 
	coordmode, pixel, Window
	coordmode, mouse, Window
	coordmode, Caret, Window

	;This (temporarily) blocks the mouse and keyboard from sending any information, which could interfere with the funcitoning of the script.
	BlockInput, SendAndMouse
	BlockInput, MouseMove
	BlockInput, On
	;The mouse will be unfrozen at the end of this function. CTRL ALT SHIFT R will reload the script.
	
	SetKeyDelay, 0
	Sendinput, ^!+k ;shuttle stop
	sleep 10
	Sendinput, ^!+k ; Sometimes, just one is not enough.
	sleep 5
	MouseGetPos, xposP, yposP ;------------------stores the cursor's current coordinates at X%xposP% Y%yposP%
	sendinput, {mButton} ;MIDDLE CLICK to bring focus to the panel underneath the cursor (which must be the timeline).
	sleep 5

	prFocus("effects") ;Brings focus to the effects panel.

	sleep 15 ;wait for 15 milliseconds before the next command.

	Sendinput, ^b ;select find box
	sleep 5

	if (A_CaretX = "") {
		waiting2 = 0
		loop
			{
			waiting2 ++
			sleep 33
			tooltip, counter = (%waiting2% * 33)`nCaret = %A_CaretX%
			if (A_CaretX <> "")
				{
				tooltip, CARET WAS FOUND
				break
				}
			if (waiting2 > 40)
				{
				tooltip, FAIL - no caret found. `nIf your cursor will not move`, hit the button to call the preset() function again.`nTo remove this 	tooltip`, 	refresh the script using its icon in the taskbar.`n`nIt's possible Premiere tried to AUTOSAVE at just the wrong moment!
				sleep 20
				GOTO theEnding
				}
			}
		sleep 1
		tooltip,
	}
	MouseMove, %A_CaretX%, %A_CaretY%, 0
	sleep 5
	MouseGetPos, , , Window, classNN
	WinGetClass, class, ahk_id %Window%
	ControlGetPos, XX, YY, Width, Height, %classNN%, ahk_class %class%, SubWindow, SubWindow 
	MouseMove, XX-15, YY+10, 0 ;moves the cursor onto the magnifying glass

	;msgbox, should be in the center of the magnifying glass now

	sleep 5
	Sendinput, %item%
	;This types in the text you wanted to search for
	sleep 5
	MouseMove, 41, 40, 0, R ;relative to the position of the magnifying glass. this moves the cursor down and directly onto the preset's icon.

	; msgbox, The cursor should be directly on top of the preset's icon. `n If not, the script needs modification.

	sleep 5


	;;At this point in the function, I used to use the line "MouseClickDrag, Left, , , %xposP%, %yposP%, 0" to drag the preset back onto the clip on the timeline. HOWEVER, because of a Premiere bug (which may or may not still exist) involving the duplicated displaying of single presets (in the wrong positions) I have to click on the Effects panel AGAIN, which will "fix" it, bringing it back to normal.
	;+++++++ If this bug is ever resolved, then the lines BELOW are no longer necessary.+++++
	MouseGetPos, iconX, iconY, Window, classNN ;---now we have to figure out the ahk_class of the current panel we are on. It might be "DroverLord - Window 	Class14", but the number changes anytime you move panels around... so i must always obtain the information anew.
	sleep 5
	WinGetClass, class, ahk_id %Window% ;----------"ahk_id %Window%" is important for SOME REASON. if you delete it, this doesn't work.
	;tooltip, ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
	;sleep 50
	ControlGetPos, xxx, yyy, www, hhh, %classNN%, ahk_class %class%, SubWindow, SubWindow ;;-I tried to exclude subwindows but I don't think it works...?
	MouseMove, www/4, hhh/2, 0, R ;-----------------moves to roughly the CENTER of the Effects panel.
	sleep 5
	MouseClick, left, , , 1 ;-----------------------the actual click
	sleep 5
	MouseMove, iconX, iconY, 0 ;--------------------moves cursor BACK onto the preset's icon
	;tooltip, should be back on the preset's icon
	sleep 5
	;;+++++If this bug is ever resolved, then the lines ABOVE are no longer necessary.++++++


	MouseClickDrag, Left, , , %xposP%, %yposP%, 0 ;---clicks the left button down, drags this effect to the cursor's pervious coordinates and releases the left mouse button, which should be above a clip, on the TIMELINE panel.
	sleep 5
	MouseClick, middle, , , 1 ;returns focus to the panel the cursor is hovering above, WITHOUT selecting anything.
	blockinput, MouseMoveOff ;returning mouse movement ability
	BlockInput, off
	theEnding:
}


instantVFX(foobar) {
	dontrestart = 0
	restartPoint:
	blockinput, sendandMouse
	blockinput, MouseMove
	blockinput, on

	;fortunately, this whole thing is fast enough that i don't NEED to buffer keypresses. I can just fully block them while we wait. But here's a thread about that:
	;https://autohotkey.com/board/topic/59606-input-buffer-during-blockinput/

	;-Sendinput ^!+5

	;clickTransformIcon()

	prFocus("effect controls") ;essentially just hits CTRL ALT SHIFT 5 to highlight the effect controls panel.
	sleep 10


	; Send {tab}
	; if (A_CaretX = "")
	; {
		; tooltip, No Caret (blinking vertical line) can be found. Therefore`, no clip is selected.
		; ;Therefore, we try to select the TOP clip at the playhead, using the code below.
		; Send ^p ;"selection follows playhead,"
		; sleep 10
		; Send ^p
	; }




	;ToolTip, A, , , 2
	MouseGetPos Xbeginlol, Ybeginlol
	global Xbegin = Xbeginlol
	global Ybegin = Ybeginlol
	; MsgBox, "please verify that the mouse cannot move"
	; sleep 2000
	ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;This is HOPEFULLY the ClassNN of the effect controls panel. Use Window Spy to figure it out.
	;I might need a far more robust way of ensuring the effect controls panel has been located, in the future.

	;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
	;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
	;these pixel numbers will be DIFFERENT depending upon the RESOLUTION and UI SCALING of your monitor(s)
	; YY := Ycorner+99 ;ui 150%
	; XX := Xcorner+19 ;ui 150%
	YY := Ycorner+66 ;ui 100%
	XX := Xcorner+13 ;ui 100%

	MouseMove, XX, YY, 0
	sleep 10

	PixelGetColor, colorr, XX, YY
	; if (colorr = "0x353535") ;for 150% ui
	if (colorr = "0x222222") ;for 100% ui
	{
		tooltip, color %colorr% means closed triangle. Will click and then SCALE SEARCH
		blockinput, Mouse
		Click XX, YY
		sleep 5
		clickTransformIcon()
		findVFX(foobar)
		Return
	}
	;else if (colorr = "0x757575") ;for 150% ui. again, this values could be different for everyone. check with window spy. This color simply needs to be different from the color when the triangle is closed. it also cannot be the same as a normal panel color (1d1d1d or 232323)
	else if (colorr = "0x7A7A7A") ;for 100% ui
	{
		;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
		blockinput, Mouse
		sleep 5
		clickTransformIcon()
		findVFX(foobar)
		;untwirled = 1
		Return, untwirled
	}
	else if (colorr = "0x1D1D1D" || colorr = "0x232323")
		{
		;tooltip, this is a normal panel color of 0x1d1d1d or %colorr%, which means NO CLIP has been selected ; assuming you didnt change your UI brightness. so we are going to select the top clip at playhead.
		;I should experiement with putting a "deselect all clips on the timeline" shortcut here...
		Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
		sleep 10
		Send ^p ;this disables "selection follows playhead." I don't know if there is a way to CHECK if it is on or not. 
		resetFromAutoVFX()
		;play noise
		;now you need to do all that again, since the motion menu is now open. But only do it ONCE more! 
		If (dontrestart = 0)
			{
			dontrestart = 1
			goto, restartPoint ;this is stupid but it works. Feel free to improve any of my code.
			}
		Return reset
		}
	else
		{
		tooltip, %colorr% not expected
		;play noise
		resetFromAutoVFX()
		Return reset
		}
	}
Return ;from autoscaler part 1


findVFX(foobar) { ; searches for text inside of the Motion effect. requires an actual image.
	;tooltip, WTF
	;msgbox, now we are in findVFX
	sleep 5
	MouseGetPos xPos, yPos
	;CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.

	/*
	if foobar = "scale"
		ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\scale_D2017.png
	else if foobar = "anchor_point"
		ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
	*/

	;ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2018.png

	;something was wrong with using %A_WorkingDir% here. now fixed.

	;ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019.png
	ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\support_files\%foobar%_D2019_ui100.png
	;within 0 shades of variation (this is much faster)
	;obviously, you need to take your own screenshot (look at mine to see what is needed) save as .png, and link to it from the line above.
	;Again, your UI brightness might be different from mine! I now use the DEFAULT brightness.
	; if ErrorLevel = 0
		; msgbox, error 0
	if ErrorLevel = 1 
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\support_files\%foobar%_D2019_ui100.png
	}
	if ErrorLevel = 2 
	{
	    msgbox,,, ERROR LEVEL 2`nCould not conduct the search,1
		resetFromAutoVFX()
		Return
	}
	if ErrorLevel = 1 
	{
		;msgbox, , , error level 1, .7
	    msgbox,,, ERROR LEVEL 1`n%foobar% could not be found on the screeen,1
		resetFromAutoVFX()
		Return
	} else {
		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The %foobar% icon was found at %FoundX%x%FoundY%.
		MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text,1
		sleep 5
		findHotText(foobar)
		Return
	}
}


findHotText(foobar) {
	tooltip, ; removes any tooltips that might be in the way of the searcher.
	;CoordMode Pixel
	MouseGetPos, xxx, yyy

	;msgbox, foobar is %foobar%
	if (foobar = "scale" ||  foobar = "position" || foobar = "rotation") {
		;msgbox,,,scale or the other 3,1
		PixelSearch, Px, Py, xxx+50, yyy, xxx+350, yyy+11, 0x3398EE, 30, Fast RGB ;this is searching to the RIGHT, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI.
		PixelSearch, Px, Py, xxx+50, yyy, xxx+250, yyy+11, 0x2d8ceb, 30, Fast RGB ;this is searching to the RIGHT, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI. TEchnically, I could check to see the size of the Effect controls panel FIRST, and then allow the number that is currently 250 to be less than half that, but I haven't run into too much trouble so far...
	} else if (foobar = "position_vertical") {

		; tooltip, 0.00? ;(looking for that now)
		;msgbox,,, looking for 0.00,0.5
		;ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019.png ;because i never change the value of the anti-flicker filter, (0.00) and it is always the same distance from the actual hot text that i WANT, it is a reliable landmark. So this is a screenshot of THAT.
		ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\support_files\anti-flicker-filter_000_D2019_ui100.png ;for a user interface at 100%...
		;the *3 allows some minor variation in the searched image.
		; PixelSearch, Px, Py, xxx, yyy, xxx+250, yyy+11, 0x2d8ceb, 30, Fast RGB
		;msgbox, found
		if ErrorLevel = 1
			ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\support_files\anti-flicker-filter_000_D2019_2.png
	}

	; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
	; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anti-flicker-filter_000.png


	if ErrorLevel {
	    tooltip, blue not Found
		sleep 100
		resetFromAutoVFX()
		return ;i am not sure if this is needed.
	} else {
		;tooltip, A color within 30 shades of variation was found at X%Px% Y%Py%
		;sleep 1000
	    ;MsgBox, A color within 30 shades of variation was found at X%Px% Y%Py%.
		if (foobar <> "position_vertical") {

			MouseMove, Px+10, Py+5, 0 ;moves the cursor onto the scrubbable hot text
			;msgbox, anything but anchor point vertical
			;sleep 1000
		} else if (foobar = "position_vertical") {
			;msgbox,,,, about to move,0.5
			MouseMove, Px+80, Py-20, 0 ;relative to the unrelated 0.00 text (which I've never changed,) this moves the cursor onto the SECOND variable for the anchor point... the VERTICAL number, rather than horizontal.
			;tooltip, where am I?
			;sleep 2000
		}
		Click down left

		GetKeyState, stateFirstCheck, %VFXkey%, P

		if stateFirstCheck = U 
		{
				;tooltip, you have already released the key.
				;a bit of time has passed by now, so if the user is no longer holding the key down at this point, that means that they pressed it an immediately released it.
				;I am going to take this an an indicaiton that the user just wants to RESET the value, rather than changing it.
				Click up left
				Sleep 10
				;I am removing the clode below, which acts to set specific values automatically, which can be used to "reset" those values. Instead of that, I'm able to type in my own custom value.

				; if (foobar = "scale")
				; {
					; Send, 100
					; sleep 50
					; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
					; sleep 20
				; }
				; if (foobar = "rotation")
				; {
					; Send, 0
					; sleep 50
					; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
					; sleep 20
				; }
				resetFromAutoVFX(0) ;zero means, DO NOT click on the timeline to put the focus there.
				return ;this return has to be here, or the function will continue on to the next loop! Agh, I didn't realize that for a long time, dumb!
			}
		;Now we start the official loop, which will continue as long as the user holds down the VFXkey. They can now simply move the mouse to change the value of the hot text which has been automatically selected for them.
		Loop 
		{
			blockinput, off
			blockinput, MouseMoveOff
			;tooltip, %VFXkey% Instant %foobar% mod
			tooltip, ;removes any tooltips that might exist.
			sleep 15
			GetKeyState, state, %VFXkey%, P ;since this relies on the PHYSICAL state of the key on the attached keyboard, this and other functions do NOT work if you're using Parsec, Teamviewer, or other remote access software.

			;NOW is when the user moves their mouse around to change the value of the hot text. You can also use SHIFT or CTRL to make it change faster or slower. Then release the VFX key to return to normal.

			if state = U 
			{
				Click up left
				;tooltip, "%VFXkey% is now physically UP so we are exiting now"
				sleep 15
				resetFromAutoVFX(1) ;1 means, DO send a middle click to put focus onto the timeline (or wherever the cursor was.)
				; MouseMove, Xbegin, Ybegin, 0
				; tooltip,
				; ToolTip, , , , 2
				; blockinput, off
				; blockinput, MouseMoveOff
				Return
			}
		}
	}
}

resetFromAutoVFX(clicky := 0) {
	;tooltip, you're in RESET land
	;msgbox,,, is resetting working?,1
	global Xbegin
	global Ybegin
	MouseMove, Xbegin, Ybegin, 0
	;MouseMove, global Xbegin, global Ybegin, 0
	;MouseMove, Xbeginlol, Ybeginlol, 0
	
	if clicky = 1
		{
		;tooltip, WHY
		send, {mbutton} ;sends middle click. This will bring the panel you were hovering over, back into focus. Alternatively, i could do this with a keyboard shortcut that highlights the timeline panel, but that is probably less reliable, for... reasons.
		clicky = 0
		}
	;sleep 10
	blockinput, off
	blockinput, MouseMoveOff
	ToolTip, , , , 2
	SetTimer, noTip, 333
}


clickTransformIcon() {
	ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;you will need to set this value to the window class of your own Effect Controls panel! Use window spy and hover over it to find that info.

	; Xcorner := Xcorner+83 ;150% ui
	; Ycorner := Ycorner+98 ;150% ui
	Xcorner := Xcorner+56 ;100% ui
	Ycorner := Ycorner+66 ;100% ui

	MouseMove, Xcorner, Ycorner, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
	sleep 10 ; just to make sure it gets there, this is done twice.
	MouseMove, Xcorner, Ycorner, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
	;msgbox, the cursor should now be positioned directly over the transform icon. `n Xcorner = %Xcorner% `n Ycorner = %Ycorner%
	MouseClick, left
}

Tippy(tipsHere, wait:=500) {
	ToolTip, %tipsHere%,,,8
	SetTimer, noTip, %wait%
}
noTip:
	ToolTip,,,,8
	;removes the tooltip
return

; Remaps capslock toggle to "Ctrl+Alt+Capslock" because I can't type good
CapsLock::		; CapsLock
+CapsLock::		; Shift+CapsLock
!CapsLock::		; Alt+CapsLock
^CapsLock::		; Ctrl+CapsLock
#CapsLock::		; Win+CapsLock
^!#CapsLock::	; Ctrl+Alt+Win+CapsLock
return

^!#r::
	sleep 10
	Soundbeep, 1000, 500
	Reload
Return

WM_LBUTTONDOWN(wParam, lParam)
{
	mX := lParam & 0xFFFF
	mY := lParam >> 16
	SendClickThrough(mX,mY)
}

SendClickThrough(mX,mY)
{
	global 
	
	convertedX := Round((mX / ThumbWidth)*Rwidth + start_x)
	convertedY := Round((mY / ThumbHeight)*Rheight + start_y)
	;msgBox, x%convertedX% y%convertedY%, %targetName%
	ControlClick, x%convertedX% y%convertedY%, %targetName%,,,, NA
	;sleep, 250
	;ControlClick, x%convertedX% y%convertedY%, %targetName%,,,, NA u
}
