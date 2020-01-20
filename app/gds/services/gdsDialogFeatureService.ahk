#Include %A_LineFile%\..\..\..\_libs\ctlColors.ahk

class GdsDialogFeatureService
{
    SetDialogLabelMessage(guiName, controlLabelName, controlColor, controlLabelColor, data)
    {
        message := data.isValid ? "✓" : data.errorMessage
        fontColor := data.isValid ? "00B200" : "CC0000"
        backgroundColor := data.isValid ? "FFFFFF" : "FFFAC8"
        GuiControl, %guiName%:-Disabled, %controlLabelName%
        GuiControl, %guiName%:, %controlLabelName%, %message%
        CtlColors.Change(controlColor, backgroundColor)
        CtlColors.Change(controlLabelColor, "", fontColor)
    }
}