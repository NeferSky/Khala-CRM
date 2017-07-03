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
  BaseForm, NsDBGrid;

type
  TfrmAccounts = class(TfrmBaseForm)
    dsDataID: TIBStringField;
    dsDataACCOUNT_NAME: TIBStringField;
    dsDataACCOUNT_TYPE_NAME: TIBStringField;
    dsDataCONTACT_NAME: TIBStringField;
    dsDataOWNER_NAME: TIBStringField;
    dsDataCREATOR_NAME: TIBStringField;
    dsDataCREATED_DATE: TDateTimeField;
    dsDataMODIFIER_NAME: TIBStringField;
    dsDataMODIFIED_DATE: TDateTimeField;
    dsDataOFFICIAL_ACCOUNT_NAME: TIBStringField;
    dsDataCITY_NAME: TIBStringField;
    dsDataPOST_AUTONOM: TIBStringField;
    dsDataACCOUNT_INN: TIBStringField;
    dsDataACCOUNT_KPP: TIBStringField;
    dsDataACCOUNT_CATEGORY_NAME: TIBStringField;
    dsDataREGION_NAME: TIBStringField;
    dsDataACCOUNT_POST_ADDRESS: TIBStringField;
    dsDataACCOUNT_LEGAL_ADDRESS: TIBStringField;
    dsDataACCOUNT_NOTE: TIBStringField;
    dsDataACCOUNT_CALL_NOTE: TIBStringField;
    dsDataCLIENTS_VALUE_ID: TIBStringField;
    dsDataTIME_DIFFERENCE: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function CreateAccounts(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;

const
  SQL_GET_ACCOUNTS = 'SELECT * FROM ACCOUNT_SEL ';

var
  frmAccounts: TfrmAccounts;

implementation

uses
  PageAccounts;

{$R *.dfm}

//---------------------------------------------------------------------------

function CreateAccounts(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;
begin
  frmAccounts := TfrmAccounts.ACreate(AOwner, AParent, IsMaster);
  frmAccounts.SQLText := SQL_GET_ACCOUNTS;
  frmAccounts.RebuildQuery;
  Result := frmAccounts;
end;

end.

