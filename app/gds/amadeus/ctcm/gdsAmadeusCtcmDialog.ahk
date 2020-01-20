#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsAmadeusCtcmModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsAmadeusCtcmDialog()
{
    gdsAmadeusCtcmDialogTitle := "CTCM - Mobile Contact [Amadeus GDS beta]"
    ctcm := new GdsAmadeusCtcmModel
    global countryCode, countryCodeLabel, passengerPhone, passengerPhoneLabel, ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsAmadeusCtcmDialogShow
    
    GdsAmadeusCtcmDialogOnAdd:
        Gui, GdsAmadeusCtcmDialog:Submit, NoHide
        result := GdsDialogDataService.ParsePhoneCountryCode(countryCode)
        ctcm.countryCode := result.value
        ctcm.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusCtcmDialog", "countryCodeLabel", countryCodeColor, countryCodeLabelColor, result)
        result := GdsDialogDataService.ParsePassengerPhone(passengerPhone)
        ctcm.passengerPhone := result.value
        ctcm.isValid := ctcm.isValid ? result.isValid : ctcm.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusCtcmDialog", "passengerPhoneLabel", passengerPhoneColor, passengerPhoneLabelColor, result)
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        ctcm.passengerIndex := result.value
        ctcm.isValid := ctcm.isValid ? result.isValid : ctcm.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusCtcmDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!ctcm.isValid) {
        return
    }
    
    GdsAmadeusCtcmDialogGuiEscape:
    GdsAmadeusCtcmDialogGuiClose:
        Gui, GdsAmadeusCtcmDialog:Destroy
    return
    
    GdsAmadeusCtcmDialogShow:
        Gui, GdsAmadeusCtcmDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsAmadeusCtcmDialog:Add, GroupBox, x16 y16 w96 h64, Country Code
        Gui, GdsAmadeusCtcmDialog:Add, Edit, x32 y40 w64 h21 vcountryCode hwndcountryCodeColor Limit3
        CtlColors.Attach(countryCodeColor)
        Gui, GdsAmadeusCtcmDialog:Add, Text, x32 y64 w65 h14 vcountryCodeLabel hwndcountryCodeLabelColor +Disabled, Required field
        CtlColors.Attach(countryCodeLabelColor)
        
        Gui, GdsAmadeusCtcmDialog:Add, GroupBox, x120 y16 w200 h64, Phone Number
        Gui, GdsAmadeusCtcmDialog:Add, Edit, x136 y40 w168 h21 vpassengerPhone hwndpassengerPhoneColor
        CtlColors.Attach(passengerPhoneColor)
        Gui, GdsAmadeusCtcmDialog:Add, Text, x136 y64 w168 h14 vpassengerPhoneLabel hwndpassengerPhoneLabelColor +Disabled, Required field
        CtlColors.Attach(passengerPhoneLabelColor)
        
        Gui, GdsAmadeusCtcmDialog:Add, GroupBox, x328 y16 w96 h64, Passenger No.
        Gui, GdsAmadeusCtcmDialog:Add, Edit, x344 y40 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsAmadeusCtcmDialog:Add, Text, x344 y64 w65 h14 +Disabled vpassengerIndexLabel hwndpassengerIndexLabelColor, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsAmadeusCtcmDialog:Add, Button, x328 y96 w96 h31 Default gGdsAmadeusCtcmDialogOnAdd, Add
        
        Gui, GdsAmadeusCtcmDialog:Show, x-9999 y-9999 w440 h144, % gdsAmadeusCtcmDialogTitle
        WindowService.CenterWindow(gdsAmadeusCtcmDialogTitle)
        WinWait, % gdsAmadeusCtcmDialogTitle
        WinWaitClose
        CtlColors.Free()
    return ctcm
}
