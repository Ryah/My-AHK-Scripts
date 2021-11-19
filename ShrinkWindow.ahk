; Click the middle button to shrink window - support multiple windows and display contents dynamically.

#NoEnv
SetBatchLines -1
CoordMode, Mouse, Screen
SysGet, SM_CXSIZEFRAME, 32
SysGet, SM_CYSIZEFRAME, 33
SM_CXSIZEFRAME:=SM_CXSIZEFRAME="" ? 0 : SM_CXSIZEFRAME
SM_CYSIZEFRAME:=SM_CYSIZEFRAME="" ? 0 : SM_CYSIZEFRAME
GuiLable:=0, Windows:={}
OnExit, ExitShrink
SetTimer, Repaint, 100

~F24:: ;<-- Shrink Window (F12 on 2nd Keyboard)
  MouseGetPos, x, y, Win
  WinGetClass, MouseClass, % "ahk_id " Win
  
  ; Ignore specific windows
  If (MouseClass ~= "Progman|Windows.UI.Core.CoreWindow|Shell_TrayWnd") {
    return
  }
  
  if (Windows.HasKey("h" Win))
    RestoreShrink("h" Win)
  else
  {
    zoom:=0.2

    WinSet, ExStyle, +0x00000080, ahk_id %Win%
    WinSet, Transparent, 0,       ahk_id %Win%
    WinGetPos, , , sw, sh,        ahk_id %Win%

    ratio:=sw/sh, dw:=sw*zoom, dh:=dw/ratio, GuiLable+=1
    Gui, %GuiLable%:+ToolWindow -Caption +AlwaysOnTop +Border +HwndShrinkID
    Gui, %GuiLable%:Show, x%x% y%y% w%dw% h%dh%, 微缩窗口

    dest_hdc   := DllCall("GetDC", "UInt", ShrinkID)
    source_hdc := DllCall("GetWindowDC", "UInt", Win)
    DllCall("gdi32\SetStretchBltMode", "UPtr", dest_hdc, "Int", 4)

      Windows["h" ShrinkID, "GuiLable"]   := GuiLable
    , Windows["h" ShrinkID, "hwnd"]       := Win
    , Windows["h" ShrinkID, "source_hdc"] := source_hdc
    , Windows["h" ShrinkID, "dest_hdc"]   := dest_hdc
    , Windows["h" ShrinkID, "sw"]         := sw
    , Windows["h" ShrinkID, "sh"]         := sh
    , Windows["h" ShrinkID, "dw"]         := dw
    , Windows["h" ShrinkID, "dh"]         := dh
  }
return

Repaint:
  for k, v in Windows
    DllCall("gdi32\StretchBlt"
          , "UInt", v.dest_hdc
          , "Int",  0
          , "Int",  0
          , "Int",  v.dw
          , "Int",  v.dh
          , "UInt", v.source_hdc
          , "UInt", SM_CXSIZEFRAME
          , "UInt", 0
          , "Int",  v.sw-2*SM_CXSIZEFRAME
          , "Int",  v.sh-SM_CYSIZEFRAME
          , "UInt", 0xCC0020)
return

ExitShrink:
  SetTimer, Repaint, Off
  for k, v in Windows.Clone()
    RestoreShrink(k)
  ExitApp
return

RestoreShrink(Win)
{
  global Windows
  o:=Windows[Win], GuiLable:=o.GuiLable

  WinSet, ExStyle, -0x00000080, % "ahk_id " o.hwnd
  WinSet, Transparent, 255,     % "ahk_id " o.hwnd
  WinSet, Transparent, Off,     % "ahk_id " o.hwnd
  WinSet, Redraw, ,             % "ahk_id " o.hwnd
  WinActivate,                  % "ahk_id " o.hwnd

  DllCall("gdi32\DeleteDC", "UInt", o.dest_hdc)
  DllCall("gdi32\DeleteDC", "UInt", o.source_hdc)
  Gui, %GuiLable%:Destroy

  Windows.Delete(Win)
}

WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
	static init := OnMessage(0x0201, "WM_LButtonDOWN")
	PostMessage, 0xA1, 2,,, A
}