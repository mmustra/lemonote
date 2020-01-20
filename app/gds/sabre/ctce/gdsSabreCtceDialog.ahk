#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsSabreCtceModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsSabreCtceDialog()
{
    gdsSabreCtceDialogTitle := "CTCE - Email Contact [Sabre GDS]"
    ctce := new GdsSabreCtceModel
    global passengerEmail, passengerEmailLabel, ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsSabreCtceDialogShow
    
    GdsSabreCtceDialogOnAdd:
        Gui, GdsSabreCtceDialog:Submit, NoHide
        result := GdsDialogDataService.ParsePassengerEmail(passengerEmail)
        ctce.passengerEmail := result.value
        ctce.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtceDialog", "passengerEmailLabel", passengerEmailColor, passengerEmailLabelColor, result)
        result := GdsDialogDataService.ParseSsrCode(ssrCode)
        ctce.ssrCode := result.value
        ctce.isValid := ctce.isValid ? result.isValid : ctce.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtceDialog", "ssrCodeLabel", ssrCodeColor, ssrCodeLabelColor, result)
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        ctce.passengerIndex := result.value
        ctce.isValid := ctce.isValid ? result.isValid : ctce.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtceDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!ctce.isValid) {
        return
    }
    
    GdsSabreCtceDialogGuiEscape:
    GdsSabreCtceDialogGuiClose:
        Gui, GdsSabreCtceDialog:Destroy
    return
    
    GdsSabreCtceDialogShow:
        Gui, GdsSabreCtceDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsSabreCtceDialog:Add, GroupBox, x16 y16 w304 h64, Email address
        Gui, GdsSabreCtceDialog:Add, Edit, x32 y40 w274 h21 vpassengerEmail hwndpassengerEmailColor
        CtlColors.Attach(passengerEmailColor)
        Gui, GdsSabreCtceDialog:Add, Text, x32 y64 w274 h14 vpassengerEmailLabel hwndpassengerEmailLabelColor +Disabled, Required field
        CtlColors.Attach(passengerEmailLabelColor)
        
        Gui, GdsSabreCtceDialog:Add, GroupBox, x16 y96 w200 h64, SSR Arlines
        Gui, GdsSabreCtceDialog:Add, DropDownList, x32 y120 w168 vssrCode AltSubmit, Non AA (GFAX)||AA (FAX)
        Gui, GdsSabreCtceDialog:Add, Text, x32 y144 w168 h14 +Disabled vssrCodeLabel hwndssrCodeLabelColor, Required field
        CtlColors.Attach(ssrCodeLabelColor)
        
        Gui, GdsSabreCtceDialog:Add, GroupBox, x224 y96 w96 h64, Passenger No.
        Gui, GdsSabreCtceDialog:Add, Edit, x240 y120 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsSabreCtceDialog:Add, Text, x240 y144 w65 h14 +Disabled vpassengerIndexLabel hwndpassengerIndexLabelColor, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsSabreCtceDialog:Add, Button, x224 y176 w96 h31 Default gGdsSabreCtceDialogOnAdd, Add
        
        Gui, GdsSabreCtceDialog:Show, x-9999 y-9999 w336 h224, % gdsSabreCtceDialogTitle
        WindowService.CenterWindow(gdsSabreCtceDialogTitle)
        WinWait, % gdsSabreCtceDialogTitle
        WinWaitClose
        CtlColors.Free()
    return ctce
}
