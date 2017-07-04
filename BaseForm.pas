unit BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Data.DB,
  IBX.IBCustomDataSet, IBX.IBSQL,
  frxClass, frxDBSet, frxExportXLS,
  NsDBGrid, SQLBldr, FieldList, FastFilter, Data, Kh_Consts;

type
  TMasterProc = procedure(ID: String);
  TSlaveProc = procedure;

type
  TfrmBaseForm = class(TForm)
    pnlFastFilter: TPanel;
    btnCloseFastFilter: TSpeedButton;
    lblFastFilter: TLabel;
    btnPrint: TSpeedButton;
    btnExport: TSpeedButton;
    btnRefresh: TSpeedButton;
    btnPlus: TSpeedButton;
    btnNextPage: TSpeedButton;
    btnPrevPage: TSpeedButton;
    lblPage: TLabel;
    btnFirstPage: TSpeedButton;
    edtPage: TEdit;
    udPage: TUpDown;
    pnlButtons: TPanel;
    btnAdd: TBitBtn;
    btnCopy: TBitBtn;
    btnEdit: TBitBtn;
    btnDel: TBitBtn;
    srcData: TDataSource;
    grdData: TNsCustomDBGrid;
    frdsData: TfrxDBDataset;
    frExportXLS: TfrxXLSExport;
    frData: TfrxReport;
    pmnuData: TPopupMenu;
    mnuCreateTicket: TMenuItem;
    sqlGetReport: TIBSQL;
    sqlInsertServiceDesk: TIBSQL;
    dsData: TIBDataSet;
    mnuAdd: TMenuItem;
    mnuCopy: TMenuItem;
    mnuEdit: TMenuItem;
    mnuDel: TMenuItem;
    mnuSeparator: TMenuItem;
    //--
    procedure lblFastFilterClick(Sender: TObject);
    procedure btnCloseFastFilterClick(Sender: TObject);
    procedure grdDataCellClick(Column: TColumn);
    procedure btnPlusClick(Sender: TObject);
    procedure grdDataDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qryDataADOAfterOpen(DataSet: TDataSet);
    procedure btnFirstPageClick(Sender: TObject);
    procedure btnPrevPageClick(Sender: TObject);
    procedure btnNextPageClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure grdDataTitleClick(Column: TColumn);
    procedure grdDataDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure grdDataDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure grdDataMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lblPageClick(Sender: TObject);
    procedure edtPageKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure grdDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure mnuCreateTicketClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure dsDataAfterScroll(DataSet: TDataSet);
    procedure grdDataMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
    SQLBuilder: TSQLBuilder; // ���������� ��������
    FSelectedColumn: String; // ��������� ��������� �������
    FSelectedField: String; // ���� �������� ��������� ��������� �������
    FCurrentPage: Integer; // �������� ��������
    FRowCount: Integer; // ���-�� �������, ������������ �������� (�� �����������)
    FFirstOpen: Boolean; // �������� ������� ����� �� ������ �� ��������
    FOrderByCol: String; // ��������� ��������� ��������� �������
    FSortType: String; // �� �����������/�� ��������
    FDraggedColumn: TColumn; // ������������� ������� ����� ��� drag-drop
    FfrmColumnsList: TfrmColumnsList; // ���� �� ������� �����
    FSQLText: String; // ������, ��������� �������� ��������� � ����
    FFastFiltered: Boolean; // ������� ���������� �������� �������
    FIsMaster: Boolean; // ����� �������� "�������" ��� ������ �����
    FMouseWheelScrolling: Boolean; // ����������� ��������� �����, ���� "�� ��������� ��������� ��������"
    //--
    procedure SetFastFilter(ColumnName, FieldName, ColumnValue: String);
    procedure SetGridColumns;
    procedure CreateNewGridColumn(FieldName: String);
    procedure CreateFieldList(AOwner: TControl);
    procedure SetColumnsList(const AvailableColumns: TStringList);
    procedure MoveFieldList(P: TPoint);
    procedure ShowFieldList;
    function GetDraggedToGridColumn: String;
    procedure EnableButtons;
    procedure ShowPageEdit(DoShow: Boolean);
    procedure ShowColumnsManager(Sender: TObject);
    function GetSQLText: String;
    procedure SetSQLText(const Value: String);
    procedure MoveNextPage;
    procedure MovePrevPage;
    procedure MoveFirstPage;
    procedure MoveToPage(PageNum: Integer);
    procedure PrepareReport;
    procedure PrintReport;
    procedure ExportReport;
    procedure SetMasterID(const Value: String);
    function GetMasterID: String;
    procedure ResetTheme(var Msg: TMessage); message KH_RESET_THEME;
  protected
    { Protected declarations }
    class function CreateForm(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean): TfrmBaseForm; virtual;
  public
    { Public declarations }
    constructor ACreate(AOwner: TComponent; AParent: TWinControl;
      IsMaster: Boolean = False);
    procedure RebuildQuery;
    function GetDraggedFromGridColumn: String;
    procedure Connect;
    procedure Disconnect;
    procedure MoveFirst;
    //--
    property SQLText: String read GetSQLText write SetSQLText;
    property MasterID: String read GetMasterID write SetMasterID;
    property Parent;
  end;

