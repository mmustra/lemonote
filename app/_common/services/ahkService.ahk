class AhkService
{
    HasValue(haystack, needle)
    {
        for index, value in haystack
        {
            if (value == needle) {
                return index
            }
        }
        if (!IsObject(haystack)) {
            throw Exception("AhkService.HasValue() - Bad haystack!", -1, haystack)
        }
        return 0
    }
    
    ArrayJoin(arr, delimiter := ", ")
    {
        str := ""
        for index, value In arr
        {
            str .= value . delimiter
        }
        str := RTrim(str, delimiter)
        return str
    }
    
    EnsureFile(filePath)
    {
        if (FileExist(filePath)) {
            return
        }
        SplitPath, filePath, , folderPath
        this.EnsureFolder(folderPath)
        FileAppend, , % filePath
    }
    
    EnsureFolder(folderPath)
    {
        if (InStr(FileExist(folderPath), "D")) {
            return
        }
        FileCreateDir, % folderPath
    }
}