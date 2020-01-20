#Include %A_LineFile%\..\..\..\config\app\index.ahk
#Include %A_LineFile%\..\..\_common\index.ahk
#Include %A_LineFile%\..\services\index.ahk

;on script exit
OnExit(ObjBindMethod(Notes, "Exit"))

;on system shutdown/restart
DllCall("kernel32.dll\SetProcessShutdownParameters", UInt, 0x4FF, UInt, 0)
OnMessage(0x11, "WM_QUERYENDSESSION")
WM_QUERYENDSESSION(wParam, lParam)
{
    Notes.exit()
    Sleep, 1000
    return true
}

class Notes
{
    Init()
    {
        notesFolderPath := Config.GetValue("notesFolderPath")
        AhkService.EnsureFolder(notesFolderPath)
        NotesHotstringService.SetTriggers()
    }
    
    Exit()
    {
        if (NotesWordService.IsWordAppEmpty()) {
            NotesWordService.CloseWordApp()
        }
    }
}