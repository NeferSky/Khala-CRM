unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  Generics.Collections,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.Menus,
  Registry,
  Data, UIThemes, Kh_Consts, BasePageForm;

type
  TfrmMain = class(TForm)
    pcRibbon: TPageControl;
    tsAdmin: TTabSheet;
    tsTasks: TTabSheet;
    tsPageAccounts: TTabSheet;
    TabSheet2: TTabSheet;
    ilRibbon: TImageList;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    mnuMain: TMainMenu;
    ilmnuMain: TImageList;
    mnuFile: TMenuItem;
    mnuSettings: TMenuItem;
    mnuTheme: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pcRibbonChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FUserID: String;
    PagesArr: Array of TfrmBasePage;
    procedure PrepareThemesMenu;
    procedure ReadIni;
    procedure WriteIni;
    procedure ResetTheme(var Msg: TMessage); message KH_RESET_THEME;
    procedure ThemeMenuClick(Sender: TObject);
  public
    { Public declarations }
    property UserID: String read FUserID;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Kh_Utils, PageAccounts, NsCipher;

{$R *.dfm}

//---------------------------------------------------------------------------

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SetLength(PagesArr, pcRibbon.PageCount);
  InitThemesManager;
  PrepareThemesMenu;
  ReadIni;

  pcRibbon.OnMouseEnter := TUtils.ControlMouseEnter;
  pcRibbon.OnMouseLeave := TUtils.ControlMouseLeave;

  Application.ProcessMessages;
 // pcRibbonChange(Sender);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  WriteIni;
  DeInitThemesManager;
end;

//---------------------------------------------------------------------------

// Применение цветов темы
procedure TfrmMain.FormShow(Sender: TObject);
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

// Заполнение пунктов меню тем оформления
procedure TfrmMain.PrepareThemesMenu;
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

// Применение цветов темы
procedure TfrmMain.ResetTheme(var Msg: TMessage);
var
  I: Integer;
begin
  Self.Color := KhalaTheme.PanelFilterColor;

  for I := 0 to pcRibbon.PageCount - 1 do
    if PagesArr[I] <> nil then
      PostMessage(PagesArr[I].Handle, KH_RESET_THEME, 0, 0);
end;

//---------------------------------------------------------------------------

// Выбор цветовой темы в меню
procedure TfrmMain.ThemeMenuClick(Sender: TObject);
begin
  ChooseTheme(mnuTheme.IndexOf((Sender as TMenuItem)));
  (Sender as TMenuItem).Checked := True;
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
