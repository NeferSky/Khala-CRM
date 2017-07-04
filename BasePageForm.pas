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
    splLeft: TSplitter;
    pnlLeft: TPanel;
    splFilter: TSplitter;
    pnlFilterArea: TPanel;
    pnlActions: TPanel;
    lblActions: TLabel;
    lblReports: TLabel;
    pnlWorkArea: TPanel;
    splDetails: TSplitter;
    pcDetails: TPageControl;
    pcMaster: TPageControl;
    //--
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pcDetailsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

class function TfrmBasePage.GetPage(AOwner: TComponent;
  AParent: TWinControl): TfrmBasePage;
begin
  // virtual;
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
begin
  DetailsList.Free;
end;

//---------------------------------------------------------------------------

// Применение цветов темы
procedure TfrmBasePage.FormShow(Sender: TObject);
var
  Dummy: TMessage;
begin
  ResetTheme(Dummy);
end;

//---------------------------------------------------------------------------

// Вызывается мастер-датасетом страницы при передвижении по записям
procedure TfrmBasePage.MasterProc(ID: String);
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

// Отключение датасетов на вкладках, кроме той, что открыта сейчас (для экономии,
// чтобы не передергивать по 5-10 датасетов на одно перемещение по строкам)
procedure TfrmBasePage.pcDetailsChange(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DetailsList.Count - 1 do
    DetailsList[I].Disconnect;

  DetailsList.Items[pcDetails.ActivePageIndex].Connect;
end;

//---------------------------------------------------------------------------

// Применение цветов темы
procedure TfrmBasePage.ResetTheme(var Msg: TMessage);
var
  I: Integer;
begin
  Color := KhalaTheme.PanelFilterColor;
  pnlFilterArea.Color := KhalaTheme.PanelButtonsColor;

  PostMessage(MasterForm.Handle, KH_RESET_THEME, 0, 0);
  for I := 0 to DetailsList.Count - 1 do
    PostMessage(DetailsList[I].Handle, KH_RESET_THEME, 0, 0);
end;

end.
