#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsSabreDocoModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsSabreDocoDialog()
{
    gdsSabreDocoDialogTitle := "SSR DOCO - Visa Information [Sabre GDS]"
    doco := new GdsSabreDocoModel
    global visaCode, visaCodeLabel, passengerNationality, passengerNationalityLabel, visaIssueDate, visaIssueDateLabel, visaIssuedBy, visaIssuedByLabel, visaApplicableFor, visaApplicableForLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsSabreDocoDialogShow
    
    GdsSabreDocoDialogOnAdd:
        Gui, GdsSabreDocoDialog:Submit, NoHide
        result := GdsDialogDataService.ParseVisa(visaCode)
        doco.visaCode := result.value
        doco.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocoDialog", "visaCodeLabel", visaCodeColor, visaCodeLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(passengerNationality)
        doco.passengerNationality := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocoDialog", "passengerNationalityLabel", passengerNationalityColor, passengerNationalityLabelColor, result)
        
        result := GdsDialogDataService.ParseDate(visaIssueDate)
        doco.visaIssueDate := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocoDialog", "visaIssueDateLabel", visaIssueDateColor, visaIssueDateLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(visaIssuedBy)
        doco.visaIssuedBy := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocoDialog", "visaIssuedByLabel", visaIssuedByColor, visaIssuedByLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(visaApplicableFor)
        doco.visaApplicableFor := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocoDialog", "visaApplicableForLabel", visaApplicableForColor, visaApplicableForLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        doco.passengerIndex := result.value
        doco.isValid := doco.isValid ? result.isValid : doco.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocoDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!doco.isValid) {
        return
    }
    
    GdsSabreDocoDialogGuiEscape:
    GdsSabreDocoDialogGuiClose:
        Gui, GdsSabreDocoDialog:Destroy
    return
    
    GdsSabreDocoDialogShow:
        Gui, GdsSabreDocoDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsSabreDocoDialog:Add, GroupBox, x16 y16 w200 h64, Visa
        Gui, GdsSabreDocoDialog:Add, Edit, x32 y40 w168 h21 vvisaCode hwndvisaCodeColor
        CtlColors.Attach(visaCodeColor)
        Gui, GdsSabreDocoDialog:Add, Text, x32 y64 w168 h14 vvisaCodeLabel hwndvisaCodeLabelColor +Disabled, Required field
        CtlColors.Attach(visaCodeLabelColor)
        
        Gui, GdsSabreDocoDialog:Add, GroupBox, x224 y16 w200 h64, Nationality
        Gui, GdsSabreDocoDialog:Add, Edit, x240 y40 w168 h21 vpassengerNationality hwndpassengerNationalityColor Limit3
        CtlColors.Attach(passengerNationalityColor)
        Gui, GdsSabreDocoDialog:Add, Text, x240 y64 w168 h14 vpassengerNationalityLabel hwndpassengerNationalityLabelColor +Disabled, Required field
        CtlColors.Attach(passengerNationalityLabelColor)
        
        Gui, GdsSabreDocoDialog:Add, GroupBox, x16 y96 w96 h64, Issue Date
        Gui, GdsSabreDocoDialog:Add, Edit, x32 y120 w64 h21 vvisaIssueDate hwndvisaIssueDateColor Limit10
        CtlColors.Attach(visaIssueDateColor)
        Gui, GdsSabreDocoDialog:Add, Text, x32 y144 w65 h14 vvisaIssueDateLabel hwndvisaIssueDateLabelColor +Disabled, Required field
        CtlColors.Attach(visaIssueDateLabelColor)
        
        Gui, GdsSabreDocoDialog:Add, GroupBox, x120 y96 w96 h64, Issued By
        Gui, GdsSabreDocoDialog:Add, Edit, x136 y120 w64 h21 vvisaIssuedBy hwndvisaIssuedByColor Limit3
        CtlColors.Attach(visaIssuedByColor)
        Gui, GdsSabreDocoDialog:Add, Text, x136 y144 w65 h14 vvisaIssuedByLabel hwndvisaIssuedByLabelColor +Disabled, Required field
        CtlColors.Attach(visaIssuedByLabelColor)
        
        Gui, GdsSabreDocoDialog:Add, GroupBox, x224 y96 w96 h64, Applicable For
        Gui, GdsSabreDocoDialog:Add, Edit, x240 y120 w64 h21 vvisaApplicableFor hwndvisaApplicableForColor Limit3
        CtlColors.Attach(visaApplicableForColor)
        Gui, GdsSabreDocoDialog:Add, Text, x240 y144 w65 h14 vvisaApplicableForLabel hwndvisaApplicableForLabelColor +Disabled, Required field
        CtlColors.Attach(visaApplicableForLabelColor)
        
        Gui, GdsSabreDocoDialog:Add, GroupBox, x328 y96 w96 h64, Passenger No.
        Gui, GdsSabreDocoDialog:Add, Edit, x344 y120 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsSabreDocoDialog:Add, Text, x344 y144 w65 h14 vpassengerIndexLabel hwndpassengerIndexLabelColor +Disabled, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsSabreDocoDialog:Add, Button, x328 y176 w96 h31 Default gGdsSabreDocoDialogOnAdd, Add
        
        Gui, GdsSabreDocoDialog:Show, x-9999 y-9999 w440 h224, % gdsSabreDocoDialogTitle
        WindowService.CenterWindow(gdsSabreDocoDialogTitle)
        WinWait, % gdsSabreDocoDialogTitle
        WinWaitClose
        CtlColors.Free()
    return doco
}
