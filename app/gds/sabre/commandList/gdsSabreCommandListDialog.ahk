#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsSabreCommandListModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsSabreCommandListDialog()
{
    gdsSabreCommandListDialogTitle := "Quick Command List [Sabre GDS]"
    commandList := new GdsSabreCommandListModel
    global passengerEmail, passengerEmailLabel, ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsSabreCommandListDialogShow
    
    GdsSabreCommandListDialogOnAdd:
        Gui, GdsSabreCommandListDialog:Submit, NoHide
        commandList.choice := A_GuiControl

    GdsSabreCommandListDialogGuiEscape:
    GdsSabreCommandListDialogGuiClose:
        Gui, GdsSabreCommandListDialog:Destroy
    return
    
    GdsSabreCommandListDialogShow:
        Gui, GdsSabreCommandListDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsSabreCommandListDialog:Add, GroupBox, x16 y16 w160 h152, Contact Commands
        Gui, GdsSabreCommandListDialog:Add, Button, x32 y40 w128 h31 Default gGdsSabreCommandListDialogOnAdd, % GdsSabreCommandListModel.commandLabel.CTCE
        Gui, GdsSabreCommandListDialog:Add, Button, x32 y80 w128 h31 gGdsSabreCommandListDialogOnAdd, % GdsSabreCommandListModel.commandLabel.CTCM
        Gui, GdsSabreCommandListDialog:Add, Button, x32 y120 w128 h31 gGdsSabreCommandListDialogOnAdd, % GdsSabreCommandListModel.commandLabel.CTCR
        
        Gui, GdsSabreCommandListDialog:Add, GroupBox, x184 y16 w160 h152, APIS Commands
        Gui, GdsSabreCommandListDialog:Add, Button, x200 y40 w128 h31 gGdsSabreCommandListDialogOnAdd, % GdsSabreCommandListModel.commandLabel.DOCS
        Gui, GdsSabreCommandListDialog:Add, Button, x200 y80 w128 h31 gGdsSabreCommandListDialogOnAdd, % GdsSabreCommandListModel.commandLabel.DOCO
        Gui, GdsSabreCommandListDialog:Add, Button, x200 y120 w128 h31 gGdsSabreCommandListDialogOnAdd, % GdsSabreCommandListModel.commandLabel.DOCA
        
        Gui, GdsSabreCommandListDialog:Show, x-9999 y-9999 w360 h183, % gdsSabreCommandListDialogTitle
        WindowService.CenterWindow(gdsSabreCommandListDialogTitle)
        WinWait, % gdsSabreCommandListDialogTitle
        WinWaitClose
    return commandList
}
