#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsAmadeusDocoModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsAmadeusDocoDialog()
{
    gdsAmadeusDocoDialogTitle := "SSR DOCO - Visa Information [Amadeus GDS beta]"
    doco := new GdsAmadeusDocoModel
    global visaCode, visaCodeLabel, passengerPOBCity, passengerPOBCityLabel, passengerPOBCountry, passengerPOBCountryLabel, visaIssueDate, visaIssueDateLabel, visaIssuedBy, visaIssuedByLabel, visaApplicableFor, visaApplicableForLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsAmadeusDocoDialogShow
    
    GdsAmadeusDocoDialogOnAdd:
        Gui, GdsAmadeusDocoDialog:Submit, NoHide
        result := GdsDialogDataService.ParseVisa(visaCode)
        doco.visaCode := result.value
        doco.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocoDialog", "visaCodeLabel", visaCodeColor, visaCodeLabelColor, result)
        
        result := GdsDialogDataService.ParseCity(passengerPOBCity)
        doco.passengerPOBCity := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocoDialog", "passengerPOBCityLabel", passengerPOBCityColor, passengerPOBCityLabelColor, result)

        result := GdsDialogDataService.ParseCountryCode(passengerPOBCountry)
        doco.passengerPOBCountry := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocoDialog", "passengerPOBCountryLabel", passengerPOBCountryColor, passengerPOBCountryLabelColor, result)
        
        result := GdsDialogDataService.ParseDate(visaIssueDate)
        doco.visaIssueDate := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocoDialog", "visaIssueDateLabel", visaIssueDateColor, visaIssueDateLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(visaIssuedBy)
        doco.visaIssuedBy := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocoDialog", "visaIssuedByLabel", visaIssuedByColor, visaIssuedByLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(visaApplicableFor)
        doco.visaApplicableFor := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocoDialog", "visaApplicableForLabel", visaApplicableForColor, visaApplicableForLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        doco.passengerIndex := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocoDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!doco.isValid) {
        return
    }
    
    GdsAmadeusDocoDialogGuiEscape:
    GdsAmadeusDocoDialogGuiClose:
        Gui, GdsAmadeusDocoDialog:Destroy
    return
    
    GdsAmadeusDocoDialogShow:
        Gui, GdsAmadeusDocoDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsAmadeusDocoDialog:Add, GroupBox, x16 y16 w200 h64, Visa
        Gui, GdsAmadeusDocoDialog:Add, Edit, x32 y40 w168 h21 vvisaCode hwndvisaCodeColor
        CtlColors.Attach(visaCodeColor)
        Gui, GdsAmadeusDocoDialog:Add, Text, x32 y64 w168 h14 vvisaCodeLabel hwndvisaCodeLabelColor +Disabled, Required field
        CtlColors.Attach(visaCodeLabelColor)
        
        Gui, GdsAmadeusDocoDialog:Add, GroupBox, x224 y16 w96 h64, Place Of Birth
        Gui, GdsAmadeusDocoDialog:Add, Edit, x240 y40 w64 h21 vpassengerPOBCity hwndpassengerPOBCityColor
        CtlColors.Attach(passengerPOBCityColor)
        Gui, GdsAmadeusDocoDialog:Add, Text, x240 y64 w65 h14 vpassengerPOBCityLabel hwndpassengerPOBCityLabelColor +Disabled, Required field
        CtlColors.Attach(passengerPOBCityLabelColor)

        Gui, GdsAmadeusDocoDialog:Add, GroupBox, x328 y16 w96 h64, Country
        Gui, GdsAmadeusDocoDialog:Add, Edit, x344 y40 w64 h21 vpassengerPOBCountry hwndpassengerPOBCountryColor Limit3
        CtlColors.Attach(passengerPOBCountryColor)
        Gui, GdsAmadeusDocoDialog:Add, Text, x344 y64 w65 h14 vpassengerPOBCountryLabel hwndpassengerPOBCountryLabelColor +Disabled, Required field
        CtlColors.Attach(passengerPOBCountryLabelColor)
        
        Gui, GdsAmadeusDocoDialog:Add, GroupBox, x16 y96 w96 h64, Issue Date
        Gui, GdsAmadeusDocoDialog:Add, Edit, x32 y120 w64 h21 vvisaIssueDate hwndvisaIssueDateColor Limit10
        CtlColors.Attach(visaIssueDateColor)
        Gui, GdsAmadeusDocoDialog:Add, Text, x32 y144 w65 h14 vvisaIssueDateLabel hwndvisaIssueDateLabelColor +Disabled, Required field
        CtlColors.Attach(visaIssueDateLabelColor)
        
        Gui, GdsAmadeusDocoDialog:Add, GroupBox, x120 y96 w96 h64, Issued By
        Gui, GdsAmadeusDocoDialog:Add, Edit, x136 y120 w64 h21 vvisaIssuedBy hwndvisaIssuedByColor Limit3
        CtlColors.Attach(visaIssuedByColor)
        Gui, GdsAmadeusDocoDialog:Add, Text, x136 y144 w65 h14 vvisaIssuedByLabel hwndvisaIssuedByLabelColor +Disabled, Required field
        CtlColors.Attach(visaIssuedByLabelColor)
        
        Gui, GdsAmadeusDocoDialog:Add, GroupBox, x224 y96 w96 h64, Applicable For
        Gui, GdsAmadeusDocoDialog:Add, Edit, x240 y120 w64 h21 vvisaApplicableFor hwndvisaApplicableForColor Limit3
        CtlColors.Attach(visaApplicableForColor)
        Gui, GdsAmadeusDocoDialog:Add, Text, x240 y144 w65 h14 vvisaApplicableForLabel hwndvisaApplicableForLabelColor +Disabled, Required field
        CtlColors.Attach(visaApplicableForLabelColor)
        
        Gui, GdsAmadeusDocoDialog:Add, GroupBox, x328 y96 w96 h64, Passenger No.
        Gui, GdsAmadeusDocoDialog:Add, Edit, x344 y120 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsAmadeusDocoDialog:Add, Text, x344 y144 w65 h14 vpassengerIndexLabel hwndpassengerIndexLabelColor +Disabled, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsAmadeusDocoDialog:Add, Button, x328 y176 w96 h31 Default gGdsAmadeusDocoDialogOnAdd, Add
        
        Gui, GdsAmadeusDocoDialog:Show, x-9999 y-9999 w440 h224, % gdsAmadeusDocoDialogTitle
        WindowService.CenterWindow(gdsAmadeusDocoDialogTitle)
        WinWait, % gdsAmadeusDocoDialogTitle
        WinWaitClose
        CtlColors.Free()
    return doco
}
