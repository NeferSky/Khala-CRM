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
  BaseForm, NsDBGrid, System.Actions, Vcl.ActnList, frxExportBIFF;

type
  TfrmAccountGroups = class(TfrmBaseForm)
    fdDataID: TStringField;
    fdDataGroupName: TStringField;
    fdDataDescription: TStringField;
    fdDataBindDate: TSQLTimeStampField;
    fdDataBinderName: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; override;
  end;

const
  SQL_GET_ACCOUNT_GROUPS = 'select * from dbo.App_SelectAccountGroups(:MasterID) ';
  // C275EF5B-73FA-4045-A0C8-2FF420BE086F
  FORM_ID: TGuid =
    (D1: $C275EF5B; D2: $73FA; D3: $4045; D4: ($A0, $C8, $2F, $F4, $20, $BE, $08, $6F));

implementation

{$R *.dfm}

{ TfrmAccountGroups }

class function TfrmAccountGroups.CreateForm(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;
begin
  Result := TfrmAccountGroups.ACreate(AOwner, AParent, IsMaster);
  Result.FormID := FORM_ID;
  Result.SQLText := SQL_GET_ACCOUNT_GROUPS;
  Result.RebuildQuery;
end;

end.
