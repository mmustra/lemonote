class ProdEnvironment
{
    GetData()
    {
        return {appFilePath: A_ScriptFullPath
        , notesFolderPath: A_MyDocuments . "\Lemonote\Notes"
        , configIniFilePath: A_AppData . "\Lemonote\config.ini"
        , iconsFilePath: A_ScriptDir . "\icons.dll"
        , helpFilePath: A_ScriptDir . "\help.txt"
        , licenseFilePath: A_ScriptDir . "\LICENSE"}
    }
}