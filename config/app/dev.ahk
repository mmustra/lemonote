class DevEnvironment
{
    GetData()
    {
        return {appFilePath: A_ScriptDir . "\app\index.ahk"
        , notesFolderPath: A_ScriptDir . "\resources\files\notes"
        , configIniFilePath: A_ScriptDir . "\resources\files\config.ini"
        , iconsFilePath: A_ScriptDir . "\resources\icons\icons.dll"
        , helpFilePath: A_ScriptDir . "\resources\files\help.txt"
        , licenseFilePath: A_ScriptDir . "\LICENSE"
        , mainIconFilePath: A_ScriptDir . "\resources\icons\main.ico"}
    }
}