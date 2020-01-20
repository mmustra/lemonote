#Include %A_LineFile%\..\..\commandList\index.ahk
#Include %A_LineFile%\..\..\ctce\index.ahk
#Include %A_LineFile%\..\..\ctcm\index.ahk
#Include %A_LineFile%\..\..\ctcr\index.ahk
#Include %A_LineFile%\..\..\pct\index.ahk
#Include %A_LineFile%\..\..\docs\index.ahk
#Include %A_LineFile%\..\..\doco\index.ahk
#Include %A_LineFile%\..\..\doca\index.ahk

class GdsSabreDialogService
{
    static dialogType := {COMMAND_LIST: "commandList"
    , PCTC: "pctc"
    , PCTM: "pctm"
    , CTCE: "ctce"
    , CTCM: "ctcm"
    , CTCR: "ctcr"
    , DOCS: "docs"
    , DOCO: "doco"
    , DOCA: "doca"}
    
    CreateDialog(dialogType)
    {
        result :=
        switch dialogType
        {
            case this.dialogType.COMMAND_LIST: {
                result := GdsSabreCommandListDialog()
            }
            case this.dialogType.PCTC: {
                result := GdsSabrePctDialog()
            }
            case this.dialogType.PCTM: {
                options := {isMobile: true}
                result := GdsSabrePctDialog(options)
            }
            case this.dialogType.CTCE: {
                result := GdsSabreCtceDialog()
            }
            case this.dialogType.CTCM: {
                result := GdsSabreCtcmDialog()
            }
            case this.dialogType.CTCR: {
                result := GdsSabreCtcrDialog()
            }
            case this.dialogType.DOCS: {
                result := GdsSabreDocsDialog()
            }
            case this.dialogType.DOCO: {
                result := GdsSabreDocoDialog()
            }
            case this.dialogType.DOCA: {
                result := GdsSabreDocaDialog()
            }
        }
        return result
    }
}