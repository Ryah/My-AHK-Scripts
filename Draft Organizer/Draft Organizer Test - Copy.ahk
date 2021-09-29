#NoEnv
#Warn
global FilesDir="F:\Transcoded Drafts\"
;Get the filelist
;---------------------------------------------------------
FileList = ; Initialize to be blank.
Loop, %FilesDir%\*.*
    FileList = %FileList%%A_LoopFileName%`n
Sort, FileList
;Parse filenames and move files into matching folders, adding datestamps in the process.
;--------------------------------------------------------- 
Loop, Parse, FileList, `n
{
    RegExMatch(A_LoopField, "_([A-Za-z0-9_]+)\.([mp4]{3})", Match)
        if Match1= ; ignore blank items (if no match is found)
            continue
    FileCreateDir, %FilesDir%%Match1%
    FormatTime, CurrentDateTime,, MM.dd-hh.mm--
    FileMove, %FilesDir%%A_LoopField%, %FilesDir%%Match1%\%CurrentDateTime%%A_LoopField%, 1

;Move leftover files(with no match) to a specified Dir
;---------------------------------------------------------
   FileCreateDir, %FilesDir%\- Unmatched
   FileMove, %FilesDir%\*.*, %FilesDir%\- Unmatched\
return
}