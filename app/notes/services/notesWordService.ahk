#Include %A_LineFile%\..\..\..\_common\index.ahk

class NotesWordService
{
    static _wordAppPid :=
    static _wordApp :=
    static _wordAppMinVersion := 12 ; NOTICE MS Word 2007
    
    CloseWordApp()
    {
        if (this._wordAppPid) {
            Process, Close, % this._wordAppPid ; NOTICE MS Word 2013-2016
        } else {
            try {
                this._wordApp.Quit() ; NOTICE MS Word 2007-2010
            }
        }
        this._wordAppPid :=
        this._wordApp :=
    }
    
    GetWordApp()
    {
        if (this.IsWordAppAlive() && this.IsWordAppEmpty()) {
            return this._wordApp
        }
        
        wordVersion := this.GetWordMainVersion()
        
        if (wordVersion && wordVersion < this._wordAppMinVersion) {
            return
        }
        
        DetectHiddenWindows, On
        
        try {
            this._wordApp := ComObjCreate("Word.Application")
            this._wordApp.Documents.Add
        } catch e {
            this._wordApp :=
        }
        
        if (this._wordApp) {
            try {
                hwnd := this._wordApp.ActiveWindow.Hwnd
                WinGet, wordAppPid, PID, % "ahk_id " . hwnd
                this._wordAppPid := wordAppPid
            }
            documentSave := 0
            this._wordApp.ActiveDocument.Close(documentSave)
        }
        
        DetectHiddenWindows, Off
        
        return this._wordApp
    }
    
    GetWordMainVersion()
    {
        RegRead, wordPath, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Winword.exe
        FileGetVersion, wordVersion, % wordPath
        numbers := StrSplit(wordVersion, ".")
        return numbers[1]
    }
    
    IsWordAppAlive()
    {
        return ComObjType(this._wordApp, "IID")
    }
    
    IsWordAppEmpty()
    {
        try {
            this._wordApp.ActiveDocument.Name
            return false
        } catch e {
            return true
        }
    }
}