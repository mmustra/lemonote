#Include %A_LineFile%\..\ahkService.ahk
#Include %A_LineFile%\..\..\..\_libs\easyIni.ahk
#Include %A_LineFile%\..\..\..\..\config\app\index.ahk

class IniService
{
    static _defaultIni := "
    (LTrim
    [GDS]
    System=Sabre
    )"
    static configIni :=
    static iniFilePath := Config.GetValue("configIniFilePath")
    static gdsSystemType := {AMADEUS: "Amadeus"
    , SABRE: "Sabre"}
    
    _EnsureConfig()
    {
        if (!FileExist(this.iniFilePath)) {
            AhkService.EnsureFile(this.iniFilePath)
            this.configIni := class_EasyIni(this.iniFilePath, this._defaultIni)
            this.configIni.Save()
        } else if (!this.configIni) {
            this.configIni := class_EasyIni(this.iniFilePath)
        }
    }
    
    Init()
    {
        this._EnsureConfig()
    }
    
    SetGdsSystem(value)
    {
        this._EnsureConfig()
        this.configIni.gds.system := value
        this.configIni.Save()
    }
}