unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Menus, System.Actions, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, Edit, frxClass, System.UITypes, Vcl.StdCtrls, frxDesgn, frxDBSet,
  frxFDComponents;

type
  TfrmMain = class(TForm)
    mmnuMain: TMainMenu;
    mnuDatabase: TMenuItem;
    mnuReport: TMenuItem;
    sbStatus: TStatusBar;
    tbButtons: TToolBar;
    btnAdd: TToolButton;
    btnEdit: TToolButton;
    btnDelete: TToolButton;
    sprSeparator: TToolButton;
    btnDesign: TToolButton;
    lvDatabases: TListView;
    ilImages: TImageList;
    alActions: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actDesign: TAction;
    actExit: TAction;
    mnuAdd: TMenuItem;
    mnuEdit: TMenuItem;
    mnuDelete: TMenuItem;
    mnuSeparator: TMenuItem;
    mnuExit: TMenuItem;
    mnuDesign: TMenuItem;
    frReport: TfrxReport;
    frFireDACSupport: TfrxFDComponents;
    frDesigner: TfrxDesigner;
    //--
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDesignExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure lvDatabasesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvDatabasesDblClick(Sender: TObject);
    procedure lvDatabasesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvDatabasesDeletion(Sender: TObject; Item: TListItem);
    procedure lvDatabasesEdited(Sender: TObject; Item: TListItem;
      var S: string);
  private
    { Private declarations }
    FDatabaseEdit: TfrmDatabase;
    //--
    procedure ReadDatabases;
    procedure UpdateControls;
    function GetNewRegKey: String;
    // ListView operations
    procedure AddDatabase(AServerName, ADatabaseName, AUserName, APassword,
      ADriverID, ARegKey: String);
    procedure EditDatabase(ItemIndex: Integer);
    procedure DeleteDatabase(ItemIndex: Integer);
    // Registry operations
    procedure WriteDatabase(AServerName, ADatabaseName, AUserName, APassword,
      ADriverID, ARegKey: String);
    procedure ReWriteDatabase(ItemIndex: Integer);
    procedure EraseDatabase(ItemIndex: Integer);
  public
    { Public declarations }
  end;

const
  REG_FREE_DESIGNER_DATABASES = 'Software\NeferSky\FreeDesigner';

var
  frmMain: TfrmMain;

implementation

uses
  Data, Registry;

{$R *.dfm}

{ TfrmMain }
//---------------------------------------------------------------------------

procedure TfrmMain.actAddExecute(Sender: TObject);
var
  NewKey: String;

begin
  FDatabaseEdit.Clear;

  if FDatabaseEdit.Edit then
  begin
    NewKey := GetNewRegKey;
    AddDatabase(FDatabaseEdit.ServerName, FDatabaseEdit.DatabaseName,
      FDatabaseEdit.UserName, FDatabaseEdit.Password, FDatabaseEdit.DriverID,
      NewKey);
    WriteDatabase(FDatabaseEdit.ServerName, FDatabaseEdit.DatabaseName,
      FDatabaseEdit.UserName, FDatabaseEdit.Password, FDatabaseEdit.DriverID,
      NewKey);
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.actDeleteExecute(Sender: TObject);
var
  Prompt: String;

begin
  Prompt := Format('Удалить базу данных %s:%s?',
    [lvDatabases.Selected.Caption, lvDatabases.Selected.Subitems[0]]);

  if MessageDlg(Prompt, mtConfirmation, mbOKCancel, 0) = mrOk then
  begin
    EraseDatabase(lvDatabases.Selected.Index);
    DeleteDatabase(lvDatabases.Selected.Index);
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.actDesignExecute(Sender: TObject);
begin
  dmData.SetParams(lvDatabases.Selected.Caption,
    lvDatabases.Selected.SubItems[0], lvDatabases.Selected.SubItems[1],
    lvDatabases.Selected.SubItems[2], lvDatabases.Selected.SubItems[3]);
  dmData.Connect;
  frReport.DesignReport;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.actEditExecute(Sender: TObject);
begin
  FDatabaseEdit.ServerName := lvDatabases.Selected.Caption;
  FDatabaseEdit.DatabaseName := lvDatabases.Selected.SubItems[0];
  FDatabaseEdit.UserName := lvDatabases.Selected.SubItems[1];
  FDatabaseEdit.Password := lvDatabases.Selected.SubItems[2];
  FDatabaseEdit.DriverID := lvDatabases.Selected.SubItems[3];

  if FDatabaseEdit.Edit then
  begin
    ReWriteDatabase(lvDatabases.Selected.Index);
    EditDatabase(lvDatabases.Selected.Index);
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.AddDatabase(AServerName, ADatabaseName, AUserName,
  APassword, ADriverID, ARegKey: String);
// Add database into ListView
var
  ListItem: TListItem;

begin
  ListItem := lvDatabases.Items.Add;
  ListItem.Caption := AServerName;
  ListItem.SubItems.Add(ADatabaseName);
  ListItem.SubItems.Add(AUserName);
  ListItem.SubItems.Add(APassword);
  ListItem.SubItems.Add(ADriverID);
  ListItem.SubItems.Add(ARegKey);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.DeleteDatabase(ItemIndex: Integer);
// Remove database from ListView
begin
  lvDatabases.Items[ItemIndex].Delete;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.EditDatabase(ItemIndex: Integer);
