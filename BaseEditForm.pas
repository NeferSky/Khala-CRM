unit BaseEditForm;

interface

uses
  System.SysUtils, System.Classes, System.Types,
  Winapi.Windows,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus, Vcl.Buttons,
  Data, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  TfrmBaseEditForm = class(TForm)
    sbStatusBar: TStatusBar;
    pnlButtons: TPanel;
    pmnuStatusBar: TPopupMenu;
    mnuCopyID: TMenuItem;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    spEdit: TFDStoredProc;
    trnEdit: TFDTransaction;
    qryGetRecord: TFDQuery;
    procedure mnuCopyIDClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure sbStatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
  private
    { Private declarations }
    FRecordID: TGuid; // ID редактируемой записи
    FModified: Boolean; // Были изменения данных
    //--
    function GetRecordID: TGuid;
    function GetRecordID_AsString: String;
    procedure SetRecordID(const Value: TGuid);
    procedure SetRecordID_AsString(const Value: String);
    procedure UpdateStatusBar;
    function GetUpdateSQLProcedure: String;
    procedure SetUpdateSQLProcedure(const Value: String);
    procedure DoClose;
    function GetSelectSQLText: String;
    procedure SetSelectSQLText(const Value: String);
    procedure Clear;
  public
    { Public declarations }
    class function CreateEditForm(RecordID: TGuid): TfrmBaseEditForm; virtual;
    constructor ACreate(AOwner: TComponent; RecordID: TGuid); overload;
    constructor ACreate(AOwner: TComponent; RecordID: String); overload;
    procedure Open;
    //--
    property RecordID: TGuid read GetRecordID write SetRecordID;
    property RecordID_AsString: String read GetRecordID_AsString write SetRecordID_AsString;
    property UpdateSQLProcedure: String read GetUpdateSQLProcedure write SetUpdateSQLProcedure;
    property SelectSQLText: String read GetSelectSQLText write SetSelectSQLText;
  end;

implementation

uses
  Clipbrd, Kh_Utils, UIThemes;

{$R *.dfm}

{ TfrmBaseEditForm }
//---------------------------------------------------------------------------

constructor TfrmBaseEditForm.ACreate(AOwner: TComponent; RecordID: TGuid);
begin
  inherited Create(AOwner);
  Self.RecordID := RecordID;
end;

//---------------------------------------------------------------------------

constructor TfrmBaseEditForm.ACreate(AOwner: TComponent; RecordID: String);
begin
  inherited Create(AOwner);
  Self.RecordID_AsString := RecordID;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.btnCancelClick(Sender: TObject);
begin
  if trnEdit.Active then
    trnEdit.Rollback;

  spEdit.Cancel;
  spEdit.Close;
  qryGetRecord.Close;

  DoClose;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.btnOkClick(Sender: TObject);
begin
  if not FModified then
  begin
    btnCancelClick(Sender);
    Exit;
  end;

  try
    try
      if not trnEdit.Active then
        trnEdit.StartTransaction;

      spEdit.ExecProc;
      trnEdit.Commit;
      qryGetRecord.Close;

    except
      ShowMessage('edit error');
    end;

  finally
    DoClose;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.Clear;
var
  I: Integer;

begin
  for I := 0 to Self.ControlCount - 1 do
  begin
    if Self.Controls[I].ClassName = 'TEdit' then
      (Self.Controls[I] as TEdit).Clear;
    if Self.Controls[I].ClassName = 'TComboBox' then
      (Self.Controls[I] as TComboBox).Clear;
    if Self.Controls[I].ClassName = 'TButtonedEdit' then
      (Self.Controls[I] as TButtonedEdit).Clear;
    if Self.Controls[I].ClassName = 'TMemo' then
      (Self.Controls[I] as TMemo).Clear;
  end;
end;

//---------------------------------------------------------------------------

class function TfrmBaseEditForm.CreateEditForm(RecordID: TGuid): TfrmBaseEditForm;
begin
  // virtual
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.DoClose;
begin
  Self.Close;
  FreeAndNil(Self);
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.FormCreate(Sender: TObject);
begin
  // Подсветка контролов при наведении курсора
  btnOk.OnMouseEnter := TUtils.ControlMouseEnter;
  btnOk.OnMouseLeave := TUtils.ControlMouseLeave;

  btnCancel.OnMouseEnter := TUtils.ControlMouseEnter;
  btnCancel.OnMouseLeave := TUtils.ControlMouseLeave;

  Clear;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.FormShow(Sender: TObject);
// Применение цветов темы
begin
  Self.Color := KhalaTheme.PanelFilterColor;
  pnlButtons.Color := KhalaTheme.PanelButtonsColor;
end;

//---------------------------------------------------------------------------

function TfrmBaseEditForm.GetRecordID: TGuid;
begin
  Result := FRecordID;
end;

//---------------------------------------------------------------------------

function TfrmBaseEditForm.GetRecordID_AsString: String;
begin
  Result := GuidToString(FRecordID);
end;

//---------------------------------------------------------------------------

function TfrmBaseEditForm.GetSelectSQLText: String;
begin
  Result := qryGetRecord.SQL.Text;
end;

//---------------------------------------------------------------------------

function TfrmBaseEditForm.GetUpdateSQLProcedure: String;
begin
  Result := spEdit.StoredProcName;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.mnuCopyIDClick(Sender: TObject);
// Копирование ID редактируемой записи в буфер обмена
begin
  Clipboard.AsText := '''' + RecordID_AsString + '''';
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.Open;
begin
  qryGetRecord.ParamByName('RecordID').AsGUID := FRecordID;
  qryGetRecord.Prepare;
  qryGetRecord.Open;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.sbStatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
// Применение цветов темы
var
  RectForText: TRect;
begin
  StatusBar.Canvas.Brush.Color := KhalaTheme.PanelFilterColor;
  RectForText := Rect;
  StatusBar.Canvas.FillRect(RectForText);
  DrawText(StatusBar.Canvas.Handle, PChar(Panel.Text), -1, RectForText, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.SetRecordID(const Value: TGuid);
begin
  if FRecordID <> Value then
  begin
    FRecordID := Value;
    UpdateStatusBar;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.SetRecordID_AsString(const Value: String);
begin
  if GuidToString(FRecordID) <> Value then
  begin
    FRecordID := StringToGuid(Value);
    UpdateStatusBar;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.SetSelectSQLText(const Value: String);
begin
  if qryGetRecord.SQL.Text <> Value then
    qryGetRecord.SQL.Text := Value;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.SetUpdateSQLProcedure(const Value: String);
begin
  if spEdit.StoredProcName <> Value then
    spEdit.StoredProcName := Value;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseEditForm.UpdateStatusBar;
begin
  sbStatusBar.Panels[0].Text := RecordID_AsString;
end;

end.
