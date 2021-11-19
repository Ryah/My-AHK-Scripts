#NoEnv                        ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input                ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%   ; Ensures a consistent starting directory.
#Persistent

;----------------------------
;;      GLOBAL Rebinds
;----------------------------

;; Rounded Taskbar System Tray Toggle
; #F2::#F2

;; Enable Snipping Tool
; #+S::#+S

;; Rebind Left Windows Key to open launcher
; LWin::Send {Alt Down}{SPACE}{Alt Up}

;----------------------------
;;      VSCODE Rebinds
;----------------------------
;; Rebind CapsLocl to Left Control when VSCode is open for better VIM usability
;; Sends escape if CapsLock is just tapped, effectively disabling it in VSCode.
#IfWinActive ahk_exe Code.exe
^!CapsLock::CapsLock	; <-- Toggle CapsLock in VSCode
CapsLock::LCtrl		; <-- Rebinds CapsLock to Left Control in VSCode for VIM Control
Capslock Up::                 ;<-- When pressing CapsLock alone, it will activate the Escpae button
SendInput, {LControl Up}      ; For stability
If A_TimeSincePriorHotkey < 150
{
  SendInput, {Escape}         ;-- Send Escape when key isn't held down (150ms) 
}
Else
return
return


;----------------------------
;;      VIVALDI Rebinds
;----------------------------

;; Stadia Boss Keys
#IfWinActive ahk_class Chrome_WidgetWin_1
^!S:: ;<-- Exits fullscreen and switches tab in Vivaldi
SendInput, {Escape}
Sleep, 100
SendInput, ^{Tab}