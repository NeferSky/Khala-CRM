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
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls;

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
  SQL_GET_CONTACT_TASKS = 'SELECT * FROM dbo.CONTACT_TASKS_SEL ';

var
  frmContactTasks: TfrmContactTasks;

implementation

{$R *.dfm}
{ TfrmContactTasks }

class function TfrmContactTasks.CreateForm(AOwner: TComponent;
  AParent: TWinControl; IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmContactTasks.ACreate(AOwner, AParent, IsMaster);
  Result.SQLText := SQL_GET_CONTACT_TASKS;
  Result.RebuildQuery;
end;

end.