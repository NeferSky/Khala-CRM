unit FormAccountContacts;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Data.DB,
  frxClass, frxDBSet, frxExportXLS,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  BaseForm, NsDBGrid, System.Actions, Vcl.ActnList;

type
  TfrmAccountContacts = class(TfrmBaseForm)
    fdDataID: TStringField;
    fdDataCONTACT_NAME: TStringField;
    fdDataJOB_TITLE: TStringField;
    fdDataJOB_NAME: TStringField;
    fdDataCOMM_TYPE1: TStringField;
    fdDataCOMM1: TStringField;
    fdDataCOMM_TYPE2: TStringField;
    fdDataCOMM2: TStringField;
    fdDataCOMM_TYPE3: TStringField;
    fdDataCOMM3: TStringField;
    fdDataCOMM_TYPE4: TStringField;
    fdDataCOMM4: TStringField;
    fdDataCOMM_TYPE5: TStringField;
    fdDataCOMM5: TStringField;
    fdDataCOMM_TYPE6: TStringField;
    fdDataCOMM6: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_ACCOUNT_CONTACTS = 'SELECT * FROM ACCOUNT_CONTACT_SEL(:MASTER_ID) ';

implementation

{$R *.dfm}

{ TfrmAccountContacts }

class function TfrmAccountContacts.CreateForm(AOwner: TComponent;
  AParent: TWinControl; IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmAccountContacts.ACreate(AOwner, AParent, IsMaster);
  Result.SQLText := SQL_GET_ACCOUNT_CONTACTS;
  Result.RebuildQuery;
end;

end.
