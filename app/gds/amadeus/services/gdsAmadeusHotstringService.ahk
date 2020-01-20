#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsAmadeusDialogService.ahk
#Include %A_LineFile%\..\gdsAmadeusCommandService.ahk
#Include %A_LineFile%\..\..\commandList\index.ahk

class GdsAmadeusHotstringService
{
    static _processingGds := false
    static triggerPrefix := ":?C1X:"
    static gdsInputs := [{key: GdsAmadeusCommandService.commandType.CTCE, dialog: GdsAmadeusDialogService.dialogType.CTCE}
    , {key: GdsAmadeusCommandService.commandType.CTCM, dialog: GdsAmadeusDialogService.dialogType.CTCM}
    , {key: GdsAmadeusCommandService.commandType.PCTC, dialog: GdsAmadeusDialogService.dialogType.PCTC}
    , {key: GdsAmadeusCommandService.commandType.DOCS, dialog: GdsAmadeusDialogService.dialogType.DOCS}
    , {key: GdsAmadeusCommandService.commandType.DOCO, dialog: GdsAmadeusDialogService.dialogType.DOCO}
    , {key: GdsAmadeusCommandService.commandType.DOCA, dialog: GdsAmadeusDialogService.dialogType.DOCA}]
    
    SetTriggers()
    {
        for index, gdsInput in this.gdsInputs
        {
            trigger := this.triggerPrefix . "::" . gdsInput.key
            Hotstring(trigger, this.SendCommand.bind(GdsAmadeusHotstringService, gdsInput.key, gdsInput.dialog))
        }

        trigger := this.triggerPrefix . "::amadeus"
        Hotstring(trigger, this.ChooseCommand.bind(GdsAmadeusHotstringService))
        trigger := this.triggerPrefix . "::list"
        Hotstring(trigger, this.ChooseCommand.bind(GdsAmadeusHotstringService))
    }
    
    SendCommand(commandType, dialogType, skipStoringWindow := false)
    {
        if (this._processingGds) {
            return
        }
        
        this._processingGds := true
        
        if (!skipStoringWindow) {
            WindowService.StoreActiveWindowAndMonitor()
        }

        gdsData := GdsAmadeusDialogService.CreateDialog(dialogType)
        
        if (!gdsData.isValid) {
            WindowService.ResetActiveWindowAndMonitor()
            this._processingGds := false
            return
        }
        
        gdsCommand := GdsAmadeusCommandService.CreateCommand(commandType, gdsData)
        WindowService.FocusStoredWindow()
        
        if (WindowService.activeWindowTitle == WindowService.GetActiveWindowTitle()) {
            Send, % gdsCommand
        } else {
            WindowService.ShowActiveWindowTitleWarningMessage()
        }
        
        WindowService.ResetActiveWindowAndMonitor()
        this._processingGds := false
    }
    
    ChooseCommand()
    {
        if (this._processingGds) {
            return
        }
        
        this._processingGds := true
        WindowService.StoreActiveWindowAndMonitor()
        gdsCommandList := GdsAmadeusDialogService.CreateDialog(GdsAmadeusDialogService.dialogType.COMMAND_LIST)
        
        if (!gdsCommandList.choice) {
            WindowService.ResetActiveWindowAndMonitor()
            this._processingGds := false
            return
        }
        
        commandType := AhkService.HasValue(GdsAmadeusCommandListModel.commandLabel, gdsCommandList.choice)
        StringLower, commandType, commandType
        dialogType := commandType

        this._processingGds := false

        this.SendCommand(commandType, dialogType, true)
    }
}