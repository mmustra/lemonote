class InstallerEnvironment
{
    GetData()
    {
        return {folderPath: A_ScriptDir . "\dist\installer"
        , setupConfigFilePath: A_ScriptDir . "\config\installer\setupConfig.iss"}
    }
}