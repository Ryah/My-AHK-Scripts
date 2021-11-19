; Slows down and extends the capslock and numlock keys.
; Original programming by skrommel with modifications by evl k.freeman and nascent
; Code for Sentence case borrowed from JDN and ManaUser.

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases. 
SendMode Input ; Recommended for new scripts due to its superior speed and reliability. 
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory. 

iniRead, NumberLock, CAPShift.ini, Settings, NumberLock, true
iniRead, TimeLockToggle, CAPShift.ini, Settings, TimeLockToggle, 400
iniRead, TimeOut, CAPShift.ini, Settings, TimeOut, 1000
iniRead, ToggleCaps, CAPShift.ini, Settings, ToggleCaps, false
iniRead, progressBar, CAPShift.ini, Settings, progressBar, true
iniRead, lockColor, CAPShift.ini, Settings, lockColor, 00a300
iniRead, menuColor, CAPShift.ini, Settings, menuColor, 3d3d3d
iniRead, enableTooltips, CAPShift.ini, Settings, enableTooltips, true
iniRead, menuOnly, CAPShift.ini, Settings, menuOnly, false
iniRead, soundBeeps, CAPShift.ini, Settings, soundBeeps, false

;Initialise tooltips with a default timer value
SetTimer,TOOLTIP,1500 
SetTimer,TOOLTIP,Off 

