unit FormAccountContacts;

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
  TfrmAccountContacts = class(TfrmBaseForm)
    dsDataID: TIBStringField;
    dsDataCONTACT_NAME: TIBStringField;
    dsDataJOB_TITLE: TIBStringField;
    dsDataJOB_NAME: TIBStringField;
    dsDataCOMM_TYPE1: TIBStringField;
    dsDataCOMM1: TIBStringField;
    dsDataCOMM_TYPE2: TIBStringField;
    dsDataCOMM2: TIBStringField;
    dsDataCOMM_TYPE3: TIBStringField;
    dsDataCOMM3: TIBStringField;
    dsDataCOMM_TYPE4: TIBStringField;
    dsDataCOMM4: TIBStringField;
    dsDataCOMM_TYPE5: TIBStringField;
    dsDataCOMM5: TIBStringField;
    dsDataCOMM_TYPE6: TIBStringField;
    dsDataCOMM6: TIBStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function CreateAccountContacts(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;

const
  SQL_GET_ACCOUNT_CONTACTS = 'SELECT * FROM ACCOUNT_CONTACT_SEL(:MASTER_ID) ';

var
  frmAccountContacts: TfrmAccountContacts;

implementation

uses
  PageAccounts, FormAccounts;

{$R *.dfm}

//---------------------------------------------------------------------------

function CreateAccountContacts(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;
begin
  frmAccountContacts := TfrmAccountContacts.ACreate(AOwner, AParent, IsMaster);
  frmAccountContacts.SQLText := SQL_GET_ACCOUNT_CONTACTS;
  frmAccountContacts.RebuildQuery;
  Result := frmAccountContacts;
end;

end.