var
  frmBaseForm: TfrmBaseForm;

implementation

uses
  System.UITypes, System.Types,
  BasePageForm, Main, Kh_Utils, UIThemes;

{$R *.dfm}

{ TfrmBaseForm }
//---------------------------------------------------------------------------

procedure TfrmBaseForm.MoveFirst;
begin
  if dsData.Active then
    dsData.First;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.FormCreate(Sender: TObject);
const
  S_SQL_GET_REPORT = 'SELECT * FROM Get_Form_Report(:FORM_NAME)';
  S_SQL_SET_PROGRAMMIST_TASK = 'EXECUTE PROCEDURE Set_New_Ticket ' +
    '(:CREATED_BY_ID, :OWNER_ID, :TABLE_NAME, :RECORD_ID)';

begin
  sqlGetReport.SQL.Text := S_SQL_GET_REPORT;

  frExportXLS.FileName := Self.Caption;
  btnCloseFastFilter.Visible := False;
  lblFastFilter.Caption := '';
  // ���, ����, ���������� ������� ��������� TCustomGrid ��� ��������� ������ ����������� �����
  //TStringGrid(grdData).GridLineWidth := 2;

  // �������� � ������������� ����������� ��������
  FCurrentPage := 1;
  FOrderByCol := '1';
  FSortType := 'ASC';
  FFirstOpen := True;

  SQLBuilder := TSQLBuilder.Create(Self);
  SQLBuilder.DataSet := @dsData;
  SQLBuilder.SelectPart := '';
  SQLBuilder.OffsetPart := FCurrentPage;
  SQLBuilder.OrderPart := FOrderByCol;
  SQLBuilder.SortPart := FSortType;

  // ��������� ��������� ��� ��������� �������
  lblFastFilter.OnMouseEnter := TUtils.ControlMouseEnter;
  lblFastFilter.OnMouseLeave := TUtils.ControlMouseLeave;

  lblPage.OnMouseEnter := TUtils.ControlMouseEnter;
  lblPage.OnMouseLeave := TUtils.ControlMouseLeave;

  edtPage.OnMouseEnter := TUtils.ControlMouseEnter;
  edtPage.OnMouseLeave := TUtils.ControlMouseLeave;

  btnAdd.OnMouseEnter := TUtils.ControlMouseEnter;
  btnAdd.OnMouseLeave := TUtils.ControlMouseLeave;

  btnCopy.OnMouseEnter := TUtils.ControlMouseEnter;
  btnCopy.OnMouseLeave := TUtils.ControlMouseLeave;

  btnDel.OnMouseEnter := TUtils.ControlMouseEnter;
  btnDel.OnMouseLeave := TUtils.ControlMouseLeave;

  btnEdit.OnMouseEnter := TUtils.ControlMouseEnter;
  btnEdit.OnMouseLeave := TUtils.ControlMouseLeave;

  btnCloseFastFilter.OnMouseEnter := TUtils.ControlMouseEnter;
  btnCloseFastFilter.OnMouseLeave := TUtils.ControlMouseLeave;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.FormDestroy(Sender: TObject);