// Update database in ListView by values from EditForm properties
begin
  lvDatabases.Items[ItemIndex].Caption := FDatabaseEdit.ServerName;
  lvDatabases.Items[ItemIndex].SubItems[0] := FDatabaseEdit.DatabaseName;
  lvDatabases.Items[ItemIndex].SubItems[1] := FDatabaseEdit.UserName;
  lvDatabases.Items[ItemIndex].SubItems[2] := FDatabaseEdit.Password;
  lvDatabases.Items[ItemIndex].SubItems[3] := FDatabaseEdit.DriverID;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.EraseDatabase(ItemIndex: Integer);
// Remove database from Registry
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    if KeyExists(lvDatabases.Items[ItemIndex].SubItems[4]) then
      DeleteKey(lvDatabases.Items[ItemIndex].SubItems[4]);
    Free;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FDatabaseEdit := TfrmDatabase.Create(Self);
  ReadDatabases;
  UpdateControls;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDatabaseEdit);
end;

//---------------------------------------------------------------------------

function TfrmMain.GetNewRegKey: String;
// Find and return new registry key name for new database
var
  R: TRegistry;
  KeysList: TStringList;
  I: Integer;

begin
  R := TRegistry.Create;
  R.RootKey := HKEY_CURRENT_USER;
  KeysList := TStringList.Create;
  R.OpenKeyReadOnly(REG_FREE_DESIGNER_DATABASES);
  R.GetKeyNames(KeysList);
  KeysList.Sort;

  for I := 0 to KeysList.Count do
  begin
    if KeysList.IndexOf('Database' + IntToStr(I+1)) = -1 then
      Result := REG_FREE_DESIGNER_DATABASES + '\Database' + IntToStr(I+1);
  end;

  R.CloseKey;
  R.Free;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.lvDatabasesChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  UpdateControls;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.lvDatabasesClick(Sender: TObject);
begin
  UpdateControls;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.lvDatabasesDblClick(Sender: TObject);
// Do design
begin
  if lvDatabases.SelCount > 0 then
    actDesign.Execute;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.lvDatabasesDeletion(Sender: TObject; Item: TListItem);
begin
  UpdateControls;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.lvDatabasesEdited(Sender: TObject; Item: TListItem;
  var S: string);
begin
  UpdateControls;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.ReadDatabases;
// Read databases list from registry. If at least one database property is not
// exists - database is skiped as invalid.
var
  DatabasesList: TStringList;
  R: TRegistry;
  I: Integer;
  ServerName, DatabaseName, UserName, Password, DriverID: String;

begin
  DatabasesList := TStringList.Create;

  R := TRegistry.Create;
  R.RootKey := HKEY_CURRENT_USER;
  R.OpenKeyReadOnly(REG_FREE_DESIGNER_DATABASES);
  R.GetKeyNames(DatabasesList);

  for I := 0 to DatabasesList.Count - 1 do
  begin
    R.CloseKey;
    R.OpenKeyReadOnly(REG_FREE_DESIGNER_DATABASES + '\' + DatabasesList[I]);

    if R.ValueExists('ServerName') then
      ServerName := R.ReadString('ServerName')
    else
      Continue;

    if R.ValueExists('DatabaseName') then
      DatabaseName := R.ReadString('DatabaseName')
    else
      Continue;

    if R.ValueExists('UserName') then
      UserName := R.ReadString('UserName')
    else
      Continue;

    if R.ValueExists('Password') then
      Password := R.ReadString('Password')
    else
      Continue;

    if R.ValueExists('DriverID') then
      DriverID := R.ReadString('DriverID')
    else
      Continue;

    AddDatabase(ServerName, DatabaseName, UserName, Password, DriverID,
      REG_FREE_DESIGNER_DATABASES + '\' + DatabasesList[I]);
  end;

  R.CloseKey;
  R.Free;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.ReWriteDatabase(ItemIndex: Integer);
// Update database in registry
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    OpenKey(lvDatabases.Items[ItemIndex].SubItems[4], True);
    WriteString('ServerName', FDatabaseEdit.ServerName);
    WriteString('DatabaseName', FDatabaseEdit.DatabaseName);
    WriteString('UserName', FDatabaseEdit.UserName);
    WriteString('Password', FDatabaseEdit.Password);
    WriteString('DriverID', FDatabaseEdit.DriverID);
    CloseKey;
    Free;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.UpdateControls;
// Switch on/off available actions
var
  Active: Boolean;

begin
  Active := lvDatabases.SelCount > 0;

  actEdit.Enabled := Active;
  actDelete.Enabled := Active;
  actDesign.Enabled := Active;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.WriteDatabase(AServerName, ADatabaseName, AUserName,
  APassword, ADriverID, ARegKey: String);
// Write new database into registry
var
  R: TRegistry;

begin
  R := TRegistry.Create;
  R.RootKey := HKEY_CURRENT_USER;
  R.OpenKey(ARegKey, True);
  R.WriteString('ServerName', AServerName);
  R.WriteString('DatabaseName', ADatabaseName);
  R.WriteString('UserName', AUserName);
  R.WriteString('Password', APassword);
  R.WriteString('DriverID', ADriverID);
  R.CloseKey;
  R.Free;
end;

end.
