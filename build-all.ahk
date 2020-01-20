#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

RunWait, % ".\build-installer.ahk"
RunWait, % ".\build-portable.ahk"