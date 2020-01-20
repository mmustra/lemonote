class BuildEnvironment
{
    GetData()
    {
        return {folderPath: A_ScriptDir . "\dist\installer\app"
        , appFilePath: A_ScriptDir . "\dist\installer\app\Lemonote.exe"
        , configIniFilePath: A_ScriptDir . "\dist\installer\app\config.ini"
        , notesFolderPath: A_ScriptDir . "\dist\installer\app\Notes"
        , iconsFilePath: A_ScriptDir . "\dist\installer\app\icons.dll"
        , helpFilePath: A_ScriptDir . "\dist\installer\app\help.txt"
        , licenseFilePath: A_ScriptDir . "\dist\installer\app\LICENSE"}
    }
}