unit Edit;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmDatabase = class(TForm)
    edtServerName: TEdit;
    edtDatabaseName: TEdit;
    edtUserName: TEdit;
    edtPassword: TEdit;
    btnCheckConnect: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    lblServerName: TLabel;
    lblDatabaseName: TLabel;
    lblUserName: TLabel;
    lblPassword: TLabel;
    cmbDriverID: TComboBox;
    lblDriverID: TLabel;
    //--
    procedure btnOkClick(Sender: TObject);
    procedure btnCheckConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FServerName: String;
    FDatabaseName: String;
    FUserName: String;
    FPassword: String;
    FDriverID: String;
    //--
    procedure SetDatabaseName(const Value: String);
    procedure SetPassword(const Value: String);
    procedure SetServerName(const Value: String);
    procedure SetUserName(const Value: String);
    procedure SetDriverID(const Value: String);
  public
    { Public declarations }
    procedure Clear;
    function Edit: Boolean;
    //--
    property ServerName: String read FServerName write SetServerName;
    property DatabaseName: String read FDatabaseName write SetDatabaseName;
    property UserName: String read FUserName write SetUserName;
    property Password: String read FPassword write SetPassword;
    property DriverID: String read FDriverID write SetDriverID;
  end;

implementation

uses
  Data, fd_Const;

{$R *.dfm}

{ TfrmDatabase }
//---------------------------------------------------------------------------

procedure TfrmDatabase.btnCheckConnectClick(Sender: TObject);
// Test for connection to database
begin
  dmData.SetParams(edtServerName.Text, edtDatabaseName.Text, edtUserName.Text,
    edtPassword.Text, cmbDriverID.Text);

  if dmData.Connect then
  begin
    dmData.Disconnect;
    ShowMessage('Подключение выполнено успешно');
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.btnOkClick(Sender: TObject);
// Set local values to properties
begin
  FServerName := edtServerName.Text;
  FDatabaseName := edtDatabaseName.Text;
  FUserName := edtUserName.Text;
  FPassword := edtPassword.Text;
  FDriverID := cmbDriverID.Text;
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.Clear;
// Clear ;-)
begin
  FServerName := '';
  FDatabaseName := '';
  FUserName := '';
  FPassword := '';
  FDriverID := '';

  edtServerName.Clear;
  edtDatabaseName.Clear;
  edtUserName.Clear;
  edtPassword.Clear;
  cmbDriverID.ItemIndex := -1;
end;

//---------------------------------------------------------------------------

function TfrmDatabase.Edit: Boolean;
// Show form and returns result - mrOk if updates needs to apply
begin
  Result := Self.ShowModal = mrOk;
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.FormCreate(Sender: TObject);
// Fill combobox
begin
  cmbDriverID.Items.Assign(DriverList);
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.SetDatabaseName(const Value: String);
begin
  if FDatabaseName <> Value then
  begin
    FDatabaseName := Value;
    edtDatabaseName.Text := Value;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.SetPassword(const Value: String);
begin
  if FPassword <> Value then
  begin
    FPassword := Value;
    edtPassword.Text := Value;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.SetServerName(const Value: String);
begin
  if FServerName <> Value then
  begin
    FServerName := Value;
    edtServerName.Text := Value;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.SetDriverID(const Value: String);
begin
  if FDriverID <> Value then
  begin
    FDriverID := Value;
    cmbDriverID.ItemIndex := cmbDriverID.Items.IndexOf(Value);
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.SetUserName(const Value: String);
begin
  if FUserName <> Value then
  begin
    FUserName := Value;
    edtUserName.Text := Value;
  end;
end;

end.
