#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsSabreDocaModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsSabreDocaDialog()
{
    gdsSabreDocaDialogTitle := "SSR DOCA - Destination Information [Sabre GDS]"
    doca := new GdsSabreDocaModel
    global destinationAddress, destinationAddressLabel, destinationCountry, destinationCountryLabel, destinationState, destinationStateLabel, destinationCity, destinationCityLabel, destinationZip, destinationZipLabel, destinationType, destinationTypeLabel, passengerIndex, passengerIndexLabel
    
    Goto, GdsSabreDocaDialogShow
    
    GdsSabreDocaDialogOnAdd:
        Gui, GdsSabreDocaDialog:Submit, NoHide
        result := GdsDialogDataService.ParseAddress(destinationAddress)
        doca.destinationAddress := result.value
        doca.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocaDialog", "destinationAddressLabel", destinationAddressColor, destinationAddressLabelColor, result)
        
        
        result := GdsDialogDataService.ParseCountryCode(destinationCountry)
        doca.destinationCountry := result.value
        doca.isValid := doca.isValid ? result.isValid : doca.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocaDialog", "destinationCountryLabel", destinationCountryColor, destinationCountryLabelColor, result)
        
        result := GdsDialogDataService.ParseState(destinationState)
        doca.destinationState := result.value
        doca.isValid := doca.isValid ? result.isValid : doca.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocaDialog", "destinationStateLabel", destinationStateColor, destinationStateLabelColor, result)
        
        result := GdsDialogDataService.ParseCity(destinationCity)
        doca.destinationCity := result.value
        doca.isValid := doca.isValid ? result.isValid : doca.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocaDialog", "destinationCityLabel", destinationCityColor, destinationCityLabelColor, result)
        
        result := GdsDialogDataService.ParseZip(destinationZip)
        doca.destinationZip := result.value
        doca.isValid := doca.isValid ? result.isValid : doca.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocaDialog", "destinationZipLabel", destinationZipColor, destinationZipLabelColor, result)
        
        result := GdsDialogDataService.ParseDestinationType(destinationType)
        doca.destinationType := result.value
        doca.isValid := doca.isValid ? result.isValid : doca.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocaDialog", "destinationTypeLabel", destinationTypeColor, destinationTypeLabelColor, result)
        
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        doca.passengerIndex := result.value
        doca.isValid := doca.isValid ? result.isValid : doca.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreDocaDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        
        Sleep, 100
        if (!doca.isValid) {
        return
    }
    
    GdsSabreDocaDialogGuiEscape:
    GdsSabreDocaDialogGuiClose:
        Gui, GdsSabreDocaDialog:Destroy
    return
    
    GdsSabreDocaDialogShow:
        Gui, GdsSabreDocaDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsSabreDocaDialog:Add, GroupBox, x16 y16 w408 h64, Address
        Gui, GdsSabreDocaDialog:Add, Edit, x32 y40 w378 h21 vdestinationAddress hwnddestinationAddressColor
        CtlColors.Attach(destinationAddressColor)
        Gui, GdsSabreDocaDialog:Add, Text, x32 y64 w378 h14 vdestinationAddressLabel hwnddestinationAddressLabelColor +Disabled, Required field
        CtlColors.Attach(destinationAddressLabelColor)
        
        Gui, GdsSabreDocaDialog:Add, GroupBox, x16 y96 w130 h64, Conutry
        Gui, GdsSabreDocaDialog:Add, Edit, x32 y120 w98 h21 vdestinationCountry hwnddestinationCountryColor Limit3
        CtlColors.Attach(destinationCountryColor)
        Gui, GdsSabreDocaDialog:Add, Text, x32 y144 w98 h14 vdestinationCountryLabel hwnddestinationCountryLabelColor +Disabled, Required field
        CtlColors.Attach(destinationCountryLabelColor)
        
        Gui, GdsSabreDocaDialog:Add, GroupBox, x152 y96 w130 h64, State
        Gui, GdsSabreDocaDialog:Add, Edit, x168 y120 w98 h21 vdestinationState hwnddestinationStateColor
        CtlColors.Attach(destinationStateColor)
        Gui, GdsSabreDocaDialog:Add, Text, x168 y144 w98 h14 vdestinationStateLabel hwnddestinationStateLabelColor +Disabled, Required field
        CtlColors.Attach(destinationStateLabelColor)
        
        Gui, GdsSabreDocaDialog:Add, GroupBox, x296 y96 w130 h64, City
        Gui, GdsSabreDocaDialog:Add, Edit, x312 y120 w98 h21 vdestinationCity hwnddestinationCityColor
        CtlColors.Attach(destinationCityColor)
        Gui, GdsSabreDocaDialog:Add, Text, x312 y144 w98 h14 vdestinationCityLabel hwnddestinationCityLabelColor +Disabled, Required field
        CtlColors.Attach(destinationCityLabelColor)
        
        Gui, GdsSabreDocaDialog:Add, GroupBox, x16 y176 w130 h64, Zip Code
        Gui, GdsSabreDocaDialog:Add, Edit, x32 y200 w98 h21 vdestinationZip hwnddestinationZipColor
        CtlColors.Attach(destinationZipColor)
        Gui, GdsSabreDocaDialog:Add, Text, x32 y224 w98 h14 vdestinationZipLabel hwnddestinationZipLabelColor +Disabled, Required field
        CtlColors.Attach(destinationZipLabelColor)
        
        Gui, GdsSabreDocaDialog:Add, GroupBox, x152 y176 w130 h64, Desination Type
        Gui, GdsSabreDocaDialog:Add, DropDownList, x168 y200 w98 vdestinationType AltSubmit, Destination||Residental
        Gui, GdsSabreDocaDialog:Add, Text, x168 y224 w98 h14 +Disabled vdestinationTypeLabel hwnddestinationTypeLabelColor, Required field
        CtlColors.Attach(destinationTypeLabelColor)
        
        Gui, GdsSabreDocaDialog:Add, GroupBox, x296 y176 w130 h64, Passenger No.
        Gui, GdsSabreDocaDialog:Add, Edit, x312 y200 w98 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsSabreDocaDialog:Add, Text, x312 y224 w98 h14 vpassengerIndexLabel hwndpassengerIndexLabelColor +Disabled, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsSabreDocaDialog:Add, Button, x328 y256 w96 h31 Default gGdsSabreDocaDialogOnAdd, Add
        
        Gui, GdsSabreDocaDialog:Show, x-9999 y-9999 w440 h304, % gdsSabreDocaDialogTitle
        WindowService.CenterWindow(gdsSabreDocaDialogTitle)
        WinWait, % gdsSabreDocaDialogTitle
        WinWaitClose
        CtlColors.Free()
    return doca
}
