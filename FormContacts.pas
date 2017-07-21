unit FormContacts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseForm, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  System.Actions, Vcl.ActnList, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  Vcl.Menus, frxClass, frxExportXLS, frxDBSet, Vcl.Grids, Vcl.DBGrids, NsDBGrid,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, frxExportBIFF;

type
  TfrmContacts = class(TfrmBaseForm)
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_CONTACTS = 'select * from dbo.App_SelectContacts ';
  // 036E1011-A524-4C2A-B08F-AF4291257A0C
  FORM_ID: TGuid =
    (D1: $036E1011; D2: $A524; D3: $4C2A; D4: ($B0, $8F, $AF, $42, $91, $25, $7A, $0C));

var
  frmContacts: TfrmContacts;

implementation

{$R *.dfm}

{ TfrmContacts }

class function TfrmContacts.CreateForm(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmContacts.ACreate(AOwner, AParent, IsMaster);
  Result.FormID := FORM_ID;
  Result.SQLText := SQL_GET_CONTACTS;
  Result.RebuildQuery;
end;

end.
