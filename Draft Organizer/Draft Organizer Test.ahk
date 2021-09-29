#NoEnv
#Include WatchFolder.ahk
#Persistent

Menu, Tray, Add
Menu, Tray, Add, Reset Watch Folder, selectFolder

; global FilesDir="F:\Transcoded Drafts\"
if !FileExist("watchDir.ini") {
    selectFolder()
    IniRead, FilesDir, watchDir.ini, Directory
} else {
    IniRead, FilesDir, watchDir.ini, Directory
}

WatchFolder(FilesDir, "organizeFiles")

organizeFiles(Directory, Changes) {
    IniRead, FilesDir, watchDir.ini, Directory
    Static Actions := ["1 (added)", "2 (removed)", "3 (modified)", "4 (renamed)"]
    For Each, Change In Changes {
       Action := Change.Action
	       ; -------------------------------------------------------------------------------------------------------------------------
       ; Action 1 (added) = File gets added in the watched folder
	       If (Action = 1) {
             ;Get the filelist
             ;---------------------------------------------------------
             FileList = ; Initialize to be blank.
             Loop, %FilesDir%\*.*
                 FileList = %FileList%%A_LoopFileName%`n
             Sort, FileList

             ;Parse filenames and move files into matching folders, adding datestamps in the process.
             ;--------------------------------------------------------- 
             sleep, 10000
             Loop, Parse, FileList, `n
             {
                RegExMatch(A_LoopField, "_([A-Za-z0-9_]+)\.([mp4]{3})", Match)
                    if RegExMatch(Match1, "_[0-9]") 
                        StringTrimRight, Match1, Match1, 2
                    if Match1= ; ignore blank items (if no match is found)
                        continue
                FileCreateDir, %FilesDir%\%Match1%
                FormatTime, CurrentDateTime,, MM.dd.yy-hh.mm
                test = %FilesDir%\%Match1%
                FileMove, %FilesDir%\%A_LoopField%, %FilesDir%\%Match1%\%CurrentDateTime%%A_Space%%A_LoopField%, 1
             }

             ;Move leftover files(with no match) to a specified Dir
             ;---------------------------------------------------------
                FileCreateDir, %FilesDir%\- Unmatched
                FileMove, %FilesDir%\*.*, %FilesDir%\- Unmatched\
             return
        }
    }
}


selectFolder() {
    FileDelete, watchDir.ini
    MsgBox, Select a watch directory
    FileSelectFolder, FilesDir
    IniWrite, %FilesDir%, watchDir.ini, Directory
    Reload
    return
}