unit BasePageForm;

interface

uses
  Winapi.Messages, Winapi.Windows,
  System.Classes,
  Generics.Collections,
  SysUtils,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  BaseForm, Kh_Consts, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.Actions,
  Vcl.ActnList, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Menus,
  frxClass;

type
  TReportMenuItem = class(TMenuItem)
  private
    FReportID: String;
  public
    property ReportID: String read FReportID write FReportID;
  end;

type
  TfrmBasePage = class(TForm)
    pnlLeft: TPanel;
    pnlActions: TPanel;
    lblActions: TLabel;
    lblReports: TLabel;
    splFilter: TSplitter;
    pnlFilterArea: TPanel;
    splLeft: TSplitter;
    pnlWorkArea: TPanel;
    pcMaster: TPageControl;
    splDetails: TSplitter;
    pcDetails: TPageControl;
    qryReports: TFDQuery;
    alActions: TActionList;
    pmnuActions: TPopupMenu;
    pmnuReports: TPopupMenu;
    frReport: TfrxReport;
    //--
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pcDetailsChange(Sender: TObject);
    procedure pmnuReportsItemClick(Sender: TObject);
    procedure lblActionsClick(Sender: TObject);
    procedure lblReportsClick(Sender: TObject);
  private
    { Private declarations }
    FPageID: TGuid; // Идентификатор формы
    //--
    procedure ReadActionsList;
    procedure ReadReportsList;
    procedure ResetTheme(var Msg: TMessage); message KH_RESET_THEME;
    function GetPageID: TGuid;
    function GetPageID_AsString: String;
    procedure SetPageID(const Value: TGuid);
    procedure SetPageID_AsString(const Value: String);
  protected
    MasterForm: TfrmBaseForm; // Мастер-форма с мастер-датасетом
    DetailsList: TList<TfrmBaseForm>; // Лист детализующих форм
    //--
    class function GetPage(AOwner: TComponent;
      AParent: TWinControl): TfrmBasePage; virtual;
  public
    { Public declarations }
    constructor ACreate(AOwner: TComponent; AParent: TWinControl);
    procedure MasterProc(ID: String);
    //--
    property Parent;
    property PageID: TGuid read GetPageID write SetPageID;
    property PageID_AsString: String read GetPageID_AsString write SetPageID_AsString;
  end;

implementation

uses
  Vcl.Dialogs, Kh_Utils, UIThemes, Data;

{$R *.dfm}

{ TfrmBasePage }
//---------------------------------------------------------------------------

constructor TfrmBasePage.ACreate(AOwner: TComponent; AParent: TWinControl);
begin
  inherited Create(AOwner);
  DetailsList := TList<TfrmBaseForm>.Create;
  Parent := AParent;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.FormCreate(Sender: TObject);
begin
  // Подсветка контролов при наведении курсора
  lblActions.OnMouseEnter := TUtils.ControlMouseEnter;
  lblActions.OnMouseLeave := TUtils.ControlMouseLeave;

  lblReports.OnMouseEnter := TUtils.ControlMouseEnter;
  lblReports.OnMouseLeave := TUtils.ControlMouseLeave;

  // Чтение списков действий и отчетов для этой страницы
  ReadActionsList;
  ReadReportsList;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.FormDestroy(Sender: TObject);
var
  I: Integer;

begin
  for I := 0 to DetailsList.Count - 1 do
    if DetailsList[I] <> nil then
      DetailsList[I].Free;

  DetailsList.Free;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.FormShow(Sender: TObject);
// Применение цветов темы
var
  Dummy: TMessage;
begin
  ResetTheme(Dummy);
end;

//---------------------------------------------------------------------------

class function TfrmBasePage.GetPage(AOwner: TComponent;
  AParent: TWinControl): TfrmBasePage;
begin
  // virtual;
end;

//---------------------------------------------------------------------------

function TfrmBasePage.GetPageID: TGuid;
begin
  Result := FPageID;
end;

//---------------------------------------------------------------------------

function TfrmBasePage.GetPageID_AsString: String;
begin
  Result := GUIDToString(FPageID);
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.lblActionsClick(Sender: TObject);
// Вызов меню действий
var
  P: TPoint;

begin
  P.X := (Sender as TLabel).Left;
  P.Y := (Sender as TLabel).Height + (Sender as TLabel).Top;

  P := ClientToScreen(P);
  pmnuActions.Popup(P.X, P.Y);
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.lblReportsClick(Sender: TObject);
// Вызов меню отчетов
var
  P: TPoint;

