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
    //--
    procedure btnOkClick(Sender: TObject);
    procedure btnCheckConnectClick(Sender: TObject);
  private
    { Private declarations }
    FServerName: String;
    FDatabaseName: String;
    FUserName: String;
    FPassword: String;
    FServerType: String;
    //--
    procedure SetDatabaseName(const Value: String);
    procedure SetPassword(const Value: String);
    procedure SetServerName(const Value: String);
    procedure SetUserName(const Value: String);
    procedure SetServerType(const Value: String);
  public
    { Public declarations }
    procedure Clear;
    function Edit: Boolean;
    //--
    property ServerName: String read FServerName write SetServerName;
    property DatabaseName: String read FDatabaseName write SetDatabaseName;
    property UserName: String read FUserName write SetUserName;
    property Password: String read FPassword write SetPassword;
    property ServerType: String read FServerType write SetServerType;
  end;

implementation

uses
  Data;

{$R *.dfm}

{ TfrmDatabase }
//---------------------------------------------------------------------------

procedure TfrmDatabase.btnCheckConnectClick(Sender: TObject);
begin
  if dmData.Connect then
  begin
    dmData.SetParams(edtServerName.Text, edtDatabaseName.Text,
      edtUserName.Text, edtPassword.Text, '');                        // тута
    dmData.Disconnect;
    ShowMessage('Подключение выполнено успешно');
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.btnOkClick(Sender: TObject);
begin
  FServerName := edtServerName.Text;
  FDatabaseName := edtDatabaseName.Text;
  FUserName := edtUserName.Text;
  FPassword := edtPassword.Text;
  FServerType := '';                                                    // тута
end;

//---------------------------------------------------------------------------

procedure TfrmDatabase.Clear;
begin
  FServerName := '';
  FDatabaseName := '';
  FUserName := '';
  FPassword := '';
  FServerType := '';

  edtServerName.Clear;
  edtDatabaseName.Clear;
  edtUserName.Clear;
  edtPassword.Clear;                                                       // тута
end;

//---------------------------------------------------------------------------

function TfrmDatabase.Edit: Boolean;
begin
  Result := Self.ShowModal = mrOk;
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

procedure TfrmDatabase.SetServerType(const Value: String);
begin
  if FServerType <> Value then
    FServerType := Value;
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
