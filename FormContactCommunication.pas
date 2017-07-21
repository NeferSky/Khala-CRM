unit FormContactCommunication;

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
  TfrmContactCommunication = class(TfrmBaseForm)
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_CONTACT_COMMUNICATIONS = 'select * from dbo.App_SelectContactCommunications ';
  // 44B4DD95-F28F-4E2D-AB06-86BDF242844B
  FORM_ID: TGuid =
    (D1: $44B4DD95; D2: $F28F; D3: $4E2D; D4: ($AB, $06, $86, $BD, $F2, $42, $84, $4B));

var
  frmContactCommunication: TfrmContactCommunication;

implementation

{$R *.dfm}

{ TfrmContactCommunication }

class function TfrmContactCommunication.CreateForm(AOwner: TComponent;
  AParent: TWinControl; IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmContactCommunication.ACreate(AOwner, AParent, IsMaster);
  Result.FormID := FORM_ID;
  Result.SQLText := SQL_GET_CONTACT_COMMUNICATIONS;
  Result.RebuildQuery;
end;

end.
