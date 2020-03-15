#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

#Include %A_ScriptDir%\config\app\dev.ahk
#Include %A_ScriptDir%\config\app\build.ahk
#Include %A_ScriptDir%\config\installer\env.ahk

compileLogFile := ".\build-compile.log"
installerLogFile := ".\build-installer.log"
devConfig := DevEnvironment.GetData()
buildConfig := BuildEnvironment.GetData()
appFolderPath := % buildConfig.folderPath
devAppFilePath := % devConfig.appFilePath
buildAppFilePath := % buildConfig.appFilePath
mainIconFilePath := % devConfig.mainIconFilePath

Progress, b w200, Initializing..., Building Lemonote
Process, Close, Lemonote.exe
FileDelete, % compileLogFile
FileDelete, % installerLogFile
FileRemoveDir, % appFolderPath, true

Progress, 10, Compiling application...

FileCreateDir, % appFolderPath
FileCopyDir, % devConfig.notesFolderPath, % buildConfig.notesFolderPath, true
FileCopy, % devConfig.iconsFilePath, % buildConfig.iconsFilePath, true
FileCopy, % devConfig.helpFilePath, % buildConfig.helpFilePath, true
FileCopy, % devConfig.configIniFilePath, % buildConfig.configIniFilePath, true
licenseFilePath := devConfig.licenseFilePath
FileRead, licenseText, *P65001 %licenseFilePath%
FileAppend, % licenseText, % buildConfig.licenseFilePath, UTF-8

Progress, 40

RunWait, %comspec% /c  Ahk2Exe /in "%devAppFilePath%" /out "%buildAppFilePath%" /icon "%mainIconFilePath%" /mpress 1 > "%compileLogFile%" 2>&1, , hide
if (ErrorLevel) {
    Progress, Off
    return
}

Progress, 70, Creating installer...

installerConfig := InstallerEnvironment.GetData()
installerFolderPath := % installerConfig.folderPath
installerPath := % installerConfig.setupConfigFilePath

RunWait, %comspec% /c iscc "%installerPath%" > "%installerLogFile%" 2>&1, , hide
if (ErrorLevel) {
    Progress, Off
    MsgBox, 262160, Build process - Installer, Problem while creating installer.`nRead log file.
    return
}

Progress, 100

Sleep, 1000
Progress, Off