#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsSabreCtcmModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsSabreCtcmDialog()
{
    gdsSabreCtcmDialogTitle := "CTCM - Mobile Contact [Sabre GDS]"
    ctcm := new GdsSabreCtcmModel
    global countryCode, countryCodeLabel, passengerPhone, passengerPhoneLabel, ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsSabreCtcmDialogShow
    
    GdsSabreCtcmDialogOnAdd:
        Gui, GdsSabreCtcmDialog:Submit, NoHide
        result := GdsDialogDataService.ParsePhoneCountryCode(countryCode)
        ctcm.countryCode := result.value
        ctcm.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtcmDialog", "countryCodeLabel", countryCodeColor, countryCodeLabelColor, result)
        result := GdsDialogDataService.ParsePassengerPhone(passengerPhone)
        ctcm.passengerPhone := result.value
        ctcm.isValid := ctcm.isValid ? result.isValid : ctcm.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtcmDialog", "passengerPhoneLabel", passengerPhoneColor, passengerPhoneLabelColor, result)
        result := GdsDialogDataService.ParseSsrCode(ssrCode)
        ctcm.ssrCode := result.value
        ctcm.isValid := ctcm.isValid ? result.isValid : ctcm.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtcmDialog", "ssrCodeLabel", ssrCodeColor, ssrCodeLabelColor, result)
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        ctcm.passengerIndex := result.value
        ctcm.isValid := ctcm.isValid ? result.isValid : ctcm.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtcmDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!ctcm.isValid) {
        return
    }
    
    GdsSabreCtcmDialogGuiEscape:
    GdsSabreCtcmDialogGuiClose:
        Gui, GdsSabreCtcmDialog:Destroy
    return
    
    GdsSabreCtcmDialogShow:
        Gui, GdsSabreCtcmDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsSabreCtcmDialog:Add, GroupBox, x16 y16 w96 h64, Country Code
        Gui, GdsSabreCtcmDialog:Add, Edit, x32 y40 w64 h21 vcountryCode hwndcountryCodeColor Limit3
        CtlColors.Attach(countryCodeColor)
        Gui, GdsSabreCtcmDialog:Add, Text, x32 y64 w65 h14 vcountryCodeLabel hwndcountryCodeLabelColor +Disabled, Required field
        CtlColors.Attach(countryCodeLabelColor)
        
        Gui, GdsSabreCtcmDialog:Add, GroupBox, x120 y16 w200 h64, Phone Number
        Gui, GdsSabreCtcmDialog:Add, Edit, x136 y40 w168 h21 vpassengerPhone hwndpassengerPhoneColor
        CtlColors.Attach(passengerPhoneColor)
        Gui, GdsSabreCtcmDialog:Add, Text, x136 y64 w168 h14 vpassengerPhoneLabel hwndpassengerPhoneLabelColor +Disabled, Required field
        CtlColors.Attach(passengerPhoneLabelColor)
        
        Gui, GdsSabreCtcmDialog:Add, GroupBox, x16 y96 w200 h64, SSR Arlines
        Gui, GdsSabreCtcmDialog:Add, DropDownList, x32 y120 w168 vssrCode AltSubmit, Non AA (GFAX)||AA (FAX)
        Gui, GdsSabreCtcmDialog:Add, Text, x32 y144 w168 h14 +Disabled vssrCodeLabel hwndssrCodeLabelColor, Required field
        CtlColors.Attach(ssrCodeLabelColor)
        
        Gui, GdsSabreCtcmDialog:Add, GroupBox, x224 y96 w96 h64, Passenger No.
        Gui, GdsSabreCtcmDialog:Add, Edit, x240 y120 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsSabreCtcmDialog:Add, Text, x240 y144 w65 h14 +Disabled vpassengerIndexLabel hwndpassengerIndexLabelColor, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsSabreCtcmDialog:Add, Button, x224 y176 w96 h31 Default gGdsSabreCtcmDialogOnAdd, Add
        
        Gui, GdsSabreCtcmDialog:Show, x-9999 y-9999 w336 h224, % gdsSabreCtcmDialogTitle
        WindowService.CenterWindow(gdsSabreCtcmDialogTitle)
        WinWait, % gdsSabreCtcmDialogTitle
        WinWaitClose
        CtlColors.Free()
    return ctcm
}
