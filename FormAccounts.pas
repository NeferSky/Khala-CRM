unit FormAccounts;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Data.DB,
  IBX.IBCustomDataSet, IBX.IBSQL,
  frxClass, frxDBSet, frxExportXLS,
  BaseForm, NsDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.Actions, Vcl.ActnList;

type
  TfrmAccounts = class(TfrmBaseForm)
    fdDataID: TStringField;
    fdDataAccountName: TStringField;
    fdDataAccountTypeName: TStringField;
    fdDataContactName: TStringField;
    fdDataOwnerName: TStringField;
    fdDataCreatorName: TStringField;
    fdDataCreatedDate: TSQLTimeStampField;
    fdDataModifierName: TStringField;
    fdDataModifiedDate: TSQLTimeStampField;
    fdDataOfficialAccountName: TStringField;
    fdDataCityName: TStringField;
    fdDataPostAutonom: TStringField;
    fdDataAccountINN: TStringField;
    fdDataAccountKPP: TStringField;
    fdDataAccountCategoryName: TStringField;
    fdDataRegionName: TStringField;
    fdDataAccountPostAddress: TStringField;
    fdDataAccountLegalAddress: TStringField;
    fdDataAccountCallNote: TStringField;
    fdDataTimeDifference: TIntegerField;
    fdDataClientsValue: TStringField;
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
  private
    { Private declarations }
    procedure DisableAccount(AccountID: TGuid);
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_ACCOUNTS = 'select * from dbo.App_SelectAccounts() ';
  FORM_ID = '{1B530A50-18F7-4322-9D38-1C5D7CF4AB42}';

implementation

uses
  FormAccountEdit;

{$R *.dfm}

{ TfrmAccounts }
//---------------------------------------------------------------------------

procedure TfrmAccounts.actDeleteExecute(Sender: TObject);
begin
  inherited;

  if MessageDlg('Удалить контрагента?', mtConfirmation, mbOKCancel, 0) = mrOk then
    DisableAccount(StringToGuid(fdData.FieldByName('ID').AsString));
end;

//---------------------------------------------------------------------------

procedure TfrmAccounts.actEditExecute(Sender: TObject);
begin
  inherited;
  TfrmAccountEdit.CreateEditForm(Self, StringToGuid(fdData.FieldByName('ID').AsString));
end;

//---------------------------------------------------------------------------

class function TfrmAccounts.CreateForm(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmAccounts.ACreate(AOwner, AParent, IsMaster);
  Result.FormID_AsString := FORM_ID;
  Result.SQLText := SQL_GET_ACCOUNTS;
  Result.RebuildQuery;
end;

//---------------------------------------------------------------------------

procedure TfrmAccounts.DisableAccount(AccountID: TGuid);
begin
  spUserActions.StoredProcName := 'dbo.App_DisableAccount';
  spUserActions.ParamByName('AccountID').AsGUID  := AccountID;
end;

end.

