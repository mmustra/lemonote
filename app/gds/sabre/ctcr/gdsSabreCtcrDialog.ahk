#Include %A_LineFile%\..\..\..\..\_libs\index.ahk
#Include %A_LineFile%\..\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\gdsSabreCtcrModel.ahk
#Include %A_LineFile%\..\..\..\services\index.ahk

GdsSabreCtcrDialog()
{
    gdsSabreCtcrDialogTitle := "CTCR - Contact Refusal [Sabre GDS]"
    ctcr := new GdsSabreCtcrModel
    global ssrCode, ssrCodeLabel, passengerIndex, passengerIndexLabel, refusalNote, refusalNoteLabel
    
    Goto, GdsSabreCtcrDialogShow
    
    GdsSabreCtcrDialogOnAdd:
        Gui, GdsSabreCtcrDialog:Submit, NoHide
        result := GdsDialogDataService.ParseSsrCode(ssrCode)
        ctcr.ssrCode := result.value
        ctcr.isValid := result.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtcrDialog", "ssrCodeLabel", ssrCodeColor, ssrCodeLabelColor, result)
        result := GdsDialogDataService.ParsePassengerIndex(passengerIndex)
        ctcr.passengerIndex := result.value
        ctcr.isValid := ctcr.isValid ? result.isValid : ctcr.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtcrDialog", "passengerIndexLabel", passengerIndexColor, passengerIndexLabelColor, result)
        result := GdsDialogDataService.ParseRefusalNote(refusalNote)
        ctcr.refusalNote := result.value
        ctcr.isValid := ctcr.isValid ? result.isValid : ctcr.isValid
        GdsDialogFeatureService.SetDialogLabelMessage("GdsSabreCtcrDialog", "refusalNoteLabel", refusalNoteColor, refusalNoteLabelColor, result)
        
        Sleep, 100
        if (!ctcr.isValid) {
        return
    }
    
    GdsSabreCtcrDialogGuiEscape:
    GdsSabreCtcrDialogGuiClose:
        Gui, GdsSabreCtcrDialog:Destroy
    return
    
    GdsSabreCtcrDialogShow:
        Gui, GdsSabreCtcrDialog:+AlwaysOnTop -MinimizeBox -Maximizebox +Owner
        
        Gui, GdsSabreCtcrDialog:Add, GroupBox, x16 y16 w200 h64, SSR Arlines
        Gui, GdsSabreCtcrDialog:Add, DropDownList, x32 y40 w168 vssrCode AltSubmit, Non AA (GFAX)||AA (FAX)
        Gui, GdsSabreCtcrDialog:Add, Text, x32 y64 w168 h14 +Disabled vssrCodeLabel hwndssrCodeLabelColor, Required field
        CtlColors.Attach(ssrCodeLabelColor)
        
        Gui, GdsSabreCtcrDialog:Add, GroupBox, x224 y16 w96 h64, Passenger No.
        Gui, GdsSabreCtcrDialog:Add, Edit, x240 y40 w64 h21 vpassengerIndex hwndpassengerIndexColor Limit3
        CtlColors.Attach(passengerIndexColor)
        Gui, GdsSabreCtcrDialog:Add, Text, x240 y64 w65 h14 +Disabled vpassengerIndexLabel hwndpassengerIndexLabelColor, Required field
        CtlColors.Attach(passengerIndexLabelColor)
        
        Gui, GdsSabreCtcrDialog:Add, GroupBox, x16 y96 w304 h64, Refusal Note
        Gui, GdsSabreCtcrDialog:Add, Edit, x32 y120 w274 h21 vrefusalNote hwndrefusalNoteColor
        CtlColors.Attach(refusalNoteColor)
        Gui, GdsSabreCtcrDialog:Add, Text, x32 y144 w274 h14 vrefusalNoteLabel hwndrefusalNoteLabelColor +Disabled, Optional field
        CtlColors.Attach(refusalNoteLabelColor)
        
        Gui, GdsSabreCtcrDialog:Add, Button, x224 y176 w96 h31 Default gGdsSabreCtcrDialogOnAdd, Add
        
        Gui, GdsSabreCtcrDialog:Show, x-9999 y-9999 w336 h224, % gdsSabreCtcrDialogTitle
        WindowService.CenterWindow(gdsSabreCtcrDialogTitle)
        WinWait, % gdsSabreCtcrDialogTitle
        WinWaitClose
        CtlColors.Free()
    return ctcr
}

