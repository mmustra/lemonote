#Include %A_LineFile%\..\..\_common\index.ahk

class Utility
{
    Init()
    {
        fnPlainClipboard := this.PlainClipboard.bind(Utility)
        Hotkey, ^+v, % fnPlainClipboard
    }
    
    PlainClipboard()
    {
        ClipboardService.StoreClipboard()
        Clipboard := Clipboard
        Send, ^v
        ClipboardService.RestoreClipboard()
    }
}