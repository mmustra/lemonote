#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsAmadeusPctcModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsAmadeusPctcDialog()
{
    gdsAmadeusPctcDialogTitle := "PCTC - Phone Contact [Amadeus GDS beta]"
    pct := new GdsAmadeusPctcModel
    global passengerName, passengerNameLabel, countryCode, countryCodeLabel, passengerPhone, passengerPhoneLabel, ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsAmadeusPctcDialogShow
    
    GdsAmadeusPctcDialogOnAdd:
        Gui, GdsAmadeusPctcDialog:Submit, NoHide
        result := GdsDialogDataService.ParsePhoneCountryCode(countryCode)
        pct.countryCode := result.value
        pct.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusPctcDialog", "countryCodeLabel", countryCodeColor, countryCodeLabelColor, result)
        result := GdsDialogDataService.ParsePassengerPhone(passengerPhone)
        pct.passengerPhone := result.value
        pct.isValid := pct.isValid ? result.isValid : pct.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusPctcDialog", "passengerPhoneLabel", passengerPhoneColor, passengerPhoneLabelColor, result)
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        pct.passengerIndex := result.value
        pct.isValid := pct.isValid ? result.isValid : pct.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusPctcDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!pct.isValid) {
        return
    }
    
    GdsAmadeusPctcDialogGuiEscape:
    GdsAmadeusPctcDialogGuiClose:
        Gui, GdsAmadeusPctcDialog:Destroy
    return
    
    GdsAmadeusPctcDialogShow:
        Gui, GdsAmadeusPctcDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsAmadeusPctcDialog:Add, GroupBox, x16 y16 w96 h64, Country Code
        Gui, GdsAmadeusPctcDialog:Add, Edit, x32 y40 w64 h21 vcountryCode hwndcountryCodeColor Limit3
        CtlColors.Attach(countryCodeColor)
        Gui, GdsAmadeusPctcDialog:Add, Text, x32 y64 w65 h14 vcountryCodeLabel hwndcountryCodeLabelColor +Disabled, Required field
        CtlColors.Attach(countryCodeLabelColor)
        
        Gui, GdsAmadeusPctcDialog:Add, GroupBox, x120 y16 w200 h64, Phone Number
        Gui, GdsAmadeusPctcDialog:Add, Edit, x136 y40 w168 h21 vpassengerPhone hwndpassengerPhoneColor
        CtlColors.Attach(passengerPhoneColor)
        Gui, GdsAmadeusPctcDialog:Add, Text, x136 y64 w168 h14 vpassengerPhoneLabel hwndpassengerPhoneLabelColor +Disabled, Required field
        CtlColors.Attach(passengerPhoneLabelColor)
        
        Gui, GdsAmadeusPctcDialog:Add, GroupBox, x328 y16 w96 h64, Passenger No.
        Gui, GdsAmadeusPctcDialog:Add, Edit, x344 y40 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsAmadeusPctcDialog:Add, Text, x344 y64 w65 h14 +Disabled vpassengerIndexLabel hwndpassengerIndexLabelColor, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsAmadeusPctcDialog:Add, Button, x328 y96 w96 h31 Default gGdsAmadeusPctcDialogOnAdd, Add
        
        Gui, GdsAmadeusPctcDialog:Show, x-9999 y-9999 w440 h144, % gdsAmadeusPctcDialogTitle
        WindowService.CenterWindow(gdsAmadeusPctcDialogTitle)
        WinWait, % gdsAmadeusPctcDialogTitle
        WinWaitClose
        CtlColors.Free()
    return pct
}
