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
  FireDAC.Comp.DataSet;

type
  TfrmAccounts = class(TfrmBaseForm)
    fdDataID: TStringField;
    fdDataACCOUNT_NAME: TStringField;
    fdDataACCOUNT_TYPE_NAME: TStringField;
    fdDataCONTACT_NAME: TStringField;
    fdDataOWNER_NAME: TStringField;
    fdDataCREATOR_NAME: TStringField;
    fdDataCREATED_DATE: TSQLTimeStampField;
    fdDataMODIFIER_NAME: TStringField;
    fdDataMODIFIED_DATE: TSQLTimeStampField;
    fdDataOFFICIAL_ACCOUNT_NAME: TStringField;
    fdDataCITY_NAME: TStringField;
    fdDataPOST_AUTONOM: TStringField;
    fdDataACCOUNT_INN: TStringField;
    fdDataACCOUNT_KPP: TStringField;
    fdDataACCOUNT_CATEGORY_NAME: TStringField;
    fdDataREGION_NAME: TStringField;
    fdDataACCOUNT_POST_ADDRESS: TStringField;
    fdDataACCOUNT_LEGAL_ADDRESS: TStringField;
    fdDataACCOUNT_NOTE: TStringField;
    fdDataACCOUNT_CALL_NOTE: TStringField;
    fdDataCLIENTS_VALUE_ID: TStringField;
    fdDataTIME_DIFFERENCE: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_ACCOUNTS = 'SELECT * FROM ACCOUNT_SEL ';

implementation

{$R *.dfm}

{ TfrmAccounts }

class function TfrmAccounts.CreateForm(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmAccounts.ACreate(AOwner, AParent, IsMaster);
  Result.SQLText := SQL_GET_ACCOUNTS;
  Result.RebuildQuery;
end;

end.

