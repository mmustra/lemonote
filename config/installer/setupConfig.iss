#define AppName "Lemonote"
#define AppFileName "Lemonote.exe"
#define AppVersion "1.0.0"

[Setup]
AppName="{#AppName}"
AppVersion="{#AppVersion}"
WizardStyle=modern
DisableWelcomePage=no
DefaultDirName="{autopf}\{#AppName}"
DefaultGroupName="{#AppName}"
UninstallDisplayIcon="{app}\{#AppFileName}"
Compression=lzma2
SolidCompression=yes
OutputDir="..\..\dist\installer"
OutputBaseFilename="{#AppName}-{#AppVersion}-setup"
LicenseFile="..\..\dist\installer\app\LICENSE"

[Files]
Source: "..\..\resources\libs\psvince.dll"; Flags: dontcopy
Source: "..\..\resources\libs\psvince.dll"; DestDir: {app}
Source: "..\..\dist\installer\app\{#AppFileName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\dist\installer\app\icons.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\dist\installer\app\config.ini"; DestDir: "{userappdata}\{#AppName}"; Flags: ignoreversion
Source: "..\..\dist\installer\app\help.txt"; DestDir: "{app}"; Attribs: readonly; Flags: ignoreversion uninsremovereadonly overwritereadonly
Source: "..\..\dist\installer\app\LICENSE"; DestDir: "{app}"; Attribs: readonly; Flags: ignoreversion uninsremovereadonly overwritereadonly
Source: "..\..\dist\installer\app\Notes\*"; DestDir: "{userdocs}\{#AppName}\Notes"; Flags: ignoreversion recursesubdirs uninsneveruninstall onlyifdoesntexist

[Icons]
Name: "{autoprograms}\{#AppName}"; Filename: "{app}\{#AppFileName}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppFileName}"
Name: "{userstartup}\{#AppName}"; Filename: "{app}\{#AppFileName}"
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppFileName}"; WorkingDir: "{app}"
Name: "{group}\Notes"; Filename: "{userdocs}\{#AppName}\Notes"; WorkingDir: "{app}"; Flags: foldershortcut
Name: "{group}\Help"; Filename: "{app}\help.txt"; WorkingDir: "{app}"
Name: "{group}\Uninstall"; Filename: "{uninstallexe}"

[INI]
Filename: "{userappdata}\{#AppName}\config.ini"; Section: GDS; Key: system; String:{code:GetGDSSystem}

[Run]
Filename: "{app}\help.txt"; Description: Open Help; Flags: postinstall shellexec skipifsilent
Filename: "{app}\{#AppFileName}"; Description: Run Lemonote; Flags: postinstall nowait skipifsilent

[Messages]
WelcomeLabel2=This will install {#AppName} v{#AppVersion} on your system.%n%nYou'll be able to copy/paste notes in any application and generate GDS commands through user friendly dialogs.

[InstallDelete]
Type: filesandordirs; Name: "{app}\*"
Type: filesandordirs; Name: "{group}\*"

[Code]
function IsModuleLoaded(modulename: AnsiString): Boolean;
external 'IsModuleLoaded2@files:psvince.dll stdcall setuponly';
function IsModuleLoadedU(modulename: AnsiString):  Boolean;
external 'IsModuleLoaded2@{app}\psvince.dll stdcall uninstallonly' ;

function InitializeSetup(): Boolean;
label CheckForProcess;
begin
  CheckForProcess:
  if IsModuleLoaded('{#AppFileName}') then
  begin
    if MsgBox('Before reinstalling {#AppName} close the running instance.' + #13 + #10 + 'Right click on tray icon (lemon) in taskbar and click "Exit".' + #13 + #13 + 'After that click "Retry" button to continue with installation.', mbError, MB_RETRYCANCEL) = IDRETRY then
    begin
      goto CheckForProcess;
    end
    else Result := false;
  end
  else Result := true;
end;

function InitializeUninstall(): Boolean;
label CheckForProcess;
begin
  CheckForProcess:
  if IsModuleLoadedU('{#AppFileName}') then
  begin
    if MsgBox('Before uninstalling {#AppName} close the running instance.' + #13 + #10 + 'Right click on tray icon (lemon) in taskbar and click "Exit".' + #13 + #13 + 'After that click "Retry" button to continue with uninstallation.', mbError, MB_RETRYCANCEL) = IDRETRY then
    begin
      goto CheckForProcess;
    end
    else Result := false;
  end
  else Result := true;

  UnloadDLL(ExpandConstant('{app}\psvince.dll'));
end;
    
var GdsPage: TInputOptionWizardPage;

procedure AddGdsPage();
begin
  GdsPage := CreateInputOptionPage(
    wpLicense,
    'GDS System', 'Lemonote support multiple GDS systems, which one do you use?',
    'Please choose your GDS system (this can be changed later), then click Next.',
    True, False);

  GdsPage.Add('Amadeus (beta)');
  GdsPage.Add('Sabre');
  GdsPage.SelectedValueIndex := 1;
end;

procedure InitializeWizard();
begin
  AddGdsPage();
end;

function GetGDSSystem(Param: String): string;
begin
  case GdsPage.SelectedValueIndex of
    0: Result := 'Amadeus';
    1: Result := 'Sabre';
  end;
end;