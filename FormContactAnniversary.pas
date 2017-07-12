unit FormContactAnniversary;

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
  TfrmContactAnniversary = class(TfrmBaseForm)
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_CONTACT_ANNIVERSARY = 'select * from dbo.App_SelectContactAnniversary ';
  FORM_ID = '{B6F5F259-D843-463A-8799-1CE3AFC8FEA2}';

var
  frmContactAnniversary: TfrmContactAnniversary;

implementation

{$R *.dfm}

{ TfrmContactAnniversary }

class function TfrmContactAnniversary.CreateForm(AOwner: TComponent;
  AParent: TWinControl; IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmContactAnniversary.ACreate(AOwner, AParent, IsMaster);
  Result.FormID_AsString := FORM_ID;
  Result.SQLText := SQL_GET_CONTACT_ANNIVERSARY;
  Result.RebuildQuery;
end;

end.
