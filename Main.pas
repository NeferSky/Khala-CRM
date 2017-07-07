unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.ImageList,
  Generics.Collections,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ImgList, Vcl.ComCtrls, Vcl.Menus,
  Registry,
  Data, UIThemes, Kh_Consts, BasePageForm, FormLogon;

type
  TfrmMain = class(TForm)
    pcRibbon: TPageControl;
    tsAdmin: TTabSheet;
    tsTasks: TTabSheet;
    tsPageAccounts: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    sbStatus: TStatusBar;
    //--
    tmrTimer: TTimer;
    ilRibbon: TImageList;
    ilmnuMain: TImageList;
    //--
    mnuMain: TMainMenu;
    mnuFile: TMenuItem;
    mnuSettings: TMenuItem;
    mnuTheme: TMenuItem;
    //--
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pcRibbonChange(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusResize(Sender: TObject);
    procedure tmrTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FUserID: String;
    FUserName: String;
    PagesArr: Array of TfrmBasePage; // Массив, содержащий созданные страницы
    //--
    procedure PrepareThemesMenu;
    procedure ReadIni;
    procedure ResetTheme(var Msg: TMessage); message KH_RESET_THEME;
    procedure ShowStatusbarInfo;
    procedure ThemeMenuClick(Sender: TObject);
    procedure WriteIni;
  public
    { Public declarations }
    property UserID: String read FUserID;
    property UserName: String read FUserName;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Kh_Utils, PageAccounts, NsCipher;

{$R *.dfm}

{ TfrmMain }

//---------------------------------------------------------------------------

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SetLength(PagesArr, pcRibbon.PageCount);
  PrepareThemesMenu;
  ReadIni;

  pcRibbon.OnMouseEnter := TUtils.ControlMouseEnter;
  pcRibbon.OnMouseLeave := TUtils.ControlMouseLeave;

  ShowStatusbarInfo;
  pcRibbonChange(Sender);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  WriteIni;
  DeInitThemesManager;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.FormShow(Sender: TObject);
// Применение цветов темы
var
  Dummy: TMessage;
begin
  ResetTheme(Dummy);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.pcRibbonChange(Sender: TObject);
begin
  case pcRibbon.ActivePageIndex of
  2:
  begin
    PagesArr[pcRibbon.ActivePageIndex] := TfrmPageAccounts.GetPage(Self, pcRibbon.Pages[pcRibbon.ActivePageIndex]);
  end;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.PrepareThemesMenu;
// Заполнение пунктов меню тем оформления
var
  I: Integer;
  mnuItem: TMenuItem;
begin
  mnuTheme.Clear;
  for I := 0 to KhalaTheme.ThemesCount - 1 do
  begin
    mnuItem := TMenuItem.Create(Self);
    mnuItem.GroupIndex := 1;
    mnuItem.RadioItem := True;
    mnuItem.Caption := KhalaTheme[I].Caption;
    mnuItem.OnClick := ThemeMenuClick;
    mnuTheme.Add(mnuItem);
  end;
  mnuTheme.Items[KhalaTheme.ThemeID].Checked := True;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.ReadIni;
begin
  with TRegistry.Create do
  begin
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKeyReadOnly(S_REG_SETTINGS_KEY);
      if ValueExists('frmMainTop') then frmMain.Top := ReadInteger('frmMainTop');
      if ValueExists('frmMainLeft') then frmMain.Left := ReadInteger('frmMainLeft');
      if ValueExists('frmMainWidth') then frmMain.Width := ReadInteger('frmMainWidth');
      if ValueExists('frmMainHeight') then frmMain.Height := ReadInteger('frmMainHeight');
      if ValueExists('frmMainWindowState') then frmMain.WindowState := TWindowState(ReadInteger('frmMainWindowState'));
    finally
      CloseKey;
      Free;
    end;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.ResetTheme(var Msg: TMessage);
// Применение цветов темы
var
  I: Integer;
begin
  Self.Color := KhalaTheme.PanelFilterColor;

  for I := 0 to pcRibbon.PageCount - 1 do
    if PagesArr[I] <> nil then
      PostMessage(PagesArr[I].Handle, KH_RESET_THEME, 0, 0);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
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

procedure TfrmMain.sbStatusResize(Sender: TObject);
var
  NewWidth: Integer;
begin
  NewWidth := (sbStatus.Width - sbStatus.Panels[0].Width - sbStatus.Panels[3].Width - sbStatus.Panels[4].Width) div 2;
  sbStatus.Panels[1].Width := NewWidth;
  sbStatus.Panels[2].Width := NewWidth;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.ShowStatusbarInfo;
// Постоянная информация в статусбаре
begin
  sbStatus.Panels[1].Text := 'Пользователь: ' + FUserName;
  sbStatus.Panels[2].Text := 'Тут еще какая-нибудь фигня';
  sbStatus.Panels[3].Text := 'Дата: ' + DateToStr(Date);
  sbStatus.Panels[4].Text := 'Время: ' + FormatDateTime('t', Time);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.ThemeMenuClick(Sender: TObject);
// Выбор цветовой темы в меню
begin
  ChooseTheme(mnuTheme.IndexOf((Sender as TMenuItem)));
  (Sender as TMenuItem).Checked := True;
end;

//---------------------------------------------------------------------------

procedure TfrmMain.tmrTimerTimer(Sender: TObject);
// Время в статусбаре
begin
  sbStatus.Panels[4].Text := 'Время: ' + FormatDateTime('t', Time);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.WriteIni;
begin
  with TRegistry.Create do
  begin
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey(S_REG_SETTINGS_KEY, True);
      WriteInteger('frmMainTop', frmMain.Top);
      WriteInteger('frmMainLeft', frmMain.Left);
      WriteInteger('frmMainWidth', frmMain.Width);
      WriteInteger('frmMainHeight', frmMain.Height);
      WriteInteger('frmMainWindowState', Ord(frmMain.WindowState));
    finally
      CloseKey;
      Free;
    end;
  end;
end;

end.
