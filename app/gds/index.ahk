#Include %A_LineFile%\..\..\_common\index.ahk
#Include %A_LineFile%\..\amadeus\index.ahk
#Include %A_LineFile%\..\sabre\index.ahk

class Gds
{
    Init(system)
    {
        if (system == IniService.gdsSystemType.AMADEUS) {
            GdsAmadeus.Init()
        } else {
            GdsSabre.Init()
        }
    }
}