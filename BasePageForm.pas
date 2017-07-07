unit BasePageForm;

interface

uses
  Winapi.Messages, Winapi.Windows,
  System.Classes,
  Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  BaseForm, Kh_Consts;

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
    //--
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pcDetailsChange(Sender: TObject);
  private
    { Private declarations }
    procedure ResetTheme(var Msg: TMessage); message KH_RESET_THEME;
  protected
    DetailsList: TList<TfrmBaseForm>;
    MasterForm: TfrmBaseForm;
    //--
    class function GetPage(AOwner: TComponent;
      AParent: TWinControl): TfrmBasePage; virtual;
  public
    { Public declarations }
    constructor ACreate(AOwner: TComponent; AParent: TWinControl);
    procedure MasterProc(ID: String);
    //--
    property Parent;
  end;

var
  frmBasePage: TfrmBasePage;

implementation

uses
  Vcl.Dialogs, Kh_Utils, UIThemes;

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

end.
