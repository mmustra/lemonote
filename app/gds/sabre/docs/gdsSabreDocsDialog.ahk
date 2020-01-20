#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsSabreDocsModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsSabreDocsDialog()
{
    gdsSabreDocsDialogTitle := "SSR DOCS - Passport Information [Sabre GDS]"
    docs := new GdsSabreDocsModel
    global passportCode, passportCodeLabel, passportExpiryDate, passportExpiryDateLabel, passportIssuedBy, passportIssuedByLabel, passengerLastName, passengerLastNameLabel, passengerFirstName, passengerFirstNameLabel, passengerMiddleName, passengerMiddleNameLabel, passengerGender, passengerGenderLabel, passengerDOB, passengerDOBLabel, passengerNationality, passengerNationalityLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsSabreDocsDialogShow
    
    GdsSabreDocsDialogOnAdd:
        Gui, GdsSabreDocsDialog:Submit, NoHide
        result := GdsDialogDataService.ParsePassport(passportCode)
        docs.passportCode := result.value
        docs.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passportCodeLabel", passportCodeColor, passportCodeLabelColor, result)
        
        result := GdsDialogDataService.ParseDate(passportExpiryDate)
        docs.passportExpiryDate := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passportExpiryDateLabel", passportExpiryDateColor, passportExpiryDateLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(passportIssuedBy)
        docs.passportIssuedBy := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passportIssuedByLabel", passportIssuedByColor, passportIssuedByLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerName(passengerLastName)
        docs.passengerLastName := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passengerLastNameLabel", passengerLastNameColor, passengerLastNameLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerName(passengerFirstName)
        docs.passengerFirstName := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passengerFirstNameLabel", passengerFirstNameColor, passengerFirstNameLabelColor, result)
        
        isOptional := true
        result := GdsDialogDataService.ParsePassengerName(passengerMiddleName, isOptional)
        docs.passengerMiddleName := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passengerMiddleNameLabel", passengerMiddleNameColor, passengerMiddleNameLabelColor, result)
        
        result := GdsDialogDataService.ParseGender(passengerGender)
        docs.passengerGender := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passengerGenderLabel", passengerGenderColor, passengerGenderLabelColor, result)
        
        result := GdsDialogDataService.ParseDate(passengerDOB)
        docs.passengerDOB := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passengerDOBLabel", passengerDOBColor, passengerDOBLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(passengerNationality)
        docs.passengerNationality := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passengerNationalityLabel", passengerNationalityColor, passengerNationalityLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        docs.passengerIndex := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocsDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!docs.isValid) {
        return
    }
    
    GdsSabreDocsDialogGuiEscape:
    GdsSabreDocsDialogGuiClose:
        Gui, GdsSabreDocsDialog:Destroy
    return
    
    GdsSabreDocsDialogShow:
        Gui, GdsSabreDocsDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x16 y16 w200 h64, Passport
        Gui, GdsSabreDocsDialog:Add, Edit, x32 y40 w168 h21 vpassportCode hwndpassportCodeColor
        CtlColors.Attach(passportCodeColor)
        Gui, GdsSabreDocsDialog:Add, Text, x32 y64 w168 h14 vpassportCodeLabel hwndpassportCodeLabelColor +Disabled, Required field
        CtlColors.Attach(passportCodeLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x224 y16 w96 h64, Expiry Date
        Gui, GdsSabreDocsDialog:Add, Edit, x240 y40 w64 h21 vpassportExpiryDate hwndpassportExpiryDateColor Limit10
        CtlColors.Attach(passportExpiryDateColor)
        Gui, GdsSabreDocsDialog:Add, Text, x240 y64 w65 h14 vpassportExpiryDateLabel hwndpassportExpiryDateLabelColor +Disabled, Required field
        CtlColors.Attach(passportExpiryDateLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x328 y16 w96 h64, Issued By
        Gui, GdsSabreDocsDialog:Add, Edit, x344 y40 w64 h21 vpassportIssuedBy hwndpassportIssuedByColor Limit3
        CtlColors.Attach(passportIssuedByColor)
        Gui, GdsSabreDocsDialog:Add, Text, x344 y64 w65 h14 vpassportIssuedByLabel hwndpassportIssuedByLabelColor +Disabled, Required field
        CtlColors.Attach(passportIssuedByLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x16 y96 w130 h64, Last Name
        Gui, GdsSabreDocsDialog:Add, Edit, x32 y120 w98 h21 vpassengerLastName hwndpassengerLastNameColor
        CtlColors.Attach(passengerLastNameColor)
        Gui, GdsSabreDocsDialog:Add, Text, x32 y144 w98 h14 vpassengerLastNameLabel hwndpassengerLastNameLabelColor +Disabled, Required field
        CtlColors.Attach(passengerLastNameLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x156 y96 w130 h64, First Name
        Gui, GdsSabreDocsDialog:Add, Edit, x172 y120 w98 h21 vpassengerFirstName hwndpassengerFirstNameColor
        CtlColors.Attach(passengerFirstNameColor)
        Gui, GdsSabreDocsDialog:Add, Text, x172 y144 w98 h14 vpassengerFirstNameLabel hwndpassengerFirstNameLabelColor +Disabled, Required field
        CtlColors.Attach(passengerFirstNameLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x296 y96 w130 h64, Middle Name
        Gui, GdsSabreDocsDialog:Add, Edit, x312 y120 w98 h21 vpassengerMiddleName hwndpassengerMiddleNameColor
        CtlColors.Attach(passengerMiddleNameColor)
        Gui, GdsSabreDocsDialog:Add, Text, x312 y144 w98 h14 vpassengerMiddleNameLabel hwndpassengerMiddleNameLabelColor +Disabled, Optional field
        CtlColors.Attach(passengerMiddleNameLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x16 y176 w96 h64, Gender
        Gui, GdsSabreDocsDialog:Add, DropDownList, x32 y200 w64 vpassengerGender AltSubmit, Male||Female
        Gui, GdsSabreDocsDialog:Add, Text, x32 y224 w65 h14 +Disabled vpassengerGenderLabel hwndpassengerGenderLabelColor, Required field
        CtlColors.Attach(passengerGenderLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x120 y176 w96 h64, Date Of Birth
        Gui, GdsSabreDocsDialog:Add, Edit, x136 y200 w64 h21 vpassengerDOB hwndpassengerDOBColor Limit10
        CtlColors.Attach(passengerDOBColor)
        Gui, GdsSabreDocsDialog:Add, Text, x136 y224 w65 h14 vpassengerDOBLabel hwndpassengerDOBLabelColor +Disabled, Required field
        CtlColors.Attach(passengerDOBLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x224 y176 w96 h64, Nationality
        Gui, GdsSabreDocsDialog:Add, Edit, x240 y200 w64 h21 vpassengerNationality hwndpassengerNationalityColor Limit3
        CtlColors.Attach(passengerNationalityColor)
        Gui, GdsSabreDocsDialog:Add, Text, x240 y224 w65 h14 vpassengerNationalityLabel hwndpassengerNationalityLabelColor +Disabled, Required field
        CtlColors.Attach(passengerNationalityLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, GroupBox, x328 y176 w96 h64, Passenger No.
        Gui, GdsSabreDocsDialog:Add, Edit, x344 y200 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsSabreDocsDialog:Add, Text, x344 y224 w65 h14 vpassengerIndexLabel hwndpassengerIndexLabelColor +Disabled, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsSabreDocsDialog:Add, Button, x328 y256 w96 h31 Default gGdsSabreDocsDialogOnAdd, Add
        
        Gui, GdsSabreDocsDialog:Show, x-9999 y-9999 w440 h302, % gdsSabreDocsDialogTitle
        WindowService.CenterWindow(gdsSabreDocsDialogTitle)
        WinWait, % gdsSabreDocsDialogTitle
        WinWaitClose
        CtlColors.Free()
    return docs
}
