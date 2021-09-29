if !FileExist("watchDir.ini") {
    InputBox, FilesDir, "FilesDir", "Input Draft Location"
    IniWrite, %FilesDir%, watchDir.ini, Directory
} else {
    IniRead, FilesDir2, watchDir.ini, Directory
    global FilesDir=FilesDir2
}

msgbox, ini section is : %FilesDir%