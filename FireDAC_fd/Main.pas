unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Menus, System.Actions, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, Edit, frxClass, System.UITypes;

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
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    frReport: TfrxReport;
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
  private
    { Private declarations }
    FDatabaseEdit: TfrmDatabase;
    //--
    procedure ReadDatabases;
    procedure UpdateControls;
    function GetNewRegKey: String;
    // ListView operations
    procedure AddDatabase(ServerName, DatabaseName, UserName, Password,
      ServerType, RegKey: String);
    procedure EditDatabase(ItemIndex: Integer);
    procedure DeleteDatabase(ItemIndex: Integer);
    // Registry operations
    procedure WriteDatabase(ServerName, DatabaseName, UserName, Password,
      ServerType, RegKey: String);
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
      FDatabaseEdit.UserName, FDatabaseEdit.Password, FDatabaseEdit.ServerType,
      NewKey);
    WriteDatabase(FDatabaseEdit.ServerName, FDatabaseEdit.DatabaseName,
      FDatabaseEdit.UserName, FDatabaseEdit.Password, FDatabaseEdit.ServerType,
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
  FDatabaseEdit.ServerType := lvDatabases.Selected.SubItems[3];

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

procedure TfrmMain.AddDatabase(ServerName, DatabaseName, UserName,
  Password, ServerType, RegKey: String);
var
  ListItem: TListItem;

begin
  ListItem := lvDatabases.Items.Add;
  ListItem.Caption := ServerName;
  ListItem.SubItems.Add(DatabaseName);
  ListItem.SubItems.Add(UserName);
  ListItem.SubItems.Add(Password);
  ListItem.SubItems.Add(ServerType);
  ListItem.SubItems.Add(RegKey);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.DeleteDatabase(ItemIndex: Integer);
begin
  lvDatabases.Items[ItemIndex].Delete;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.EditDatabase(ItemIndex: Integer);
begin
  lvDatabases.Items[ItemIndex].Caption := FDatabaseEdit.ServerName;
  lvDatabases.Items[ItemIndex].SubItems[0] := FDatabaseEdit.DatabaseName;
  lvDatabases.Items[ItemIndex].SubItems[1] := FDatabaseEdit.UserName;
  lvDatabases.Items[ItemIndex].SubItems[2] := FDatabaseEdit.Password;
  lvDatabases.Items[ItemIndex].SubItems[3] := FDatabaseEdit.ServerType;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.EraseDatabase(ItemIndex: Integer);
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    if KeyExists(REG_FREE_DESIGNER_DATABASES + '\' + lvDatabases.Items[ItemIndex].SubItems[4]) then
      DeleteKey(REG_FREE_DESIGNER_DATABASES + '\' + lvDatabases.Items[ItemIndex].SubItems[4]);
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
  for I := 0 to KeysList.Count - 1 do
  begin
    if UpperCase(KeysList[I]) <> 'DATABASE' + IntToStr(I+1) then
      Result := 'Database' + IntToStr(I+1);
  end;
  R.CloseKey;
  R.Free;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.lvDatabasesClick(Sender: TObject);
begin
  UpdateControls;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.lvDatabasesDblClick(Sender: TObject);
begin
  if lvDatabases.SelCount > 0 then
    actDesign.Execute;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.ReadDatabases;
var
  DatabasesList: TStringList;
  R: TRegistry;
  I: Integer;
  ServerName, DatabaseName, UserName, Password, ServerType: String;

begin
  DatabasesList := TStringList.Create;

  R := TRegistry.Create;
  R.RootKey := HKEY_CURRENT_USER;
  R.OpenKeyReadOnly(REG_FREE_DESIGNER_DATABASES);
  if R.KeyExists(REG_FREE_DESIGNER_DATABASES) then
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

    if R.ValueExists('ServerType') then
      Password := R.ReadString('ServerType')
    else
      Continue;

    AddDatabase(ServerName, DatabaseName, UserName, Password, ServerType,
      REG_FREE_DESIGNER_DATABASES + '\' + DatabasesList[I]);
  end;

  R.CloseKey;
  R.Free;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.ReWriteDatabase(ItemIndex: Integer);
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    OpenKey(REG_FREE_DESIGNER_DATABASES + '\' + lvDatabases.Items[ItemIndex].SubItems[4], True);
    WriteString('ServerName', FDatabaseEdit.ServerName);
    WriteString('DatabaseName', FDatabaseEdit.DatabaseName);
    WriteString('UserName', FDatabaseEdit.UserName);
    WriteString('Password', FDatabaseEdit.Password);
    WriteString('ServerType', FDatabaseEdit.ServerType);
    CloseKey;
    Free;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.UpdateControls;
var
  Active: Boolean;

begin
  Active := lvDatabases.SelCount > 0;

  actEdit.Enabled := Active;
  actDelete.Enabled := Active;
  actDesign.Enabled := Active;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.WriteDatabase(ServerName, DatabaseName, UserName,
  Password, ServerType, RegKey: String);
var
  R: TRegistry;

begin
  R := TRegistry.Create;
  R.RootKey := HKEY_CURRENT_USER;
  R.OpenKey(REG_FREE_DESIGNER_DATABASES + '\' + RegKey, True);
  R.WriteString('ServerName', ServerName);
  R.WriteString('DatabaseName', DatabaseName);
  R.WriteString('UserName', UserName);
  R.WriteString('Password', Password);
  R.WriteString('ServerType', ServerType);
  R.CloseKey;
  R.Free;
end;

end.
