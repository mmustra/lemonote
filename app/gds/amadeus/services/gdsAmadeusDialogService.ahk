#Include %A_LineFile%\..\..\commandList\index.ahk
#Include %A_LineFile%\..\..\ctce\index.ahk
#Include %A_LineFile%\..\..\ctcm\index.ahk
#Include %A_LineFile%\..\..\pctc\index.ahk
#Include %A_LineFile%\..\..\docs\index.ahk
#Include %A_LineFile%\..\..\doco\index.ahk
#Include %A_LineFile%\..\..\doca\index.ahk

class GdsAmadeusDialogService
{
    static dialogType := {COMMAND_LIST: "commandList"
    , PCTC: "pctc"
    , CTCE: "ctce"
    , CTCM: "ctcm"
    , DOCS: "docs"
    , DOCO: "doco"
    , DOCA: "doca"}
    
    CreateDialog(dialogType)
    {
        result :=
        switch dialogType
        {
            case this.dialogType.COMMAND_LIST: {
                result := GdsAmadeusCommandListDialog()
            }
            case this.dialogType.PCTC: {
                result := GdsAmadeusPctcDialog()
            }
            case this.dialogType.CTCE: {
                result := GdsAmadeusCtceDialog()
            }
            case this.dialogType.CTCM: {
                result := GdsAmadeusCtcmDialog()
            }
            case this.dialogType.DOCS: {
                result := GdsAmadeusDocsDialog()
            }
            case this.dialogType.DOCO: {
                result := GdsAmadeusDocoDialog()
            }
            case this.dialogType.DOCA: {
                result := GdsAmadeusDocaDialog()
            }
        }
        return result
    }
}