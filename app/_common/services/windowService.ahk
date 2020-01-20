#Include %A_LineFile%\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\messageService.ahk

class WindowService
{
    static windowStyleType := {MINIMIZED: -1, DEFAULT: 0, MAXIMIZED: 1}
    static activeWindowTitle :=
    static activeMonitorIndex :=
    
    ResetActiveWindowAndMonitor()
    {
        this.activeWindowTitle :=
        this.activeMonitorIndex :=
    }
    
    StoreActiveWindowAndMonitor()
    {
        Sleep, 100
        this.activeWindowTitle := this.GetActiveWindowTitle()
        this.activeMonitorIndex := this.GetMontiorIndexFromWindowTitle(this.activeWindowTitle)
    }
    
    FocusStoredWindow()
    {
        if (!this.activeWindowTitle) {
            return
        }
        WinGet, activeWindowStyle, MinMax, % this.activeWindowTitle
        if (activeWindowStyle != this.windowStyleType.MINIMIZED) {
            WinActivate, % this.activeWindowTitle
        }
    }
    
    GetActiveWindowTitle()
    {
        activeWindowTitle :=
        WinGetActiveTitle, activeWindowTitle
        WinGet, activeWindowStyle, MinMax, % activeWindowTitle
        if (activeWindowStyle == this.windowStyleType.MINIMIZED) {
            activeWindowTitle := activeWindowTitle . "__minimized"
        }
        return activeWindowTitle
    }
    
    ShowActiveWindowTitleWarningMessage()
    {
        messageTitle := "Program window inactive"
        messageText := "Your initial program window is not active. Lemonote was not able to finish processing.`n`nPlease try again."
        MessageService.ShowMessage(messageText, MessageService.messageType.WARNING, messageTitle)
    }
    
    CenterWindow(windowTitle)
    {
        if (this.activeWindowTitle) {
            monitorIndex := this.GetMontiorIndexFromWindowTitle(this.activeWindowTitle)
        } else {
            activeWindowTitle := this.GetActiveWindowTitle()
            monitorIndex := this.GetMontiorIndexFromWindowTitle(activeWindowTitle)
        }
        SysGet, display_, Monitor, % monitorIndex
        display_Width := display_Right - display_Left
        display_Height := display_Bottom - display_Top
        WinGetPos, , , dialogWindowWidth, dialogWindowHeight, % windowTitle
        WinMove, % windowTitle, , % Floor(display_Left + (display_Width/2) - (dialogWindowWidth/2)), % Floor(display_Top + (display_Height/2) - (dialogWindowHeight/2))
    }
    
    GetMontiorIndexFromWindowTitle(windowTitle)
    {
        WinGet, hwndID, ID, % windowTitle
        return VariousLibs.GetMonitorIndexFromWindowHwnd(hwndID)
    }
}