begin
  P.X := (Sender as TLabel).Left;
  P.Y := (Sender as TLabel).Height + (Sender as TLabel).Top;

  P := ClientToScreen(P);
  pmnuReports.Popup(P.X, P.Y);
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.MasterProc(ID: String);
// Вызывается мастер-датасетом страницы при передвижении по записям
var
  I: Integer;
  NeedUpdate: Boolean;
  SlaveExistsVoobscheOrNot: Boolean;

begin
  NeedUpdate := False;

  if ID = '' then
  begin
    for I := 0 to DetailsList.Count - 1 do
      DetailsList[I].Disconnect;
  end
  else
  begin
    // При создании страницы это упасет нас от бед
    SlaveExistsVoobscheOrNot := (pcDetails.ActivePageIndex <= DetailsList.Count - 1)
      and (DetailsList[pcDetails.ActivePageIndex] <> nil);

    // Нужно ли передергивать запрос на активной вкладке
    if SlaveExistsVoobscheOrNot then
      NeedUpdate := DetailsList[pcDetails.ActivePageIndex].MasterID <> ID;

    // Новый параметр - всем
    for I := 0 to DetailsList.Count - 1 do
      DetailsList[I].MasterID := ID;

    // Передергивание датасета на активной вкладке, если нужно
    if SlaveExistsVoobscheOrNot and NeedUpdate then
      DetailsList[pcDetails.ActivePageIndex].RebuildQuery;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.pcDetailsChange(Sender: TObject);
// Отключение датасетов на вкладках, кроме той, что открыта сейчас (для экономии,
// чтобы не передергивать по 5-10 датасетов на одно перемещение по строкам)
var
  I: Integer;

begin
  for I := 0 to DetailsList.Count - 1 do
    DetailsList[I].Disconnect;

  DetailsList.Items[pcDetails.ActivePageIndex].Connect;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.pmnuReportsItemClick(Sender: TObject);
// Запуск отчета из меню отчетов
const
  SQL_GET_REPORT = 'select * from dbo.App_GetReport(:ReportID)';

var
  ReportStream: TStream;

begin
  try
    if qryReports.Active then
      qryReports.Close;

    try
      qryReports.SQL.Text := SQL_GET_REPORT;
      qryReports.ParamByName('ReportID').AsString := (Sender as TReportMenuItem).ReportID;
      qryReports.Prepare;
      qryReports.Open;

      ReportStream := TStream.Create;
      try
        (qryReports.FieldByName('ReportData') as TBlobField).SaveToStream(ReportStream);
        frReport.LoadFromStream(ReportStream);
      finally
        ReportStream.Free;
      end;

    except
      raise EPrepareReportError.Create;
    end;

  finally
    qryReports.Close;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.ReadActionsList;
// Чтение и присваивание списка действий
var
  Item: TReportMenuItem;
  I: Integer;

begin
  for I := 0 to alActions.ActionCount - 1 do
  begin
    Item := TReportMenuItem.Create(Self);
    Item.Action := alActions.Actions[I];
    pmnuReports.Items.Add(Item);
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.ReadReportsList;
// Чтение и присваивание списка отчетов
const
  SQL_GET_REPORT_LIST = 'select * from dbo.App_GetReportList(:FormName)';

var
  Item: TReportMenuItem;

begin
  if qryReports.Active then
    qryReports.Close;

  try
    qryReports.SQL.Text := SQL_GET_REPORT_LIST;
    qryReports.ParamByName('FormName').AsString := Self.Name;
    qryReports.Prepare;
    qryReports.Open;

    while not qryReports.Eof do
    begin
      Item := TReportMenuItem.Create(Self);
      Item.Caption := qryReports.FieldByName('Name').AsString;
      Item.ReportID := qryReports.FieldByName('ID').AsString;
      Item.OnClick := pmnuReportsItemClick;
      pmnuReports.Items.Add(Item);
    end;

  finally
    qryReports.Close;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.ResetTheme(var Msg: TMessage);
// Применение цветов темы
var
  I: Integer;

begin
  Color := KhalaTheme.PanelFilterColor;
  pnlFilterArea.Color := KhalaTheme.PanelButtonsColor;
  splLeft.Color := KhalaTheme.PanelButtonsColor;
  splFilter.Color := KhalaTheme.PanelButtonsColor;
  splDetails.Color := KhalaTheme.PanelButtonsColor;

  PostMessage(MasterForm.Handle, KH_RESET_THEME, 0, 0);
  for I := 0 to DetailsList.Count - 1 do
    PostMessage(DetailsList[I].Handle, KH_RESET_THEME, 0, 0);
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.SetPageID(const Value: TGuid);
begin
  if FPageID <> Value then
    FPageID := Value;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.SetPageID_AsString(const Value: String);
begin
  if GuidToString(FPageID) <> Value then
    FPageID := StringToGuid(Value);
end;

end.