begin
  // ���������� �������� ������� �����. ������ �����, �� ��� �����.
  if not DirectoryExists('Config') then
    CreateDirectory('Config', nil);

  grdData.Columns.SaveToFile('Config\' + Sender.ClassName);
end;

//---------------------------------------------------------------------------

// ������������ � ������ SQL-�������, ��������� ���-�� ������������ �� �����
procedure TfrmBaseForm.RebuildQuery;
begin
  SQLBuilder.SelectPart := FSQLText;
  SQLBuilder.OffsetPart := FCurrentPage;
  SQLBuilder.BuildQuery(True);
  FRowCount := SQLBuilder.RowCount;
end;

//---------------------------------------------------------------------------

// ���������� ������ ����
procedure TfrmBaseForm.ResetTheme(var Msg: TMessage);
begin
  Self.Color := KhalaTheme.PanelFilterColor;
  pnlButtons.Color := KhalaTheme.PanelButtonsColor;
  grdData.GradientStartColor := KhalaTheme.GridGradientStartColor;
  grdData.GradientEndColor := KhalaTheme.GridGradientEndColor;
end;

//---------------------------------------------------------------------------

// ���������� ��������� ������� ��� ���������� ������������� � "������� �������"
procedure TfrmBaseForm.grdDataCellClick(Column: TColumn);
begin
  try
    if not FFastFiltered then
    begin
      lblFastFilter.Caption := Column.Title.Caption;
      FSelectedColumn := Column.Title.Caption;
      FSelectedField := Column.FieldName;
    end;
  except
    // ����� ������, ���� ������
    // � ������ ����� ����� ��������� �������� � ������������ ������-����� ���
    // � ������ ����� ����� ��������� ������� � �������������� ������-�����
    on E: EArgumentOutOfRangeException do
      Abort;
  end;
end;

//---------------------------------------------------------------------------

// ������ � ���������� �������� �������
procedure TfrmBaseForm.lblFastFilterClick(Sender: TObject);
const
  DX = 8;

begin
  with GetFastFilter(TDataSet(dsData)) do // ������� � ����������� ���������� ����
  begin
    FieldName := FSelectedField;

    if ShowModal = mrOk then
      SetFastFilter(FSelectedColumn, FSelectedField, ColumnValue);

    DestroyFastFilter;
  end;
end;

//---------------------------------------------------------------------------

// ��������������� ���������� �������� �������
procedure TfrmBaseForm.SetFastFilter(ColumnName, FieldName, ColumnValue: String);
const
  DX = 8;

begin
  SQLBuilder.FilterPart := FieldName + ' LIKE ''%' + ColumnValue + '%''';
  RebuildQuery;

  lblFastFilter.Caption := Format('%s   =   %s', [ColumnName, ColumnValue]);
  lblFastFilter.Left := btnCloseFastFilter.Left + btnCloseFastFilter.Width + DX;
  btnCloseFastFilter.Visible := True;
  FFastFiltered := True;
end;

//---------------------------------------------------------------------------

// ��������������� ������ �������� �������
procedure TfrmBaseForm.btnCloseFastFilterClick(Sender: TObject);
begin
  SQLBuilder.FilterPart := '';
  RebuildQuery;

  lblFastFilter.Caption := FSelectedColumn;
  btnCloseFastFilter.Visible := False;
  lblFastFilter.Left := btnCloseFastFilter.Left;
  FFastFiltered := False;
end;

//---------------------------------------------------------------------------

// ����������
procedure TfrmBaseForm.grdDataTitleClick(Column: TColumn);
begin
  // ���� ��������� �������, ������������� �� ����� - ������ ����������� ����������
  if FOrderByCol = Column.FieldName then
  begin
    if FSortType = 'ASC' then
      FSortType := 'DESC'
    else
      FSortType := 'ASC';
  end

  // ���� ��������� ������ �������
  else
  begin
    FOrderByCol := Column.FieldName;
    FSortType := 'ASC';
  end;

  FCurrentPage := 1;
  SQLBuilder.OrderPart := FOrderByCol;
  SQLBuilder.SortPart := FSortType;
  SQLBuilder.OffsetPart := FCurrentPage;
  RebuildQuery;
end;

//---------------------------------------------------------------------------

// ���������� ����� � ���� ����� �������� ��������
procedure TfrmBaseForm.qryDataADOAfterOpen(DataSet: TDataSet);
begin
  lblPage.Caption := '���. � ' + IntToStr(FCurrentPage);

  if FFirstOpen then
  begin
    FFirstOpen := False;
    if FileExists('Config\' + Self.ClassName) then
      grdData.Columns.LoadFromFile('Config\' + Self.ClassName)
    else
      SetGridColumns;
    Self.Resize;
  end;

  EnableButtons;
end;

//---------------------------------------------------------------------------

// �������� ������� ����� - �� ����� 10 � ����������� ������
procedure TfrmBaseForm.SetGridColumns;
var
  I, K: Integer;

begin
  I := 0;
  K := 0;

  // 10 ������ ���������� ��� ���
  while (I < 10) and (K < dsData.Fields.Count) do
  begin
    // ������������� ����
    case dsData.Fields.Fields[K].DataType of
      ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat, ftCurrency,
      ftDate, ftTime, ftDateTime, ftWideString, ftLargeint, ftTimeStamp,
      ftLongWord, ftShortint, ftByte, ftExtended:
      begin
        // ������ �������
        if dsData.Fields.Fields[K].Visible then
        begin
          CreateNewGridColumn(dsData.Fields.Fields[K].FieldName);
          Inc(I);
        end;
      end;
    end;
  Inc(K);
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.SetMasterID(const Value: String);
begin
  SQLBuilder.MasterID := Value;
end;

//---------------------------------------------------------------------------

// ����������� ������� ����� ��� ��������� ������ ���� �� ������ ��������� �����
// ����� 1 - ����
procedure TfrmBaseForm.grdDataDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);

  // ���� ����� ���������� �� ����� �������,
  // � ���� ������� - ����������� (� ��� ��� ��� ��������?) ������ �����
  function IsNewFieldMoving: Boolean;
  begin
    if FfrmColumnsList <> nil then
      Result := ((Source as TControl).Name = FfrmColumnsList.tvColumnsList.Name)
        and ((Self as TControl).Name = FfrmColumnsList.Owner.Name)
    else
      Result := False;
  end;

  // ����������� �� ����� � ��� �� ���� - ����������� �������
  function IsGridColumnMoving: Boolean;
  begin
    Result := Sender = Source;
  end;

begin
  Accept := IsNewFieldMoving or IsGridColumnMoving;
end;

//---------------------------------------------------------------------------

// ����������� ������� ����� ��� ��������� ������ ���� �� ������ ��������� �����
// ����� 2 - ����
procedure TfrmBaseForm.grdDataDragDrop(Sender, Source: TObject; X,
  Y: Integer);

var
  ColumnName: String;
  ColumnNum: Integer;
  I: Integer;

  // ���� ����� ���������� �� ����� �������,
  // � ���� ������� - ����������� (� ��� ��� ��� ��������?) ������ �����
  function IsNewFieldMoving: Boolean;
  begin
    if FfrmColumnsList <> nil then
      Result := ((Source as TControl).Name = FfrmColumnsList.tvColumnsList.Name)
        and ((Self as TControl).Name = FfrmColumnsList.Owner.Name)
    else
      Result := False;
  end;

  // ����������� �� ����� � ��� �� ���� - ����������� �������
  function IsGridColumnMoving: Boolean;
  begin
    Result := Sender = Source;
  end;

begin
  // ��� ����������� ������� � �������� ����� - ������ ���������� ������ ����������� ������
  if IsGridColumnMoving then
  begin
    ColumnNum := grdData.MouseCoord(X, Y).X;
    FDraggedColumn.Index := ColumnNum;
    Exit;
  end;

  // ��� ����������� ����� ������� �� ����� - �������� ����� �������
  if IsNewFieldMoving then
  begin
    ColumnName := GetDraggedToGridColumn;
    for I := 0 to dsData.FieldCount - 1 do
      if dsData.Fields[I].DisplayName = ColumnName then
      begin
        CreateNewGridColumn(dsData.Fields[I].FieldName);
        Self.Resize;
      end;
  end;

  // �� ������ ������ �������� ����� �� ������ ������� - ��� �������� �������
  try
    grdDataCellClick(grdData.Columns.Items[1]);
  except
    ;
  end;
end;

//---------------------------------------------------------------------------

// ���������� �������, ������� ������� � ��������� ��������
procedure TfrmBaseForm.grdDataMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ColumnNum: Integer;

begin
  // ����� ������� �������� ������� ���� �������,
  // �� �� �������� ����������, ��� ������� ������� � ������������
  if Button = mbRight then
  begin
    (Sender as TControl).BeginDrag(False, 5);
    ColumnNum := grdData.MouseCoord(X, Y).X;
    FDraggedColumn := grdData.Columns[ColumnNum];
  end;
end;

//---------------------------------------------------------------------------

// ��������� ����� �� ������ �������� �������������� ��������, ��� ���� � Delphi 7
procedure TfrmBaseForm.grdDataMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  FMouseWheelScrolling := True;
end;

//---------------------------------------------------------------------------

// ���������� ����� ������� � ����
procedure TfrmBaseForm.CreateNewGridColumn(FieldName: String);
var
  Column: TColumn;

begin
  Column := grdData.Columns.Add;
  Column.Field := dsData.Fields.FieldByName(FieldName);
  Column.Title.Caption := dsData.Fields.FieldByName(FieldName).DisplayName; // �� � ������ �����!
  Column.Title.Font.Style := Column.Title.Font.Style + [fsBold];
  Column.Title.Font.Color := CL_GRID_TITLE;
  Column.Font.Color := CL_TEXT;

  // ��� ��� ��������� ������ �������. ������ �����, �� ��� �����.
  case Column.Field.DataType of
    ftString, ftWideString:
      Column.Field.DisplayWidth := 4;

    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Column.Field.DisplayWidth := 2;

    ftBoolean:
      Column.Field.DisplayWidth := 1;

    ftFloat, ftCurrency, ftExtended:
      Column.Field.DisplayWidth := 3;

    ftDate, ftDateTime, ftTimeStamp:
      Column.Field.DisplayWidth := 3;

    ftTime:
      Column.Field.DisplayWidth := 2;
  end;

  if FieldName = 'Color' then
    Column.Visible := False;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.Disconnect;
begin
  dsData.Close;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.dsDataAfterScroll(DataSet: TDataSet);
begin
  if FIsMaster and (not FMouseWheelScrolling) then
    (Owner as TfrmBasePage).MasterProc(dsData.FieldByName('ID').AsString);

  // ������������ ���� ����������, �������, ��� �� ��� �� ���
  FMouseWheelScrolling := False;
end;

//---------------------------------------------------------------------------

// ��������� ������������� ���� �� ����� ��������� ����� (��� ��� ��������) ���
// ����������� � ����
function TfrmBaseForm.GetDraggedToGridColumn: String;
begin
  if FfrmColumnsList.DraggedColumn <> nil then
  begin
    Result := FfrmColumnsList.DraggedColumn.Text;
    FfrmColumnsList.RemoveDraggedColumn;
  end;
end;

//---------------------------------------------------------------------------

function TfrmBaseForm.GetMasterID: String;
begin
  Result := SQLBuilder.MasterID;
end;

//---------------------------------------------------------------------------

// ��������� ������������ ������� ����� ��� ����������� � ����� ��������� �����
function TfrmBaseForm.GetDraggedFromGridColumn: String;
begin
  if FDraggedColumn <> nil then
  begin
    Result := FDraggedColumn.Title.Caption;
    grdData.Columns.Delete(FDraggedColumn.Index);
    Self.Resize;
  end;

  // ����� ������� ������� �������� �������
  try
    grdDataCellClick(grdData.Columns.Items[1]);
  except
    ;
  end;
end;

//---------------------------------------------------------------------------

// ���������� � ���������� ����� �� ������� ��������� ����� �����
procedure TfrmBaseForm.ShowColumnsManager(Sender: TObject);
var
  P: TPoint;
  AvailableColumns: TStringList;
  I: Integer;
  FieldNumber: Integer;

begin
  CreateFieldList(Self);

  // ��������-���������� ������ ���� ��������� �������
  AvailableColumns := TStringList.Create;
  AvailableColumns.Clear;
  for I := 0 to dsData.FieldCount - 1 do
    // ����� ������ �������
    if dsData.Fields[I].Visible then
      AvailableColumns.Add(dsData.Fields[I].DisplayName);

  // �������, ����� ������� ��� ���� �� �����
  for I := grdData.Columns.Count - 1 downto 0 do
  begin
    FieldNumber := AvailableColumns.IndexOf(grdData.Columns[I].Title.Caption);
    if FieldNumber > -1 then
      AvailableColumns.Delete(FieldNumber);
  end;
  SetColumnsList(AvailableColumns);
  AvailableColumns.Free;

  // ����� ������� ���� ������
  P := Point(btnPlus.Left, btnPlus.Top);
  // ����� ������� ���� ������ ����
  P := Point(P.X - FfrmColumnsList.Width, P.Y + grdData.Height - FfrmColumnsList.Height);
  P := ClientToScreen(P);
  MoveFieldList(P);

  ShowFieldList;
end;

//---------------------------------------------------------------------------

constructor TfrmBaseForm.ACreate(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean = False);
begin
  inherited Create(AOwner);
  Parent := AParent;
  FIsMaster := IsMaster;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.Connect;
begin
  RebuildQuery;
end;

//---------------------------------------------------------------------------

// �������� ����� �� ������� ��������� �����
procedure TfrmBaseForm.CreateFieldList(AOwner: TControl);
begin
  if FfrmColumnsList = nil then
    FfrmColumnsList := TfrmColumnsList.Create(AOwner);

  FfrmColumnsList.Associate := grdData;
end;

//---------------------------------------------------------------------------

class function TfrmBaseForm.CreateForm(AOwner: TComponent; AParent: TWinControl;
  IsMaster: Boolean): TfrmBaseForm;
begin
// virtual
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.SetColumnsList(const AvailableColumns: TStringList);
begin
  if FfrmColumnsList <> nil then
    FfrmColumnsList.ColumnsList := AvailableColumns;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.MoveFieldList(P: TPoint);
begin
  if FfrmColumnsList <> nil then
  begin
    FfrmColumnsList.Left := P.X;
    FfrmColumnsList.Top := P.Y;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.ShowFieldList;
begin
  if FfrmColumnsList <> nil then
    FfrmColumnsList.Show;
end;

//---------------------------------------------------------------------------

// �������� ������� ����� �������� ����������
procedure TfrmBaseForm.grdDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  KEY_PAGE_UP = 33;
  KEY_PAGE_DOWN = 34;
  KEY_ARROW_LEFT = 37;
  KEY_ARROW_UP = 38;
  KEY_ARROW_RIGHT = 39;
  KEY_ARROW_DOWN = 40;

begin
  if (ssCtrl in Shift) and (Key = KEY_ARROW_RIGHT) then
    MoveNextPage;

  if ((Key = KEY_ARROW_DOWN) or (Key = KEY_PAGE_DOWN)) and dsData.Eof then
    MoveNextPage;

  if (ssCtrl in Shift) and (Key = KEY_ARROW_LEFT) then
    MovePrevPage;

  if ((Key = KEY_ARROW_UP) or (Key = KEY_PAGE_UP)) and dsData.Bof then
    MovePrevPage;
end;

//---------------------------------------------------------------------------
// ������ �����

procedure TfrmBaseForm.btnExportClick(Sender: TObject);
begin
  ExportReport;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnFirstPageClick(Sender: TObject);
begin
  MoveFirstPage;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnNextPageClick(Sender: TObject);
begin
  MoveNextPage;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnPlusClick(Sender: TObject);
begin
  ShowColumnsManager(Sender);
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnPrevPageClick(Sender: TObject);
begin
  MovePrevPage;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnPrintClick(Sender: TObject);
begin
  PrintReport;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnRefreshClick(Sender: TObject);
begin
  RebuildQuery;
end;

//---------------------------------------------------------------------------
// ������������ �� ���������

procedure TfrmBaseForm.MoveFirstPage;
begin
  if FCurrentPage > 1 then
  begin
    FCurrentPage := 1;
    RebuildQuery;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.MoveNextPage;
begin
  if SQLBuilder.RowCount > (FCurrentPage * RECS_ON_PAGE) then
  begin
    Inc(FCurrentPage);
    RebuildQuery;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.MovePrevPage;
begin
  if FCurrentPage > 1 then
  begin
    Dec(FCurrentPage);
    RebuildQuery;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.MoveToPage(PageNum: Integer);
begin
  FCurrentPage := udPage.Position;
  RebuildQuery;
end;

//---------------------------------------------------------------------------

// ������ �� ���� ������-������� ������� �����
procedure TfrmBaseForm.PrepareReport;
var
  RepStream: TStream;
begin
  RepStream := TStream.Create;
  try
    sqlGetReport.ParamByName('FORM_NAME').Value := Self.Name;
    sqlGetReport.ExecQuery;
    TBlobField(sqlGetReport.FieldByName('ReportFile')).SaveToStream(RepStream);
    sqlGetReport.Close;

    frData.LoadFromStream(RepStream);
    frData.PrepareReport;
  except
    ShowMessage('������ ��� ���������� ������');
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.PrintReport;
begin
  PrepareReport;
  frData.ShowPreparedReport;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.ExportReport;
begin
  PrepareReport;
  frData.Export(frExportXLS);
end;

//---------------------------------------------------------------------------

// ���������� ���� ����� ������ ��������
procedure TfrmBaseForm.lblPageClick(Sender: TObject);
begin
  udPage.Position := FCurrentPage;
  ShowPageEdit(True);
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnAddClick(Sender: TObject);
begin

end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnCopyClick(Sender: TObject);
begin

end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnEditClick(Sender: TObject);
begin

end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.btnDelClick(Sender: TObject);
begin

end;

//---------------------------------------------------------------------------

// ������ �� ������������ � ������-���� ������� ��������� ������
procedure TfrmBaseForm.mnuCreateTicketClick(Sender: TObject);
begin
  //ShowServiceDeskTicketForm;
  sqlInsertServiceDesk.ParamByName('CREATED_BY_ID').AsString := frmMain.UserID;
  sqlInsertServiceDesk.ParamByName('TICKET_NUM').AsInteger := 1;
  sqlInsertServiceDesk.ParamByName('OWNER_ID').AsString := frmMain.UserID;
  sqlInsertServiceDesk.ParamByName('TABLE_NAME').AsString := Self.Name;
  sqlInsertServiceDesk.ParamByName('RECORD_ID').AsString := '''' + dsData.FieldByName('ID').AsString + '''';
//  sqlInsertServiceDesk.ParamByName('DESCRIPTION').AsString := frmTaskDescription.TaskDescription;
  sqlInsertServiceDesk.ExecQuery;
  sqlInsertServiceDesk.Close;
end;

//---------------------------------------------------------------------------

// ������� �� ��������� �������� ��� ������
procedure TfrmBaseForm.edtPageKeyPress(Sender: TObject; var Key: Char);
begin
  case Ord(Key) of
  VK_RETURN:
    begin
      MoveToPage(udPage.Position);
      ShowPageEdit(False);
    end;
  VK_ESCAPE:
    ShowPageEdit(False);
  end;
end;

//---------------------------------------------------------------------------

// ����� ��� ������� ���� ����� ������ �������� ��� ��������
procedure TfrmBaseForm.ShowPageEdit(DoShow: Boolean);
begin
  lblPage.Visible := not DoShow;
  edtPage.Visible := DoShow;
  udPage.Visible := DoShow;

  if DoShow then
    edtPage.SetFocus;
end;

//---------------------------------------------------------------------------

// ������������ ���������� ������ � ����������� �� ��������� ��������
procedure TfrmBaseForm.EnableButtons;
var
  Active: Boolean;

begin
  btnAdd.Enabled := dsData.Active;

  Active := (dsData.Active) and (dsData.RecordCount > 0);
  btnCopy.Enabled := Active;
  btnEdit.Enabled := Active;
  btnDel.Enabled := Active;

  if udPage.Visible then
    udPage.Visible := False;
  if edtPage.Visible then
    edtPage.Visible := False;
  if not lblPage.Visible then
    lblPage.Visible := True;
end;

//---------------------------------------------------------------------------

// ������ ������ ������� �����
procedure TfrmBaseForm.FormResize(Sender: TObject);
const
  DX = 70; // ��������� ������� ����

var
  AllWeights: Integer;
  OnePiece: Double;
  I: Integer;

begin
{
//////// ���������� �� DBGridEh:

function MulDiv; external kernel32 name 'MulDiv';

function TCustomDBGridEh.DataToRawColumn(ACol: Integer): Integer;
begin
  Result := ACol + FIndicatorOffset;
end;

procedure TCustomDBGridEh.SetSortMarkedColumns;
var i: Integer;
begin
  SortMarkedColumns.Clear;
  for i := 0 to Columns.Count - 1 do
    if Columns[i].Title.SortIndex > 0 then
    begin
      if SortMarkedColumns.Count < Columns[i].Title.SortIndex then
        SortMarkedColumns.Count := Columns[i].Title.SortIndex;
      SortMarkedColumns[Columns[i].Title.SortIndex - 1] := Columns[i];
    end;
end;

procedure TCustomDBGridEh.InvalidateCol(ACol: Integer);
var
  Rect: TRect;
begin
  if not HandleAllocated then Exit;
  Rect := BoxRect(ACol, 0, ACol, TopRow+VisibleRowCount+1);
  WindowsInvalidateRect(Handle, Rect, False);
//  inherited InvalidateCol(ACol);
end;

function iif(Condition: Boolean; V1, V2: Integer): Integer;
begin
  if (Condition) then Result := V1 else Result := V2;
end;

procedure TDBGridColumnsEh.Update(Item: TCollectionItem);
var
  Raw: Integer;
  OldWidth: Integer;
begin
  if (FGrid = nil) or (csLoading in FGrid.ComponentState) then Exit;
  if (Item = nil) then
  begin
    FGrid.SetSortMarkedColumns;
    FGrid.LayoutChanged;
  end else
  begin
    Raw := FGrid.DataToRawColumn(Item.Index);
    FGrid.InvalidateCol(Raw);
    //FGrid.ColWidths[Raw] := TColumnEh(Item).Width;
    if (FGrid.AutoFitColWidths = False) or (csDesigning in FGrid.ComponentState) then
    begin
       //FGrid.ColWidths[Raw] := TColumnEh(Item).Width;
      if (FGrid.ColWidths[Raw] <> TColumnEh(Item).Width)
        then FGrid.ColWidths[Raw] :=
        iif(TColumnEh(Item).Visible, TColumnEh(Item).Width, iif(dgColLines in FGrid.Options, -1, 0))
      else if (FGrid.UseMultiTitle = True) //and not (csDesigning in FGrid.ComponentState)
        then FGrid.LayoutChanged; // If Title.Caption was changed
    end else if FGrid.ColWidths[Raw] <> -1 then
    begin
      OldWidth := TColumnEh(Item).FInitWidth;
      TColumnEh(Item).FInitWidth :=
        MulDiv(TColumnEh(Item).FInitWidth, TColumnEh(Item).Width, FGrid.ColWidths[Raw]);
      if (Raw <> FGrid.ColCount - 1) then
      begin
        Inc(FGrid.Columns[Raw - FGrid.FIndicatorOffset + 1].FInitWidth,
          OldWIdth - FGrid.FColumns[Raw - FGrid.FIndicatorOffset].FInitWidth);
        if (FGrid.Columns[Raw - FGrid.FIndicatorOffset + 1].FInitWidth < 0)
          then FGrid.Columns[Raw - FGrid.FIndicatorOffset + 1].FInitWidth := 0;
      end;
      FGrid.LayoutChanged;
    end;
  end;
  if (Count > 0) and (Items[FGrid.SelectedIndex].Visible = False) and (FGrid.VisibleColumns.Count > 0)
    then FGrid.SelectedIndex := FGrid.VisibleColumns[0].Index;
  if FGrid.LayoutLock = 0 then
    FGrid.InvalidateEditor; //Need to comment to avoid FInplaceCol = -1 in set AlwoseShowEditor;
end;
}


  AllWeights := grdData.Columns.Count;
  OnePiece := (grdData.Width - DX) / AllWeights;


  for I := 0 to grdData.Columns.Count - 1 do
  begin
    grdData.Columns[I].Width := Round(OnePiece); //Round(OnePiece * grdData.Columns[I].Field.DisplayWidth);
  end;
end;

//---------------------------------------------------------------------------

// ��������� �����
procedure TfrmBaseForm.grdDataDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  R: TRect;
begin
  // ��������� ���������� ��������� ������
  with TNsCustomDBGrid(Sender) do
  begin
    if DataLink.ActiveRecord = Row - 1 then
      Canvas.Brush.Color := KhalaTheme.SelectedRowColor
    else
      Canvas.Brush.Color := clWhite;

    Canvas.Font.Color := clBlack;
  end;

  // ������� ������-����� ������ ������
  // ������� ������������� ��� ������ ������� ������...
  TNsCustomDBGrid(Sender).Canvas.FillRect(Rect);
  // ...����� ����������� ������ ������� ���������.
  // ����� ����� ����������, ��� ����� Rect - ���������
  R := Rect;
  R.Left := Rect.Left + 2;
  R.Right := Rect.Right - 4;

  // ����� ������������ ����������� � ������ �����������
  TNsCustomDBGrid(Sender).DefaultDrawColumnCell(R, DataCol, Column, State);
end;

//---------------------------------------------------------------------------
// ������ ��� �������

function TfrmBaseForm.GetSQLText: String;
begin
  Result := FSQLText;
end;

//---------------------------------------------------------------------------

procedure TfrmBaseForm.SetSQLText(const Value: String);
begin
  if FSQLText <> Value then
    FSQLText := Value;
end;

end.
