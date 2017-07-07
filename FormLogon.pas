unit FormLogon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.Client, Data.DB, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmLogon = class(TForm)
    edtUserName: TLabeledEdit;
    edtPassword: TLabeledEdit;
    connLogon: TFDConnection;
    trnLogon: TFDTransaction;
    pnlButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    spLogon: TFDStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FSuccess: Boolean;
  public
    { Public declarations }
    property Success: Boolean read FSuccess;
  end;

var
  frmLogon: TfrmLogon;

function Logon: Boolean;

implementation

uses
  UIThemes, Data, NsCipher, Kh_Utils;

{$R *.dfm}

//---------------------------------------------------------------------------

function Logon: Boolean;
begin
  Result := False;
  try
    frmLogon := TfrmLogon.Create(Application);
    frmLogon.pnlButtons.Color := KhalaTheme.PanelButtonsColor;
    frmLogon.Color := KhalaTheme.PanelFilterColor;
    frmLogon.ShowModal;
    Result := frmLogon.Success;
    frmLogon.Free;
  finally
    frmLogon := nil;
  end;
end;

{ TfrmLogon }
//---------------------------------------------------------------------------

procedure TfrmLogon.btnOKClick(Sender: TObject);
begin
  try
    try
      connLogon.Open;
      spLogon.Prepare;
      spLogon.ParamByName('LOGIN').AsString := edtUserName.Text;
      spLogon.ParamByName('PASS').AsString := edtPassword.Text;
//      spLogon.ParamByName('PASS').AsString := TXEBICipher.Crypt(edtPassword.Text, Smile);

      if not trnLogon.Active then
        trnLogon.StartTransaction;

      spLogon.ExecProc;
      FSuccess := spLogon.ParamByName('SUCCESS').AsBoolean;
      trnLogon.Commit;

      if FSuccess then
        Self.ModalResult := mrOk
      else
        ShowMessage('No.');
    except
      ShowMessage('server problem');

      if trnLogon.Active then
        trnLogon.Rollback;
    end;

  finally
    spLogon.Close;

    if trnLogon.Active then
      trnLogon.Commit;

    connLogon.Close;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmLogon.FormCreate(Sender: TObject);
begin
  FSuccess := False;
  connLogon.Params.Assign(dmData.FDConnection.Params);
  connLogon.Params.UserName := 'login';
  connLogon.Params.Password := '2';
end;

end.
