#NoEnv
#Persistent
#InstallKeybdHook
#SingleInstance, Force
#MaxThreadsPerHotkey, 1
if (A_IsCompiled) {
    #KeyHistory, 0
}
#Include %A_LineFile%\..\..\config\app\index.ahk
#Include %A_LineFile%\..\_libs\index.ahk
#Include %A_LineFile%\..\_common\index.ahk
#Include %A_LineFile%\..\gds\index.ahk
#Include %A_LineFile%\..\notes\index.ahk
#Include %A_LineFile%\..\utility\index.ahk
SetBatchLines, -1
if (A_IsCompiled) {
    ListLines, Off
}
SendMode, Input
SetTitleMatchMode, 3
SetWorkingDir, %A_ScriptDir%
Hotstring("EndChars", "`n")

IniService.Init()
Gds.Init(IniService.configIni.gds.system)
Notes.Init()
Utility.Init()
AppTray.Init()