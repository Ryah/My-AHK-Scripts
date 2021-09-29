SendMode Input
#InstallKeybdHook
#UseHook On

#SingleInstance force ;only one instance may run at a time!
#MaxHotkeysPerInterval 5000


#IfWinActive ahk_exe Adobe Premiere Pro.exe
+WheelLeft::
    SendInput, {WheelUp 5}
return

+WheelRight::
    SendInput, {WheelDown 5}
return

WheelLeft::
    SendInput, {WheelUp}
return

WheelRight::
    SendInput, {WheelDown}
return


#IfWinActive

;you can put other stuff down here that works in ALL programs.
WheelLeft::
    SendInput {Browser_Back}
return

WheelRight::
    SendInput {Browser_Forward}
return