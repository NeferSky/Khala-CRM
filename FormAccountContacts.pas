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
    fdDataContactName: TStringField;
    fdDataJobName: TStringField;
    fdDataCommType1: TStringField;
    fdDataComm1: TStringField;
    fdDataCommType2: TStringField;
    fdDataComm2: TStringField;
    fdDataCommType3: TStringField;
    fdDataComm3: TStringField;
    fdDataCommType4: TStringField;
    fdDataComm4: TStringField;
    fdDataCommType5: TStringField;
    fdDataComm5: TStringField;
    fdDataCommType6: TStringField;
    fdDataComm6: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_ACCOUNT_CONTACTS = 'select * from dbo.App_SelectAccountContact(:MasterID) ';
  FORM_ID = '{7A07B6B5-5763-4003-AA78-BF2EF691AD95}';

implementation

{$R *.dfm}

{ TfrmAccountContacts }

class function TfrmAccountContacts.CreateForm(AOwner: TComponent;
  AParent: TWinControl; IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmAccountContacts.ACreate(AOwner, AParent, IsMaster);
  Result.FormID_AsString := FORM_ID;
  Result.SQLText := SQL_GET_ACCOUNT_CONTACTS;
  Result.RebuildQuery;
end;

end.
