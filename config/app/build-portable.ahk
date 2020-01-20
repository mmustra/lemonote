class BuildEnvironment
{
    GetData()
    {
        return {folderPath: A_ScriptDir . "\dist\app-portable"
        , appFilePath: A_ScriptDir . "\dist\app-portable\Lemonote.exe"
        , configIniFilePath: A_ScriptDir . "\dist\app-portable\config.ini"
        , notesFolderPath: A_ScriptDir . "\dist\app-portable\Notes"
        , iconsFilePath: A_ScriptDir . "\dist\app-portable\icons.dll"
        , helpFilePath: A_ScriptDir . "\dist\app-portable\help.txt"
        , licenseFilePath: A_ScriptDir . "\dist\app-portable\LICENSE"}
    }
}