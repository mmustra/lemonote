#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsSabrePctModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsSabrePctDialog(options := "")
{
    gdsSabrePctDialogTitle := options && options.isMobile ? "PCTM - Mobile Contact [Sabre GDS]" : "PCTC - Phone Contact [Sabre GDS]"
    pct := new GdsSabrePctModel
    global passengerName, passengerNameLabel, countryCode, countryCodeLabel, passengerPhone, passengerPhoneLabel, ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsSabrePctDialogShow
    
    GdsSabrePctDialogOnAdd:
        Gui, GdsSabrePctDialog:Submit, NoHide
        result := GdsDialogDataService.ParsePassengerName(passengerName)
        pct.passengerName := result.value
        pct.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabrePctDialog", "passengerNameLabel", passengerNameColor, passengerNameLabelColor, result)
        result := GdsDialogDataService.ParsePhoneCountryCode(countryCode)
        pct.countryCode := result.value
        pct.isValid := pct.isValid ? result.isValid : pct.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabrePctDialog", "countryCodeLabel", countryCodeColor, countryCodeLabelColor, result)
        result := GdsDialogDataService.ParsePassengerPhone(passengerPhone)
        pct.passengerPhone := result.value
        pct.isValid := pct.isValid ? result.isValid : pct.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabrePctDialog", "passengerPhoneLabel", passengerPhoneColor, passengerPhoneLabelColor, result)
        result := GdsDialogDataService.ParseSsrCode(ssrCode)
        pct.ssrCode := result.value
        pct.isValid := pct.isValid ? result.isValid : pct.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabrePctDialog", "ssrCodeLabel", ssrCodeColor, ssrCodeLabelColor, result)
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        pct.passengerIndex := result.value
        pct.isValid := pct.isValid ? result.isValid : pct.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabrePctDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!pct.isValid) {
        return
    }
    
    GdsSabrePctDialogGuiEscape:
    GdsSabrePctDialogGuiClose:
        Gui, GdsSabrePctDialog:Destroy
    return
    
    GdsSabrePctDialogShow:
        Gui, GdsSabrePctDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsSabrePctDialog:Add, GroupBox, x16 y16 w304 h64, Contact Name
        Gui, GdsSabrePctDialog:Add, Edit, x32 y40 w274 h21 vpassengerName hwndpassengerNameColor
        CtlColors.Attach(passengerNameColor)
        Gui, GdsSabrePctDialog:Add, Text, x32 y64 w274 h14 vpassengerNameLabel hwndpassengerNameLabelColor +Disabled, Required field
        CtlColors.Attach(passengerNameLabelColor)
        
        Gui, GdsSabrePctDialog:Add, GroupBox, x16 y96 w96 h64, Country Code
        Gui, GdsSabrePctDialog:Add, Edit, x32 y120 w64 h21 vcountryCode hwndcountryCodeColor Limit3
        CtlColors.Attach(countryCodeColor)
        Gui, GdsSabrePctDialog:Add, Text, x32 y144 w65 h14 vcountryCodeLabel hwndcountryCodeLabelColor +Disabled, Required field
        CtlColors.Attach(countryCodeLabelColor)
        
        Gui, GdsSabrePctDialog:Add, GroupBox, x120 y96 w200 h64, Phone Number
        Gui, GdsSabrePctDialog:Add, Edit, x136 y120 w168 h21 vpassengerPhone hwndpassengerPhoneColor
        CtlColors.Attach(passengerPhoneColor)
        Gui, GdsSabrePctDialog:Add, Text, x136 y144 w168 h14 vpassengerPhoneLabel hwndpassengerPhoneLabelColor +Disabled, Required field
        CtlColors.Attach(passengerPhoneLabelColor)
        
        Gui, GdsSabrePctDialog:Add, GroupBox, x16 y176 w200 h64, SSR Arlines
        Gui, GdsSabrePctDialog:Add, DropDownList, x32 y200 w168 vssrCode AltSubmit, Non AA (GFAX)||AA (FAX)
        Gui, GdsSabrePctDialog:Add, Text, x32 y224 w168 h14 +Disabled vssrCodeLabel hwndssrCodeLabelColor, Required field
        CtlColors.Attach(ssrCodeLabelColor)
        
        Gui, GdsSabrePctDialog:Add, GroupBox, x224 y176 w96 h64, Passenger No.
        Gui, GdsSabrePctDialog:Add, Edit, x240 y200 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsSabrePctDialog:Add, Text, x240 y224 w65 h14 +Disabled vpassengerIndexLabel hwndpassengerIndexLabelColor, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsSabrePctDialog:Add, Button, x224 y256 w96 h31 Default gGdsSabrePctDialogOnAdd, Add
        
        Gui, GdsSabrePctDialog:Show, x-9999 y-9999 w336 h304, % gdsSabrePctDialogTitle
        WindowService.CenterWindow(gdsSabrePctDialogTitle)
        WinWait, % gdsSabrePctDialogTitle
        WinWaitClose
        CtlColors.Free()
    return pct
}
