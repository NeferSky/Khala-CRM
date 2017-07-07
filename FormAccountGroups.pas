unit FormAccountGroups;

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
  TfrmAccountGroups = class(TfrmBaseForm)
    fdDataID: TStringField;
    fdDataGROUP_NAME: TStringField;
    fdDataDESCRIPTION: TStringField;
    fdDataBIND_DATE: TSQLTimeStampField;
    fdDataBINDER: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_ACCOUNT_GROUPS = 'SELECT * FROM ACCOUNT_GROUPS_SEL(:MASTER_ID) ';

implementation

{$R *.dfm}

{ TfrmAccountGroups }

class function TfrmAccountGroups.CreateForm(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmAccountGroups.ACreate(AOwner, AParent, IsMaster);
  Result.SQLText := SQL_GET_ACCOUNT_GROUPS;
  Result.RebuildQuery;
end;

end.
