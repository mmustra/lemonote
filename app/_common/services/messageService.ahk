#Include %A_LineFile%\..\windowService.ahk

;on AHK MsgBox center depending on activeWindowTitle
OnMessage(0x44, "WM_COMMNOTIFY")
WM_COMMNOTIFY(wParam) {
    if (wParam == 1027) {
        Process, Exist
        DetectHiddenWindows, On
        if WinExist("ahk_class #32770 ahk_pid " . ErrorLevel) {
            WindowService.CenterWindow("A")
        }
    }
}

class MessageService
{
    static messageType := {INFO: 64, QUESTION: 32, WARNING: 48, ERROR: 16}
    
    ShowMessage(text, type := 0, title := "")
    {
        onTop := 262144
        title :=  title ? "Lemonote - " . title : "Lemonote"
        type := type is integer && type > 0 ? type : 0
        MsgBox, % type + onTop, % title, % text
        return
    }
    
    ShowTooltipOnCaret(message := "")
    {
        ToolTip, % message ? "Lemonote - " . message : "Lemonote", A_CaretX, A_CaretY
    }
    
    HideTooltip()
    {
        ToolTip
    }
}