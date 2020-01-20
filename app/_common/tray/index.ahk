#Include %A_LineFile%\..\..\..\..\config\app\index.ahk
#Include %A_LineFile%\..\..\services\iniService.ahk
#Include %A_LineFile%\..\..\services\messageService.ahk
#Include %A_LineFile%\..\..\services\ahkService.ahk

class AppTray
{
    static iconsFilePath := Config.GetValue("iconsFilePath")
    static notesFilePath := Config.GetValue("notesFolderPath")
    static helpFilePath := Config.GetValue("helpFilePath")
    
    Init()
    {
        if (A_IsCompiled) {
            Menu, Tray, NoStandard
        } else {
            Menu, Tray, Add
            Menu, Tray, Add
        }
        
        fnRelaodLemonote := this.ReloadLemonote.bind(AppTray)
        fnExitLemonote := this.ExitLemonote.bind(AppTray)
        fnOpenHelpFile := this.OpenHelpFile.bind(AppTray)
        fnOpenNotesFolder := this.OpenNotesFolder.bind(AppTray)
        fnSuspendHotkeys := this.SuspendHotkeys.bind(AppTray)
        fnGDSChangeHandler := this.GDSChangeHandler.bind(AppTray)
        
        Menu, Tray, Tip, Lemonote
        Menu, Tray, Add, Reload Lemonote, % fnRelaodLemonote
        Menu, Tray, Add, Suspend Hotkeys, % fnSuspendHotkeys
        Menu, Tray, Add
        Menu, GDSChangeMenu, Add, % IniService.gdsSystemType.AMADEUS . " (beta)", % fnGDSChangeHandler
        Menu, GDSChangeMenu, Add, % IniService.gdsSystemType.SABRE, % fnGDSChangeHandler
        Menu, Tray, add, Change GDS, :GDSChangeMenu
        Menu, Tray, Add
        Menu, Tray, Add, Notes, % fnOpenNotesFolder
        Menu, Tray, Add, Help, % fnOpenHelpFile
        Menu, Tray, Add
        Menu, Tray, Add, Exit, % fnExitLemonote
        Menu, Tray, Default, Reload Lemonote
        
        switch IniService.configIni.gds.system
        {
            case IniService.gdsSystemType.SABRE: {
                Menu, GDSChangeMenu, Check, % IniService.gdsSystemType.SABRE
            }
            default: {
                Menu, GDSChangeMenu, Check, % IniService.gdsSystemType.AMADEUS . " (beta)"
            }
        }
        
        if (FileExist(this.iconsFilePath)) {
            Menu, Tray, Icon, % this.iconsFilePath, 1, 1
        }
        return
    }
    
    GDSChangeHandler()
    {
        switch A_ThisMenuItem
        {
            case IniService.gdsSystemType.SABRE: {
                Menu, GDSChangeMenu, Check, % IniService.gdsSystemType.SABRE
                IniService.SetGdsSystem(IniService.gdsSystemType.SABRE)
            }
            default: {
                Menu, GDSChangeMenu, Check, % IniService.gdsSystemType.AMADEUS . " (beta)"
                IniService.SetGdsSystem(IniService.gdsSystemType.AMADEUS)
            }
        }
        this.ReloadLemonote()
    }
    
    SuspendHotkeys()
    {
        Menu, Tray, ToggleCheck, Suspend Hotkeys
        Suspend
        if (!FileExist(this.iconsFilePath)) {
            return
        }
        if (A_IsSuspended) {
            Menu, Tray, Icon, % this.iconsFilePath, 2
        } else {
            Menu, Tray, Icon, % this.iconsFilePath, 1
        }
    }
    
    OpenNotesFolder()
    {
        AhkService.EnsureFolder(this.notesFilePath)
        Run, % this.notesFilePath
    }
    
    OpenHelpFile()
    {
        if (!FileExist(this.helpFilePath)) {
            MessageService.ShowMessage("Can't access help file, seems to be missing.`nReinstall Lemonote if you want to access it.", MessageService.messageType.ERROR, "Help file missing")
            return
        }
        Run, % this.helpFilePath
    }
    
    ReloadLemonote()
    {
        Reload
    }
    
    ExitLemonote()
    {
        ExitApp
    }
}