#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Goal
;The goal of this script is to allow, with the push of ONE button, to switch between 2 (or more) Windows Virtual Desktops


;Process
;This code retrieves a list of all VirtualDesktopIDs, a VirtualDesktopIDs is defined in Windows as a REG_BINARY
;This is list is stored into a single variable (= consecutive VirtualDesktopIDs in one variable), knowing the length of a single VirtualDesktopIDs, it cuts the variable into an array of VirtualDesktopIDs
;The script retrieves the current VirtualDesktopID, it looks for its position in the array, and uses that to know in what Virtual Desktop it is currently in
;The script then reacts accordingly


;Notes
;It is recommended to use 2 Virtual Desktops (3 max), however this could work with as many Virtual Desktops as desired


global ID_LENGTH := StrLen(getCurrentDesktopId()) ;Usually 32, but we never know with Windows Updates

F13:: ; <-- Cycle Desktops

	if WinActive("ahk_exe VirtualBoxVM.exe") { ;When running a VM with VirtualBox, this will escape the character execute the script correctly
		SendInput, {RControl up} ;Shortcut to escape VM control
	}

	if WinActive("ahk_exe vmplayer.exe") { ;When running a VM with VirtualBox, this will escape the character execute the script correctly
		MsgBox, test
		;SendInput, {Ctrl}{Alt} ;Shortcut to escape VM control
	}

	If (A_TimeSincePriorHotkey < 500) ;Prevents rapid double click, specifically set for iCue when keyboard changes profiles
			Return

	desktopCount := getArrayFromVirtualDesktopIds().MaxIndex()
	
	currentDesktop := getCurrentDesktop()
	
	if (currentDesktop = desktopCount) {
		Loop, %desktopCount% {
			SendInput ^#{Left}
			Sleep 75 ;Delay between each press, tweak if you are experiencing issues going back to the first Virtual Desktop
		}
		return
	} else {
		SendInput ^#{Right}
		return
	}
	
getCurrentDesktop()
{
	currentDesktopId := getCurrentDesktopId()
	listDesktops := getArrayFromVirtualDesktopIds()
	return ObjIndexOf(listDesktops, currentDesktopId)
}

getCurrentDesktopId()
{
	sessionId := getSessionId() ;This variable is used to get the current VirtualDesktopID
	RegRead, currentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%sessionId%\VirtualDesktops, CurrentVirtualDesktop ;Stores the current VirtualDesktopID in CurrentDesktopId
	return currentDesktopId
}

getArrayFromVirtualDesktopIds()
{
	RegRead, virtualDesktopIds, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
	
	listDesktops := []
	while (virtualDesktopIds) { ;This loop will break up all the VirtualDesktopIDs neatly in an array
		listDesktops.push(SubStr(virtualDesktopIds, 1 , ID_LENGTH))
		StringTrimLeft virtualDesktopIds, virtualDesktopIds, ID_LENGTH
    }
	return listDesktops
}


ObjIndexOf(obj, item, case_sensitive:=false)
{
	for i, val in obj {
		if (case_sensitive ? (val == item) : (val = item))
			return i
	}
}

getSessionId()
{
    ProcessId := DllCall("GetCurrentProcessId", "UInt")
    if ErrorLevel {
        OutputDebug, Error getting current process id: %ErrorLevel%
        return
    }
    OutputDebug, Current Process Id: %ProcessId%

    DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
    if ErrorLevel {
        OutputDebug, Error getting session id: %ErrorLevel%
        return
    }
    OutputDebug, Current Session Id: %SessionId%
    return SessionId
}

