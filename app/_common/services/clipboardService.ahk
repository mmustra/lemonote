;ClipboardAll can't be saved inside object, autohotkey v1 limitation
global tempClipboard :=

class ClipboardService
{
    StoreClipboard()
    {
        tempClipboard := ClipboardAll
    }
    
    RestoreClipboard()
    {
        Sleep, 250
        Clipboard := tempClipboard
        tempClipboard :=
    }
}