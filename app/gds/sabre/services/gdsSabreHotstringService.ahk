#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\GdsSabreDialogService.ahk
#Include %A_LineFile%\..\GdsSabreCommandService.ahk
#Include %A_LineFile%\..\..\commandList\index.ahk

class GdsSabreHotstringService
{
    static _processingGds := false
    static triggerPrefix := ":?C1X:"
    static gdsInputs := [{key: GdsSabreCommandService.commandType.CTCE, dialog: GdsSabreDialogService.dialogType.CTCE}
    , {key: GdsSabreCommandService.commandType.CTCM, dialog: GdsSabreDialogService.dialogType.CTCM}
    , {key: GdsSabreCommandService.commandType.CTCR, dialog: GdsSabreDialogService.dialogType.CTCR}
    , {key: GdsSabreCommandService.commandType.PCTC, dialog: GdsSabreDialogService.dialogType.PCTC}
    , {key: GdsSabreCommandService.commandType.PCTM, dialog: GdsSabreDialogService.dialogType.PCTM}
    , {key: GdsSabreCommandService.commandType.DOCS, dialog: GdsSabreDialogService.dialogType.DOCS}
    , {key: GdsSabreCommandService.commandType.DOCO, dialog: GdsSabreDialogService.dialogType.DOCO}
    , {key: GdsSabreCommandService.commandType.DOCA, dialog: GdsSabreDialogService.dialogType.DOCA}]
    
    SetTriggers()
    {
        for index, gdsInput in this.gdsInputs
        {
            trigger := this.triggerPrefix . "::" . gdsInput.key
            Hotstring(trigger, this.SendCommand.bind(GdsSabreHotstringService, gdsInput.key, gdsInput.dialog))
        }
        
        trigger := this.triggerPrefix . "::sabre"
        Hotstring(trigger, this.ChooseCommand.bind(GdsSabreHotstringService))
        trigger := this.triggerPrefix . "::list"
        Hotstring(trigger, this.ChooseCommand.bind(GdsSabreHotstringService))
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

        gdsData := GdsSabreDialogService.CreateDialog(dialogType)
        
        if (!gdsData.isValid) {
            WindowService.ResetActiveWindowAndMonitor()
            this._processingGds := false
            return
        }
        
        gdsCommand := GdsSabreCommandService.CreateCommand(commandType, gdsData)
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
        gdsCommandList := GdsSabreDialogService.CreateDialog(GdsSabreDialogService.dialogType.COMMAND_LIST)
        
        if (!gdsCommandList.choice) {
            WindowService.ResetActiveWindowAndMonitor()
            this._processingGds := false
            return
        }
        
        commandType := AhkService.HasValue(GdsSabreCommandListModel.commandLabel, gdsCommandList.choice)
        StringLower, commandType, commandType
        dialogType := commandType

        this._processingGds := false

        this.SendCommand(commandType, dialogType, true)
    }
}