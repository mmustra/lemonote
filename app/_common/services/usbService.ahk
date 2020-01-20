#Include %A_LineFile%\..\..\..\..\config\app\index.ahk
#Include %A_LineFile%\..\..\..\_libs\index.ahk

if (A_IsCompiled && Config.GetValue("isPortable")) {
    SplitPath, A_ScriptFullPath, , , , , drive
    physicalDrivePath := VariousLibs.PhysicalFromLogical(drive)
    driveInterface := VariousLibs.GetInterface(physicalDrivePath)
    
    if (driveInterface == "USB") {
        OnMessage(0x219, "WM_DEVICECHANGE")
        WM_DEVICECHANGE(wParam, lParam, msg, hwnd)
        {
            ExitApp
        }
    }
}