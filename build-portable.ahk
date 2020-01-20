#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

#Include %A_ScriptDir%\config\app\dev.ahk
#Include %A_ScriptDir%\config\app\build-portable.ahk

compileLogFile := ".\build-portable-compile.log"
devConfig := DevEnvironment.GetData()
buildConfig := BuildEnvironment.GetData()
appFolderPath := % buildConfig.folderPath
devAppFilePath := % devConfig.appFilePath
buildAppFilePath := % buildConfig.appFilePath
mainIconFilePath := % devConfig.mainIconFilePath

Progress, b w200, Initializing..., Building Lemonote (portable)
Process, Close, Lemonote.exe
FileDelete, % compileLogFile
FileRemoveDir, % appFolderPath, true

Progress, 10, Compiling application...

FileCreateDir, % appFolderPath
FileCopyDir, % devConfig.notesFolderPath, % buildConfig.notesFolderPath, true
FileCopy, % devConfig.iconsFilePath, % buildConfig.iconsFilePath, true
FileCopy, % devConfig.helpFilePath, % buildConfig.helpFilePath, true
FileCopy, % devConfig.configIniFilePath, % buildConfig.configIniFilePath, true
FileCopy, % devConfig.licenseFilePath, % buildConfig.licenseFilePath, true
FileMove, % A_ScriptDir . "\config\app\prod.ahk", % A_ScriptDir . "\config\app\prod.ahk.tmp"
FileMove, % A_ScriptDir . "\config\app\prod-portable.ahk", % A_ScriptDir . "\config\app\prod-portable.ahk.tmp"
FileCopy, % A_ScriptDir . "\config\app\prod-portable.ahk.tmp", % A_ScriptDir . "\config\app\prod.ahk"

Progress, 60

RunWait, %comspec% /c  Ahk2Exe /in "%devAppFilePath%" /out "%buildAppFilePath%" /icon "%mainIconFilePath%" /mpress 1 > "%compileLogFile%" 2>&1, , hide
if (ErrorLevel) {
    Progress, Off
    return
}

FileDelete, % A_ScriptDir . "\config\app\prod.ahk"
FileMove, % A_ScriptDir . "\config\app\prod-portable.ahk.tmp", % A_ScriptDir . "\config\app\prod-portable.ahk"
FileMove, % A_ScriptDir . "\config\app\prod.ahk.tmp", % A_ScriptDir . "\config\app\prod.ahk"

Progress, 100

Sleep, 1000
Progress, Off