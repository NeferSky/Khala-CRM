unit FormContactTasks;

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
  TfrmContactTasks = class(TfrmBaseForm)
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_CONTACT_TASKS = 'select * from dbo.App_SelectContactTasks ';
  // 0078FCD5-5975-4FC7-B6F1-C7151D3DF295
  FORM_ID: TGuid =
    (D1: $0078FCD5; D2: $5975; D3: $4FC7; D4: ($B6, $F1, $C7, $15, $1D, $3D, $F2, $95));

var
  frmContactTasks: TfrmContactTasks;

implementation

{$R *.dfm}

{ TfrmContactTasks }

class function TfrmContactTasks.CreateForm(AOwner: TComponent;
  AParent: TWinControl; IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmContactTasks.ACreate(AOwner, AParent, IsMaster);
  Result.FormID := FORM_ID;
  Result.SQLText := SQL_GET_CONTACT_TASKS;
  Result.RebuildQuery;
end;

end.
