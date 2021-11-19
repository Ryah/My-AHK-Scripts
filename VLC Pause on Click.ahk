	#IfWinActive ahk_exe vlc.exe

		~LButton:: ;<-- [Play|Pause]
			MouseGetPos, , , , VLC_control
			if InStr(VLC_control, "VLC video output")
			{
				Send, {Space}
			}
			VLC_control := ""
			Return
	#IfWinActive
	return