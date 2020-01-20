class ProdEnvironment
{
    GetData()
    {
        return {appFilePath: A_ScriptFullPath
        , notesFolderPath: A_ScriptDir . "\Notes"
        , configIniFilePath: A_ScriptDir . "\config.ini"
        , iconsFilePath: A_ScriptDir . "\icons.dll"
        , helpFilePath: A_ScriptDir . "\help.txt"
        , licenseFilePath: A_ScriptDir . "\LICENSE"
        , isPortable: true}
    }
}