ToggleTimer := (TimeLockToggle//10)
MenuTimer := (TimeOut//10)

About = 
(LTrim0 
    CAPShift 2.0
    (v: 01/03/17-01)
    Enhance and stickify the capslock and numlock keys. 

    Hold for %TimeLockToggle% ms to toggle capslock/numlock on or off. 
    Hold for %TimeOut% ms to show a menu that converts selected text to 
        UPPER CASE, lower case, Title Case, iNVERT cASE, etc 

    Written by skrommel, evl, k.freeman and nascent
) 

*CapsLock:: 
    if (menuOnly = "true")
        GoSub, MENU

    counter=0 
    if (progressBar = "true"){
        Progress, ZH16 ZX0 ZY0 B R0-%MenuTimer% CB%lockColor%
    }
    Loop, %MenuTimer% 
    { 
        Sleep,10 
        counter+=1 
        if (progressBar = "true"){
            Progress, %counter% ;, SubText, MainText, WinTitle, FontName 
        }
        If (counter = ToggleTimer) 
        if (progressBar = "true"){
            Progress, ZH16 ZX0 ZY0 B R0-%MenuTimer% CB%menuColor% 
        }
        GetKeyState,state,CapsLock,P 

        if state=U
            Break 
    } 
    if (progressBar = "true"){
        Progress, Off 
    }
    If counter=%MenuTimer% 
        Gosub,MENU 
    Else If (counter>ToggleTimer) 
        Gosub, CapsLock_State_Toggle 
Return 

*NumLock:: 
    if (NOT NumberLock = "true") {
        Gosub, NumLock_State_Toggle 
        return
    }
    if (menuOnly = "true")
        GoSub, MENU

    counter=0 
    if (progressBar = "true"){
        Progress, ZH16 ZX0 ZY0 B R0-%MenuTimer% CB%lockColor%
    }
    Loop, %MenuTimer% 
    { 
        Sleep,10 
        counter+=1 
        if (progressBar = "true"){
            Progress, %counter% ;, SubText, MainText, WinTitle, FontName 
        }
        If (counter = ToggleTimer) 
        if (progressBar = "true"){
            Progress, ZH16 ZX0 ZY0 B R0-%MenuTimer% CB%menuColor% 
        }
        GetKeyState,state,NumLock,P 

        if state=U
            Break 
    } 
    if (progressBar = "true"){
        Progress, Off 
    }
    If counter=%MenuTimer% 
        Gosub,MENU 
    Else If (counter>ToggleTimer) 
        Gosub, NumLock_State_Toggle 
Return 

MENU: 
    Winget, Active_Window, ID, A 
    Send,^c 
    ClipWait,20 
    Menu,main,Add 
    Menu,main,Delete 
    Menu,main,Add,CAPShift, EMPTY
    Menu,main,Add,
    if (ToggleCaps = "true")
    {
        Menu,main,Add,&CapsLock Toggle,CapsLock_State_Toggle
    }
    else
    {
        Menu,main,Add,&CapsLock On,CapsLock_On
        Menu,main,Add,C&apsLock Off,CapsLock_Off
    }
    if (ToggleCaps = "true")
    {
        Menu,main,Add,&NumLock Toggle,NumLock_State_Toggle
    }
    else
    {
        Menu,main,Add,
        Menu,main,Add,&NumLock On,NumLock_On
        Menu,main,Add,N&umLock Off,NumLock_Off
    }
    Menu,main,Add, 
    Menu,settings,Add,&Sticky Numlock,MNUMBERLOCK
    Menu,settings,Add,&Lock Keys Trigger Immediate Menu,MDIRECT
    Menu,settings,Add,&Toggle Timer,TTIMER
    Menu,settings,Add,&Menu Timer, MTIMER
    Menu,settings,Add,Toggle M&enu Item, MTOGGLE
    Menu,settings,Add,Toggle P&rogress Bar, MPROGRESS
    Menu,settings,Add,Toggle Tooltips, MTOOLTIPS
    Menu,settings,Add,Change Pro&gress Bar Color, MlockColor
    Menu,settings,Add,Change Menu Progress Bar &Color, MMENUCOLOR
    Menu,settings,Add,&Beeps When toggling lock state, MSOUNDBEEP
    Menu,convert,Add,&UPPER CASE,MENU_ACTION
    Menu,convert,Add,&lower case,MENU_ACTION
    Menu,convert,Add,&Sentence case,MENU_ACTION
    Menu,convert,Add,&Title Case,MENU_ACTION
    Menu,convert,Add,&Smart Title Case,MENU_ACTION
    Menu,convert,Add,&iNVERT cASE,MENU_ACTION
    Menu,convert,Add,Remove_&under_scores,MENU_ACTION
    Menu,convert,Add,Remove.&full.stops,MENU_ACTION
    Menu, main ,Add,Con&vert Text, :convert
    Menu,main,Add,&Settings, :settings
    Menu,main,Default,CAPShift
    Menu,main,Add,
    Menu,main,Add,&About,ABOUT 
    Menu,main,Add,&Quit,QUIT 
    Menu,main,Show 
Return 

MENU_ACTION: 
    AutoTrim,Off 
    string=%clipboard% 
    clipboard:=Menu_Action(A_ThisMenuItem, string) 
    WinActivate, ahk_id %Active_Window% 
    Send,^v
    string=%tooltiptext%
    stringReplace,tooltiptext,A_ThisMenuItem ,% chr(38),,A ;get rid of ampersand
    tooltiptext = Selection converted to %tooltiptext%
    iniRead, enableTooltips, CAPShift.ini, Settings, enableTooltips, true
    if (NOT enableTooltips = "true"){
        tooltiptext := ""
    }
    ToolTip,%tooltiptext%
    SetTimer,TOOLTIP,On 
Return 

Menu_Action(ThisMenuItem, string) 
{
    Needle =
    (join ltrim comments
        (^|[.!?:;])\W*\K(([A-Z]{2,4})\b          ; first (in the sentence) acronym (upper case $U3)
        |([\w']+)) ; any other first word   (title case $T4)
        |\b(?i)(a|about|above|across|after|against|along|amid|among|amongst|an|and|around|as|at|athwart|atop|barring|before|behind|below|beneath|beside|besides|between|beyond|but|by|circa|concerning|despite|down|during|except|excluding|following|for|from
            |in|including|inside|into|like|minus|near|nor|notwithstanding|of|off|on|onto|opposite|or|out|outside|over|past|plus|regarding|s|save|since|so|the|than|through|till|to|toward|towards|under|underneath|unlike|until|up|upon|verus|via|with|within|without|yet)\b ; not first small words (lower case $L5)
        |\b(?-i)([A-Z]{2,4})\b ; not first acronym  (upper case $U6)
        |\b([\w']+) ; any other word   (title case $T7)
    )

    If ThisMenuItem =&UPPER CASE 
        StringUpper,string,string 

    Else If ThisMenuItem =&lower case 
        StringLower,string,string 

    Else if ThisMenuItem =&Sentence case
    {
        StringLower, string, string
        string := RegExReplace(string, "(((^|([.!?]\s+))[a-z])| i | i')", "$u1")
    } 

    Else If ThisMenuItem =&Title Case 
        StringLower,string,string,T 

    Else If ThisMenuItem =&Smart Title Case 
    {
        ;StringLower, string, string ;this would negate the Acronym check of Needle, but if text is frequently all uppercase before invoking this method, you might want to normalise text to lowercase first
        string := RegExReplace(string,Needle,"$U3$T4$L5$U6$T7")
    } 

    Else If ThisMenuItem =&iNVERT cASE 
    { 
        StringCaseSense,On 
        lower=abcdefghijklmnopqrstuvwxyz 
        upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ 
        StringLen,length,string 
        Loop,%length% 
        { 
            StringLeft,char,string,1 
            StringGetPos,pos,lower,%char% 
            pos+=1 
            If pos<>0 
                StringMid,char,upper,%pos%,1 
            Else 
            { 
                StringGetPos,pos,upper,%char% 
                pos+=1 
                If pos<>0 
                    StringMid,char,lower,%pos%,1 
            } 
            StringTrimLeft,string,string,1 
            string.=char 
        } 
        StringCaseSense,Off 
    } 
    Else If ThisMenuItem =Remove_&under_scores 
        StringReplace, string, string,_,%A_Space%, All 
    Else If ThisMenuItem =Remove.&full.stops 
        StringReplace, string, string,.,%A_Space%, All 
Return string 
} 

EMPTY: 
Return 

;Hides the tooltip after 1 1/2 seconds
TOOLTIP: 
    ToolTip, 
    SetTimer,TOOLTIP,Off 
Return 

CapsLock_State_Toggle: 
    If GetKeyState("CapsLock","T") 
        state=Off 
    Else 
        state=On 
    CapsLock_State_Toggle(state) 
Return 

CapsLock_State_Toggle(State) 
{ 
    tooltiptext = CapsLock %State%
    SetCapsLockState,%State% 
    iniRead, soundBeeps, CAPShift.ini, Settings, soundBeeps, false
    if (soundBeeps = "true"){
        SoundBeep
    }
    iniRead, enableTooltips, CAPShift.ini, Settings, enableTooltips, true
    if (NOT enableTooltips = "true"){
        tooltiptext := ""
    }
    ToolTip,%tooltiptext% 
    SetTimer,TOOLTIP,On 
} 

CapsLock_On:
    state=On 
    CapsLock_State_Toggle(state) 
Return

CapsLock_Off:
    state=Off
    CapsLock_State_Toggle(state) 
Return

NumLock_State_Toggle: 
    If GetKeyState("NumLock","T") 
        state=Off 
    Else 
        state=On 
    NumLock_State_Toggle(state) 
Return 

NumLock_State_Toggle(State) 
{ 
    iniRead, NumberLock, CAPShift.ini, Settings, NumberLock, true
    SetNumLockState,%State% 	
    if (NumberLock = "true") {
        iniRead, soundBeeps, CAPShift.ini, Settings, soundBeeps, false
        if (soundBeeps = "true"){
            SoundBeep
        }
        iniRead, enableTooltips, CAPShift.ini, Settings, enableTooltips, true
        if (enableTooltips = "true"){
            tooltiptext = NumLock %State%
            ToolTip,%tooltiptext% 
            SetTimer,TOOLTIP,On 
        }
    }
} 

NumLock_On:
    state=On 
    NumLock_State_Toggle(state) 
Return

NumLock_Off:
    state=Off
    NumLock_State_Toggle(state) 
Return

MlockColor:
    inputBox, TCCOLOR, CAPShift: Progress Bar Color, Enter the desired color wanted for the capslock/numlock progress bar`n(RGB format example: FF0000 is Red),,,,,,,,%lockColor%
    if TCCOLOR !=
    {
        iniWrite, %TCCOLOR%, CAPShift.ini, Settings, lockColor
        sleep 100
        reload
    }
return 

MMENUCOLOR:
    inputBox, TMCOLOR, CAPShift: Menu Progress Color, Enter the desired color wanted for the menu progress bar`n(RGB format example: FF0000 is Red),,,,,,,,%menuColor%
        if TMCOLOR !=
    {
        iniWrite, %TMCOLOR%, CAPShift.ini, Settings, menuColor
        sleep 100
        reload
    }
return 

MSOUNDBEEP:
    Menu,settings,Add,&Beeps When toggling lock state, MSOUNDBEEP
    MsgBox, 4, CAPShift: Sound Beeps, Select Yes if you want Beeps everytime you toggle Lock State or No for silent operation
        IfMsgBox Yes
    {
        iniWrite, true, CAPShift.ini, Settings, soundBeeps
    }
    else IfMsgBox No
    {
        iniWrite, false, CAPShift.ini, Settings, soundBeeps
    }
    sleep 100
    reload
return

MDIRECT:
    MsgBox, 4, CAPShift: Immediate Menu, Select Yes if you want Lock Keys to trigger immediate menu on keypress (losing typical key functionality), or No for holding key for sticky capslock/numlock and holding longer for menu.
    IfMsgBox Yes
    {
        iniWrite, true, CAPShift.ini, Settings, menuOnly
    }
    else IfMsgBox No
    {
        iniWrite, false, CAPShift.ini, Settings, menuOnly
    }
    sleep 100
    reload
return

TTIMER:
    inputBox, TTIME, CAPShift: Timer, Enter the amount of time you want to press the key to toggle CapsLock on/off (1000 = 1 second),, 320, 140
    if TTIME !=
    {
        iniWrite, %TTIME%, CAPShift.ini, Settings, TimeLockToggle
        sleep 100
        reload
    }
return 

MTIMER:
    inputBox, MTIME, CAPShift: Timer, Enter the amount of time (in milliseconds) you want to press the key to bring up the CAPShift Menu`n(1000 MS = 1 second)`n(Note: rounded to nearest 10ms),, 340, 180
    if MTIME !=
    {
        iniWrite, %MTIME%, CAPShift.ini, Settings, TimeOut
        sleep 100
        reload
    }
return

MNUMBERLOCK:
    MsgBox, 4, CAPShift: Numlock, Select Yes if you want sticky NumLock, or No if you want this program to ignore NumLock
        IfMsgBox Yes
    {
        iniWrite, true, CAPShift.ini, Settings, NumberLock
    }
    else IfMsgBox No
    {
        iniWrite, false, CAPShift.ini, Settings, NumberLock
    }
    sleep 100
    reload
return

MTOGGLE:
    MsgBox, 4, CAPShift:Capslock/Numlock Toogle Menu, Select Yes if you want a combined Capslock Toggle and a combined Numlock Toggle in the menu or No if you want separate On and Off commands for each.
        IfMsgBox Yes
    {
        iniWrite, true, CAPShift.ini, Settings, ToggleCaps
    }
    else IfMsgBox No
    {
        iniWrite, false, CAPShift.ini, Settings, ToggleCaps
    }
    sleep 100
    reload
return

MPROGRESS:
    MsgBox, 4, CAPShift: Progress Bars, Select Yes if you want a progress bar showing how long left to hold CapsLock or NumLock, or No if you don't want a progress bar
        IfMsgBox Yes
    {
        iniWrite, true, CAPShift.ini, Settings, progressBar
    }
    else IfMsgBox No
    {
        iniWrite, false, CAPShift.ini, Settings, progressBar
    }
    sleep 100
    reload
return

MTOOLTIPS:
    MsgBox, 4, CAPShift: Tooltips, Select Yes if you want tooltips showing capslock status after activation or No if you don't want them
        IfMsgBox Yes
    {
        iniWrite, true, CAPShift.ini, Settings, enableTooltips
    }
    else IfMsgBox No
    {
        iniWrite, false, CAPShift.ini, Settings, enableTooltips
    }
    sleep 100
    reload
return

ABOUT: 
    MsgBox,0,CAPShift,%About% 
Return 

QUIT: 
ExitApp