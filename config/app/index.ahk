#Include %A_LineFile%\..\dev.ahk
#Include %A_LineFile%\..\prod.ahk

class Config
{
    GetValue(key)
    {
        envData := {}
        if (A_IsCompiled) {
            envData := ProdEnvironment.GetData()
        } else {
            envData := DevEnvironment.GetData()
        }
        return envData[key]
    }
}