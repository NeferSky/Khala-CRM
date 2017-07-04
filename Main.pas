unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  Registry,
  Data, UIThemes, Kh_Consts;

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
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pcRibbonChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    FUserID: String;
    procedure ReadIni;
    procedure WriteIni;
    procedure ResetTheme(var Msg: TMessage); message KH_RESET_THEME;
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

procedure TfrmMain.ComboBox1Change(Sender: TObject);
begin
  ChooseTheme(ComboBox1.ItemIndex);
end;

//---------------------------------------------------------------------------

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  InitThemesManager;
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

procedure TfrmMain.pcRibbonChange(Sender: TObject);
begin
  case pcRibbon.ActivePageIndex of
  2:
  begin
    TfrmPageAccounts.GetPage(Self, pcRibbon.Pages[pcRibbon.ActivePageIndex]);
  end;
  end;
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
begin
  Self.Color := KhalaTheme.PanelFilterColor;
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
