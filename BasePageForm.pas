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
  frxClass, frxDesgn, frxDBSet, frxFDComponents, frxExportXLS, frxExportXLSX,
  frxExportXML, frxExportCSV, Vcl.OleServer, ExcelXP, frxExportBIFF,
  Vcl.Graphics;

type
  TReportMenuItem = class(TMenuItem)
  private
    FReportID: TGuid;
  public
    property ReportID: TGuid read FReportID write FReportID;
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
    //--
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pcDetailsChange(Sender: TObject);
    procedure pmnuReportsItemClick(Sender: TObject);
    procedure lblActionsClick(Sender: TObject);
    procedure lblReportsClick(Sender: TObject);
    procedure frReportGetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    FPageID: TGuid; // ������������� �����
    //--
    procedure ReadActionsList;
    procedure ReadReportsList;
    procedure ResetTheme(var Msg: TMessage); message KH_RESET_THEME;
    function GetPageID: TGuid;
    function GetPageID_AsString: String;
    procedure SetPageID(const Value: TGuid);
    procedure SetPageID_AsString(const Value: String);
  protected
    MasterForm: TfrmBaseForm; // ������-����� � ������-���������
    DetailsList: TList<TfrmBaseForm>; // ���� ������������ ����
    FMasterID: TGuid; // ID �� ������-��������
    //--
    class function GetPage(AOwner: TComponent;
      AParent: TWinControl): TfrmBasePage; virtual;
  public
    { Public declarations }
    constructor ACreate(AOwner: TComponent; AParent: TWinControl; FormID: TGuid);
    procedure MasterProc(ID: TGuid);
    //--
    property Parent;
    property PageID: TGuid read GetPageID write SetPageID;
    property PageID_AsString: String read GetPageID_AsString write SetPageID_AsString;
  end;

implementation

uses
  Vcl.Dialogs, NsWinUtils, Kh_Utils, UIThemes, Data, ReportGen;

{$R *.dfm}

{ TfrmBasePage }
//---------------------------------------------------------------------------

constructor TfrmBasePage.ACreate(AOwner: TComponent; AParent: TWinControl;
  FormID: TGuid);
begin
  inherited Create(AOwner);
  FPageID := FormID;
  DetailsList := TList<TfrmBaseForm>.Create;
  Parent := AParent;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.FormCreate(Sender: TObject);
begin
  // ��������� ��������� ��� ��������� �������
  lblActions.OnMouseEnter := TUtils.ControlMouseEnter;
  lblActions.OnMouseLeave := TUtils.ControlMouseLeave;

  lblReports.OnMouseEnter := TUtils.ControlMouseEnter;
  lblReports.OnMouseLeave := TUtils.ControlMouseLeave;

  // ������ ������� �������� � ������� ��� ���� ��������
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

  for I := pmnuReports.Items.Count - 1 downto 0 do
    if pmnuReports.Items[I] <> nil then
      pmnuReports.Items[I].Free;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.FormShow(Sender: TObject);
// ���������� ������ ����
var
  Dummy: TMessage;
begin
  ResetTheme(Dummy);
end;

procedure TfrmBasePage.frReportGetValue(const VarName: string;
  var Value: Variant);
begin
  if VarName = 'AccountID' then Value := GuidToString(FMasterID);
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
// ����� ���� ��������
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
// ����� ���� �������
var
  P: TPoint;

begin
  P.X := (Sender as TLabel).Left;
  P.Y := (Sender as TLabel).Height + (Sender as TLabel).Top;

  P := ClientToScreen(P);
  pmnuReports.Popup(P.X, P.Y);
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.MasterProc(ID: TGuid);
// ���������� ������-��������� �������� ��� ������������ �� �������
var
  I: Integer;
  NeedUpdate: Boolean;
  SlaveExistsVoobscheOrNot: Boolean;

begin
  NeedUpdate := False;

  if ID = TGuid.Empty then
  begin
    for I := 0 to DetailsList.Count - 1 do
      DetailsList[I].Disconnect;
  end
  else
  begin
    // ��� �������� �������� ��� ������ ��� �� ���
    SlaveExistsVoobscheOrNot := (pcDetails.ActivePageIndex <= DetailsList.Count - 1)
      and (DetailsList[pcDetails.ActivePageIndex] <> nil);

    // ����� �� ������������� ������ �� �������� �������
    if SlaveExistsVoobscheOrNot then
      NeedUpdate := DetailsList[pcDetails.ActivePageIndex].MasterID <> ID;

    // ����� �������� - ����
    FMasterID := ID;
    for I := 0 to DetailsList.Count - 1 do
      DetailsList[I].MasterID := FMasterID;

    // �������������� �������� �� �������� �������, ���� �����
    if SlaveExistsVoobscheOrNot and NeedUpdate then
      DetailsList[pcDetails.ActivePageIndex].RebuildQuery;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.pcDetailsChange(Sender: TObject);
// ���������� ��������� �� ��������, ����� ���, ��� ������� ������ (��� ��������,
// ����� �� ������������� �� 5-10 ��������� �� ���� ����������� �� �������)
var
  I: Integer;

begin
  for I := 0 to DetailsList.Count - 1 do
    DetailsList[I].Disconnect;

  DetailsList.Items[pcDetails.ActivePageIndex].Connect;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.pmnuReportsItemClick(Sender: TObject);
// ������ ������ �� ���� �������
begin
  dmReportGenerator.Run((Sender as TReportMenuItem).ReportID);
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.ReadActionsList;
// ������ � ������������ ������ ��������
var
  Item: TReportMenuItem;
  I: Integer;

begin
  for I := 0 to alActions.ActionCount - 1 do
  begin
    Item := TReportMenuItem.Create(Self);
    Item.Action := alActions.Actions[I];
    pmnuActions.Items.Add(Item);
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.ReadReportsList;
// ������ � ������������ ������ �������
const
  SQL_GET_REPORT_LIST = 'select * from dbo.App_GetReportList(:FormID)';

var
  Item: TReportMenuItem;

begin
  if qryReports.Active then
    qryReports.Close;

  try
    qryReports.SQL.Text := SQL_GET_REPORT_LIST;
    qryReports.ParamByName('FormID').AsGUID := (Self as TfrmBasePage).PageID;
    qryReports.Prepare;
    qryReports.Open;

    while not qryReports.Eof do
    begin
      Item := TReportMenuItem.Create(Self);
      Item.Caption := qryReports.FieldByName('Name').AsString;
      Item.ReportID := StringToGuid(qryReports.FieldByName('ID').AsString);
      Item.OnClick := pmnuReportsItemClick;
      pmnuReports.Items.Add(Item);
      qryReports.Next;
    end;

  finally
    qryReports.Close;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.ResetTheme(var Msg: TMessage);
// ���������� ������ ����
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
