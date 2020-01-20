#Include %A_LineFile%\..\..\..\..\config\app\index.ahk
#Include %A_LineFile%\..\..\..\_common\index.ahk
#Include %A_LineFile%\..\notesWordService.ahk

class NotesHotstringService
{
    static _processingNote := false
    static _loadingState := false
    static _notesFolderPath := Config.GetValue("notesFolderPath")
    static plainFileTypes := [".txt"]
    static richTextFileTypes := [".doc", ".docm", ".docx", ".dot", ".dotm", ".dotx", ".htm", ".html", ".mht", ".mhtml", ".odt", ".rtf", ".wps", ".xml", ".xps"]
    static notes := {}
    static triggerPrefix := ":?C1X:"
    
    SetTriggers()
    {
        loop, Files, % this._notesFolderPath . "\*.*", R
        {
            SplitPath, A_LoopFileLongPath, noteFileName, , noteFileExtension, noteKey
            StringLower, noteFileExtension, noteFileExtension
            StringLower, noteKey, noteKey
            noteKey := ":" . noteKey
            if (this.notes[noteKey]) {
                continue
            }
            this.notes[noteKey] := {fileName: noteFileName, fileExtension: noteFileExtension, filePath: A_LoopFileLongPath}
            trigger := this.triggerPrefix . noteKey
            Hotstring(trigger, this.NoteTrigger.bind(NotesHotstringService))
        }
    }
    
    NoteTrigger()
    {
        if (this._processingNote) {
            return
        }
        
        this.StartProcessing()
        
        AhkService.EnsureFolder(this._notesFolderPath)
        
        trimLength := StrLen(this.triggerPrefix) + 1
        noteKey := SubStr(A_ThisHotkey, trimLength)
        StringLower, noteKey, noteKey
        noteFileName := this.notes[noteKey].fileName
        noteFileExtension := "." . this.notes[noteKey].fileExtension
        noteFilePath := this.notes[noteKey].filePath
        
        if (this.IsRichTextFileType(noteFileExtension)) {
            if (!NotesWordService.IsWordAppAlive() || !NotesWordService.IsWordAppEmpty()) {
                MessageService.ShowTooltipOnCaret("Initializing...")
            }
            wordApp := NotesWordService.GetWordApp()
            if (!wordApp) {
                this.StopProcessing()
                this.ShowMsWordErrorMessage()
                return
            }
            try {
                documentConversionConfirmDialog := 0
                documentOpenAsReadOnly := 1
                documentAddToRecentFiles := 0
                wordDoc := wordApp.Documents.Open(noteFilePath, documentConversionConfirmDialog, documentOpenAsReadOnly, documentAddToRecentFiles)
                try {
                    wordDoc.Range.FormattedText.Copy
                    Clipwait, 10, 1
                }
                Sleep, 250
                documentSave := 0
                wordDoc.Close(documentSave)
            } catch e {
                this.StopProcessing()
                this.ShowFileOpenErrorMessage(noteFileName, noteKey)
                return
            }
        } else if (this.IsPlainFileType(noteFileExtension)) {
            FileRead, Clipboard, % noteFilePath
            Clipwait, 1
        } else {
            this.StopProcessing()
            this.ShowFileOpenErrorMessage(noteFileName, noteKey)
            return
        }
        
        WindowService.FocusStoredWindow()
        
        if (WindowService.activeWindowTitle == WindowService.GetActiveWindowTitle()) {
            Send, ^v
            this.StopProcessing()
        } else {
            this.StopProcessing()
            WindowService.ShowActiveWindowTitleWarningMessage()
        }
    }
    
    ShowMsWordErrorMessage()
    {
        messageTitle := "MS Word missing"
        messageText := "Rich text format notes require MS Office Word (2007+). You can still use "".txt"" files to create plain notes.`n`nOpen help file for more info."
        MessageService.ShowMessage(messageText, MessageService.messageType.ERROR, messageTitle)
    }
    
    ShowFileOpenErrorMessage(noteFileName, noteKey)
    {
        messageTitle := "Invalid note file"
        messageText := "Can't open """ . noteFileName . """ file using """ . noteKey . """ hotstring.`nUse only allowed file types for your notes.`n`nValid file types:`n" . AhkService.ArrayJoin(this.plainFileTypes) . ", " . AhkService.ArrayJoin(this.richTextFileTypes) . "`n`nOpen help file for more info."
        MessageService.ShowMessage(messageText, MessageService.messageType.ERROR, messageTitle)
    }
    
    StartProcessing()
    {
        this._processingNote := true
        this._loadingState := true
        this.LoadingMessage()
        WindowService.StoreActiveWindowAndMonitor()
        ClipboardService.StoreClipboard()
        Clipboard :=
    }
    
    StopProcessing()
    {
        this._loadingState := false
        this.LoadingMessage()
        ClipboardService.RestoreClipboard()
        WindowService.ResetActiveWindowAndMonitor()
        this._processingNote := false
    }
    
    LoadingMessage()
    {
        if (!NotesHotstringService._loadingState) {
            MessageService.HideTooltip()
            return
        }
        
        SetTimer, showLoadintMessage, -250
        return
        
        showLoadintMessage:
            if (NotesHotstringService._loadingState) {
                MessageService.ShowTooltipOnCaret("Getting note...")
            }
        return
    }
    
    IsRichTextFileType(fileType)
    {
        return AhkService.HasValue(this.richTextFileTypes, fileType)
    }
    
    IsPlainFileType(fileType)
    {
        return AhkService.HasValue(this.plainFileTypes, fileType)
    }
}