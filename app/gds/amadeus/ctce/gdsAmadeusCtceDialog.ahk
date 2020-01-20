#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsAmadeusCtceModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsAmadeusCtceDialog()
{
    gdsAmadeusCtceDialogTitle := "CTCE - Email Contact [Amdeus GDS beta]"
    ctce := new GdsAmadeusCtceModel
    global passengerEmail, passengerEmailLabel, ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsAmadeusCtceDialogShow
    
    GdsAmadeusCtceDialogOnAdd:
        Gui, GdsAmadeusCtceDialog:Submit, NoHide
        result := GdsDialogDataService.ParsePassengerEmail(passengerEmail)
        ctce.passengerEmail := result.value
        ctce.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusCtceDialog", "passengerEmailLabel", passengerEmailColor, passengerEmailLabelColor, result)
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        ctce.passengerIndex := result.value
        ctce.isValid := ctce.isValid ? result.isValid : ctce.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusCtceDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!ctce.isValid) {
        return
    }
    
    GdsAmadeusCtceDialogGuiEscape:
    GdsAmadeusCtceDialogGuiClose:
        Gui, GdsAmadeusCtceDialog:Destroy
    return
    
    GdsAmadeusCtceDialogShow:
        Gui, GdsAmadeusCtceDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsAmadeusCtceDialog:Add, GroupBox, x16 y16 w200 h64, Email address
        Gui, GdsAmadeusCtceDialog:Add, Edit, x32 y40 w168 h21 vpassengerEmail hwndpassengerEmailColor
        CtlColors.Attach(passengerEmailColor)
        Gui, GdsAmadeusCtceDialog:Add, Text, x32 y64 w172 h14 vpassengerEmailLabel hwndpassengerEmailLabelColor +Disabled, Required field
        CtlColors.Attach(passengerEmailLabelColor)
        
        Gui, GdsAmadeusCtceDialog:Add, GroupBox, x224 y16 w96 h64, Passenger No.
        Gui, GdsAmadeusCtceDialog:Add, Edit, x240 y40 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsAmadeusCtceDialog:Add, Text, x240 y64 w65 h14 +Disabled vpassengerIndexLabel hwndpassengerIndexLabelColor, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsAmadeusCtceDialog:Add, Button, x224 y96 w96 h31 Default gGdsAmadeusCtceDialogOnAdd, Add
        
        Gui, GdsAmadeusCtceDialog:Show, x-9999 y-9999 w336 h144, % gdsAmadeusCtceDialogTitle
        WindowService.CenterWindow(gdsAmadeusCtceDialogTitle)
        WinWait, % gdsAmadeusCtceDialogTitle
        WinWaitClose
        CtlColors.Free()
    return ctce
}
