#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsAmadeusCommandListModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsAmadeusCommandListDialog()
{
    gdsAmadeusCommandListDialogTitle := "Quick Command List [Amadeus GDS beta]"
    commandList := new GdsAmadeusCommandListModel
    global passengerEmail, passengerEmailLabel, ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsAmadeusCommandListDialogShow
    
    GdsAmadeusCommandListDialogOnAdd:
        Gui, GdsAmadeusCommandListDialog:Submit, NoHide
        commandList.choice := A_GuiControl

    GdsAmadeusCommandListDialogGuiEscape:
    GdsAmadeusCommandListDialogGuiClose:
        Gui, GdsAmadeusCommandListDialog:Destroy
    return
    
    GdsAmadeusCommandListDialogShow:
        Gui, GdsAmadeusCommandListDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsAmadeusCommandListDialog:Add, GroupBox, x16 y16 w160 h152, Contact Commands
        Gui, GdsAmadeusCommandListDialog:Add, Button, x32 y40 w128 h31 Default gGdsAmadeusCommandListDialogOnAdd, % GdsAmadeusCommandListModel.commandLabel.CTCE
        Gui, GdsAmadeusCommandListDialog:Add, Button, x32 y80 w128 h31 gGdsAmadeusCommandListDialogOnAdd, % GdsAmadeusCommandListModel.commandLabel.CTCM
        Gui, GdsAmadeusCommandListDialog:Add, Button, x32 y120 w128 h31 gGdsAmadeusCommandListDialogOnAdd +Disabled, % GdsAmadeusCommandListModel.commandLabel.CTCR
        
        Gui, GdsAmadeusCommandListDialog:Add, GroupBox, x184 y16 w160 h152, APIS Commands
        Gui, GdsAmadeusCommandListDialog:Add, Button, x200 y40 w128 h31 gGdsAmadeusCommandListDialogOnAdd, % GdsAmadeusCommandListModel.commandLabel.DOCS
        Gui, GdsAmadeusCommandListDialog:Add, Button, x200 y80 w128 h31 gGdsAmadeusCommandListDialogOnAdd, % GdsAmadeusCommandListModel.commandLabel.DOCO
        Gui, GdsAmadeusCommandListDialog:Add, Button, x200 y120 w128 h31 gGdsAmadeusCommandListDialogOnAdd, % GdsAmadeusCommandListModel.commandLabel.DOCA
        
        Gui, GdsAmadeusCommandListDialog:Show, x-9999 y-9999 w360 h183, % gdsAmadeusCommandListDialogTitle
        WindowService.CenterWindow(gdsAmadeusCommandListDialogTitle)
        WinWait, % gdsAmadeusCommandListDialogTitle
        WinWaitClose
    return commandList
}
