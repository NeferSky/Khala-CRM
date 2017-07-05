unit FormAccountGroups;

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
  TfrmAccountGroups = class(TfrmBaseForm)
    dsDataID: TIBStringField;
    dsDataGROUP_NAME: TIBStringField;
    dsDataDESCRIPTION: TIBStringField;
    dsDataBIND_DATE: TDateTimeField;
    dsDataBINDER: TIBStringField;
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
