unit FastFilter;

interface

uses
  SysUtils, Classes, Controls, Forms, StdCtrls, DB, Vcl.ComCtrls;

type
  PDataSet = ^TDataSet;
  PControl = ^TControl;

type
  TfrmFastFilter = class(TForm)
    cmbColumns: TComboBox;
    edtValue: TEdit;
    lblFields: TLabel;
    lblValue: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    udValue: TUpDown;
    chbValue: TCheckBox;
    dtValue: TDateTimePicker;
    //--
    procedure cmbColumnsChange(Sender: TObject);
    procedure cmbColumnsKeyPress(Sender: TObject; var Key: Char);
    procedure chbValueClick(Sender: TObject);
  private
    { Private declarations }
    FDataSet: PDataSet; // Датасет, на данные которого накладывается фильтр
    FCurFieldName: String; // Текущее поле для фильтрации
    //--
    function GetFieldName: String;
    function GetColumnValue: String;
    procedure SetFieldName(const Value: String);
    procedure SwitchInputControls(AFieldName: String);
  public
    { Public declarations }
    property FieldName: String read GetFieldName write SetFieldName;
    property ColumnValue: String read GetColumnValue;
  end;

function GetFastFilter(var DataSet: TDataSet): TfrmFastFilter;
procedure DestroyFastFilter;

var
  frmFastFilter: TfrmFastFilter;

implementation

{$R *.dfm}

uses
  NsConvertUtils;

//---------------------------------------------------------------------------

// Создание окна фильтра и заполнение списка именами колонок
function GetFastFilter(var DataSet: TDataSet): TfrmFastFilter;
var
  I: Integer;
begin
  if frmFastFilter = nil then
  begin
    frmFastFilter := TfrmFastFilter.Create(Application);
    frmFastFilter.cmbColumns.Clear;

    for I := 1 to DataSet.FieldCount - 2 do
      frmFastFilter.cmbColumns.Items.Add(DataSet.Fields.Fields[I].DisplayName);

    frmFastFilter.FDataSet := @DataSet;
  end;

  Result := frmFastFilter;
end;

//---------------------------------------------------------------------------

procedure DestroyFastFilter;
begin
  FreeAndNil(frmFastFilter);
end;

//---------------------------------------------------------------------------
{ TfrmFastFilter }

function TfrmFastFilter.GetFieldName: String;
begin
  Result := FCurFieldName;
end;

//---------------------------------------------------------------------------

// Возвращаемое значение в read-only свойстве
function TfrmFastFilter.GetColumnValue: String;
begin
  Result := '';
  if edtValue.Visible and (not udValue.Visible) then
    Result := edtValue.Text;
  if edtValue.Visible and udValue.Visible then
    Result := IntToStr(udValue.Position);
  if chbValue.Visible then
    Result := IntToStr(BoolToInt(chbValue.Checked));
  if dtValue.Visible then
    Result := DateTimeToStr(dtValue.Date);
  if dtValue.Visible then
    Result := TimeToStr(dtValue.Time);
end;

//---------------------------------------------------------------------------

// Инициализация окна выбора именем поля
procedure TfrmFastFilter.SetFieldName(const Value: String);
var
  ColumnName: String;
begin
  FCurFieldName := Value;
  ColumnName := FDataSet^.FieldByName(Value).DisplayName;
  cmbColumns.ItemIndex := cmbColumns.Items.IndexOf(ColumnName);
  SwitchInputControls(Value);
end;

//---------------------------------------------------------------------------

// Выбор подходящего контрола редактирования
procedure TfrmFastFilter.SwitchInputControls(AFieldName: String);
begin
  edtValue.Visible := False;
  udValue.Visible := False;
  udValue.Associate := nil;
  chbValue.Visible := False;
  dtValue.Visible := False;

  case FDataSet^.FieldByName(AFieldName).DataType of
    ftString, ftWideString:
    begin
      edtValue.Text := FDataSet^.FieldByName(AFieldName).AsString;
      edtValue.Visible := True;
//      edtValue.SetFocus;
    end;

    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
    begin
      udValue.Position := FDataSet^.FieldByName(AFieldName).AsInteger;
      udValue.Associate := edtValue;
      edtValue.Visible := True;
      udValue.Visible := True;
//      edtValue.SetFocus;
    end;

    ftBoolean:
    begin
      chbValue.Checked := FDataSet^.FieldByName(AFieldName).AsBoolean;
      chbValueClick(chbValue);
      chbValue.Visible := True;
//      chbValue.SetFocus;
    end;

    ftFloat, ftCurrency, ftExtended:
    begin
      edtValue.Text := FDataSet^.FieldByName(AFieldName).AsString;
      edtValue.Visible := True;
//      edtValue.SetFocus;
    end;

    ftDate, ftDateTime, ftTimeStamp:
    begin
      dtValue.Kind := dtkDate;
      dtValue.Date := FDataSet^.FieldByName(AFieldName).AsDateTime;
      dtValue.Visible := True;
//      dtValue.SetFocus;
    end;

    ftTime:
    begin
      dtValue.Kind := dtkTime;
      dtValue.Time := FDataSet^.FieldByName(AFieldName).AsDateTime;
      dtValue.Visible := True;
//      dtValue.SetFocus;
    end;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmFastFilter.chbValueClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
    (Sender as TCheckBox).Caption := 'True'
  else
    (Sender as TCheckBox).Caption := 'False';
end;

//---------------------------------------------------------------------------

procedure TfrmFastFilter.cmbColumnsChange(Sender: TObject);
var
  I: Integer;
begin
  for I := 1 to FDataSet^.FieldCount - 2 do
    if FDataSet^.Fields.Fields[I].DisplayName = cmbColumns.Text then
    begin
      FCurFieldName := FDataSet^.Fields.Fields[I].FieldName;
      Break;
    end;

  SwitchInputControls(FCurFieldName);
end;

//---------------------------------------------------------------------------

procedure TfrmFastFilter.cmbColumnsKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

end.
