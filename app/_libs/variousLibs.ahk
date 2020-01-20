class VariousLibs {
    
    ;~ @copyright shinywong | https://autohotkey.com/board/topic/69464-how-to-determine-a-window-is-in-which-monitor
    GetMonitorIndexFromWindowHwnd(windowHandle) {
        monitorIndex := 1
        
        VarSetCapacity(monitorInfo, 40)
        NumPut(40, monitorInfo)
        
        if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2)) 
            && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) 
        {
            monitorLeft   := NumGet(monitorInfo,  4, "Int")
            monitorTop    := NumGet(monitorInfo,  8, "Int")
            monitorRight  := NumGet(monitorInfo, 12, "Int")
            monitorBottom := NumGet(monitorInfo, 16, "Int")
            workLeft      := NumGet(monitorInfo, 20, "Int")
            workTop       := NumGet(monitorInfo, 24, "Int")
            workRight     := NumGet(monitorInfo, 28, "Int")
            workBottom    := NumGet(monitorInfo, 32, "Int")
            isPrimary     := NumGet(monitorInfo, 36, "Int") & 1
            
            SysGet, monitorCount, MonitorCount
            
            Loop, %monitorCount%
            {
                SysGet, tempMon, Monitor, %A_Index%
                
                if ((monitorLeft == tempMonLeft) and (monitorTop == tempMonTop)
                    and (monitorRight == tempMonRight) and (monitorBottom == tempMonBottom))
                {
                    monitorIndex := A_Index
                    break
                }
            }
        }
        
        return monitorIndex
    }

    ;~ @copyright rbrtryn | https://autohotkey.com/board/topic/82826-solved-check-if-drive-is-an-external-hard-disk/
    ; Given a drive letter like "f" return the physical
    ; drive associated with it, i.e. \\\\.\\PHYSICALDRIVE2
    PhysicalFromLogical(d)
    {
        wmi := ComObjGet("winmgmts:")
        
        for LogicalDisk in wmi.ExecQuery("Select * from Win32_LogicalDiskToPartition")
            if InStr(LogicalDisk.Dependent,d)
                for Partition in wmi.ExecQuery("Select * from Win32_DiskDriveToDiskPartition")
                    if (Partition.Dependent = LogicalDisk.Antecedent) {
                        Start := InStr(Partition.Antecedent, """") + 1
                        return SubStr(Partition.Antecedent, Start, -1)
                    }
        return 0
    }

    ; Given a drive path like \\\\.\\PHYSICALDRIVE2 return the
    ; drives interface type, i.e. "USB"
    GetInterface(pd)
    {
        wmi := ComObjGet("winmgmts:")
        
        for Drive in wmi.ExecQuery("Select * from Win32_DiskDrive where DeviceId = """ pd """")
            return Drive.InterfaceType
        return 0
    }

    ; Given a drive path like \\\\.\\PHYSICALDRIVE2 return the drive type, i.e. "Removable"
    ; This is just a wrapper for DriveGet
    GetType(pd)
    {
        StringReplace pd, pd, \\, \, All
        DriveGet out, Type, %pd%
        return out 
    }
}