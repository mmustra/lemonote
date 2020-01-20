#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsAmadeusDocsModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsAmadeusDocsDialog()
{
    gdsAmadeusDocsDialogTitle := "SSR DOCS - Passport Information [Amadeus GDS beta]"
    docs := new GdsAmadeusDocsModel
    global passportCode, passportCodeLabel, passportExpiryDate, passportExpiryDateLabel, passportIssuedBy, passportIssuedByLabel, passengerLastName, passengerLastNameLabel, passengerFirstName, passengerFirstNameLabel, passengerMiddleName, passengerMiddleNameLabel, passengerGender, passengerGenderLabel, passengerDOB, passengerDOBLabel, passengerNationality, passengerNationalityLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsAmadeusDocsDialogShow
    
    GdsAmadeusDocsDialogOnAdd:
        Gui, GdsAmadeusDocsDialog:Submit, NoHide
        result := GdsDialogDataService.ParsePassport(passportCode)
        docs.passportCode := result.value
        docs.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passportCodeLabel", passportCodeColor, passportCodeLabelColor, result)
        
        result := GdsDialogDataService.ParseDate(passportExpiryDate)
        docs.passportExpiryDate := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passportExpiryDateLabel", passportExpiryDateColor, passportExpiryDateLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(passportIssuedBy)
        docs.passportIssuedBy := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passportIssuedByLabel", passportIssuedByColor, passportIssuedByLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerName(passengerLastName)
        docs.passengerLastName := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passengerLastNameLabel", passengerLastNameColor, passengerLastNameLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerName(passengerFirstName)
        docs.passengerFirstName := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passengerFirstNameLabel", passengerFirstNameColor, passengerFirstNameLabelColor, result)
        
        isOptional := true
        result := GdsDialogDataService.ParsePassengerName(passengerMiddleName, isOptional)
        docs.passengerMiddleName := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passengerMiddleNameLabel", passengerMiddleNameColor, passengerMiddleNameLabelColor, result)
        
        result := GdsDialogDataService.ParseGender(passengerGender)
        docs.passengerGender := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passengerGenderLabel", passengerGenderColor, passengerGenderLabelColor, result)
        
        result := GdsDialogDataService.ParseDate(passengerDOB)
        docs.passengerDOB := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passengerDOBLabel", passengerDOBColor, passengerDOBLabelColor, result)
        
        result := GdsDialogDataService.ParseCountryCode(passengerNationality)
        docs.passengerNationality := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passengerNationalityLabel", passengerNationalityColor, passengerNationalityLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        docs.passengerIndex := result.value
        docs.isValid := docs.isValid ? result.isValid : docs.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsAmadeusDocsDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!docs.isValid) {
        return
    }
    
    GdsAmadeusDocsDialogGuiEscape:
    GdsAmadeusDocsDialogGuiClose:
        Gui, GdsAmadeusDocsDialog:Destroy
    return
    
    GdsAmadeusDocsDialogShow:
        Gui, GdsAmadeusDocsDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x16 y16 w200 h64, Passport
        Gui, GdsAmadeusDocsDialog:Add, Edit, x32 y40 w168 h21 vpassportCode hwndpassportCodeColor
        CtlColors.Attach(passportCodeColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x32 y64 w168 h14 vpassportCodeLabel hwndpassportCodeLabelColor +Disabled, Required field
        CtlColors.Attach(passportCodeLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x224 y16 w96 h64, Expiry Date
        Gui, GdsAmadeusDocsDialog:Add, Edit, x240 y40 w64 h21 vpassportExpiryDate hwndpassportExpiryDateColor Limit10
        CtlColors.Attach(passportExpiryDateColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x240 y64 w65 h14 vpassportExpiryDateLabel hwndpassportExpiryDateLabelColor +Disabled, Required field
        CtlColors.Attach(passportExpiryDateLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x328 y16 w96 h64, Issued By
        Gui, GdsAmadeusDocsDialog:Add, Edit, x344 y40 w64 h21 vpassportIssuedBy hwndpassportIssuedByColor Limit3
        CtlColors.Attach(passportIssuedByColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x344 y64 w65 h14 vpassportIssuedByLabel hwndpassportIssuedByLabelColor +Disabled, Required field
        CtlColors.Attach(passportIssuedByLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x16 y96 w130 h64, Last Name
        Gui, GdsAmadeusDocsDialog:Add, Edit, x32 y120 w98 h21 vpassengerLastName hwndpassengerLastNameColor
        CtlColors.Attach(passengerLastNameColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x32 y144 w98 h14 vpassengerLastNameLabel hwndpassengerLastNameLabelColor +Disabled, Required field
        CtlColors.Attach(passengerLastNameLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x156 y96 w130 h64, First Name
        Gui, GdsAmadeusDocsDialog:Add, Edit, x172 y120 w98 h21 vpassengerFirstName hwndpassengerFirstNameColor
        CtlColors.Attach(passengerFirstNameColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x172 y144 w98 h14 vpassengerFirstNameLabel hwndpassengerFirstNameLabelColor +Disabled, Required field
        CtlColors.Attach(passengerFirstNameLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x296 y96 w130 h64, Second Name
        Gui, GdsAmadeusDocsDialog:Add, Edit, x312 y120 w98 h21 vpassengerMiddleName hwndpassengerMiddleNameColor
        CtlColors.Attach(passengerMiddleNameColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x312 y144 w98 h14 vpassengerMiddleNameLabel hwndpassengerMiddleNameLabelColor +Disabled, Optional field
        CtlColors.Attach(passengerMiddleNameLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x16 y176 w96 h64, Gender
        Gui, GdsAmadeusDocsDialog:Add, DropDownList, x32 y200 w64 vpassengerGender AltSubmit, Male||Female|Male Inf|Female Inf
        Gui, GdsAmadeusDocsDialog:Add, Text, x32 y224 w65 h14 +Disabled vpassengerGenderLabel hwndpassengerGenderLabelColor, Required field
        CtlColors.Attach(passengerGenderLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x120 y176 w96 h64, Date Of Birth
        Gui, GdsAmadeusDocsDialog:Add, Edit, x136 y200 w64 h21 vpassengerDOB hwndpassengerDOBColor Limit10
        CtlColors.Attach(passengerDOBColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x136 y224 w65 h14 vpassengerDOBLabel hwndpassengerDOBLabelColor +Disabled, Required field
        CtlColors.Attach(passengerDOBLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x224 y176 w96 h64, Nationality
        Gui, GdsAmadeusDocsDialog:Add, Edit, x240 y200 w64 h21 vpassengerNationality hwndpassengerNationalityColor Limit3
        CtlColors.Attach(passengerNationalityColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x240 y224 w65 h14 vpassengerNationalityLabel hwndpassengerNationalityLabelColor +Disabled, Required field
        CtlColors.Attach(passengerNationalityLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, GroupBox, x328 y176 w96 h64, Passenger No.
        Gui, GdsAmadeusDocsDialog:Add, Edit, x344 y200 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsAmadeusDocsDialog:Add, Text, x344 y224 w65 h14 vpassengerIndexLabel hwndpassengerIndexLabelColor +Disabled, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsAmadeusDocsDialog:Add, Button, x328 y256 w96 h31 Default gGdsAmadeusDocsDialogOnAdd, Add
        
        Gui, GdsAmadeusDocsDialog:Show, x-9999 y-9999 w440 h302, % gdsAmadeusDocsDialogTitle
        WindowService.CenterWindow(gdsAmadeusDocsDialogTitle)
        WinWait, % gdsAmadeusDocsDialogTitle
        WinWaitClose
        CtlColors.Free()
    return docs
}
