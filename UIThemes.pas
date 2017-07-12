unit UIThemes;

interface

uses
  Kh_Consts, Vcl.Graphics, Vcl.Controls;

type
  TUITheme = record
    Name: String;
    Caption: String;
    GridGradientStartColor: TColor;
    GridGradientEndColor: TColor;
    PanelFilterColor: TColor;
    PanelButtonsColor: TColor;
    SelectedRowColor: TColor;
    FontColor: TColor;
  end;

const
  // Colors
  CL_TEXT: TColor = $00000000;
  CL_GRAY: TColor = $00EFEFEF;
  CL_GRID_TITLE: TColor = $004F4F4F;

  ThemesArray: Array[0..8] of TUITheme =
  (
    (
      Name: 'STANDART';
      Caption: 'Стандарт';
      GridGradientStartColor: clBtnFace;
      GridGradientEndColor: clBtnFace;
      PanelFilterColor: clBtnFace;
      PanelButtonsColor: clBtnFace;
      SelectedRowColor: clHighlight;
      FontColor: clWindowText;
      ),
    (
      Name: 'WINTER';
      Caption: 'Зима';
      GridGradientStartColor: $00F2E4D7;
      GridGradientEndColor: $00EAD1B9;
      PanelFilterColor: $00F0CAA6;
      PanelButtonsColor: $00D1B499;
      SelectedRowColor: $00B3DAFF;
      FontColor: $000083FF
      ),
    (
      Name: 'SUMMER';
      Caption: 'Лето';
      GridGradientStartColor: $00D7F2E4;
      GridGradientEndColor: $00B9EAD1;
      PanelFilterColor: $00A6F0CA;
      PanelButtonsColor: $0099D1B4;
      SelectedRowColor: $00B3DAFF;
      FontColor: $000083FF
      ),
    (
      Name: 'ROSE';
      Caption: 'Роза';
      GridGradientStartColor: $00E4D7F2;
      GridGradientEndColor: $00D1B9EA;
      PanelFilterColor: $00CAA6F0;
      PanelButtonsColor: $00B499D1;
      SelectedRowColor: $00FFE8CC;
      FontColor: $00E8A200
      ),
    (
      Name: 'VIOLET';
      Caption: 'Фиалка';
      GridGradientStartColor: $00F2D7E4;
      GridGradientEndColor: $00EAB9D1;
      PanelFilterColor: $00F0A6CA;
      PanelButtonsColor: $00D199B4;
      SelectedRowColor: $00B3DAFF;
      FontColor: $000083FF
      ),
    (
      Name: 'DESERT';
      Caption: 'Пустыня';
      GridGradientStartColor: $00D7E4F2;
      GridGradientEndColor: $00B9D1EA;
      PanelFilterColor: $00A6CAF0;
      PanelButtonsColor: $0099B4D1;
      SelectedRowColor: $00FFE8CC;
      FontColor: $00E8A200
      ),
    (
      Name: 'OCEAN';
      Caption: 'Океан';
      GridGradientStartColor: $00E4F2D7;
      GridGradientEndColor: $00D1EAB9;
      PanelFilterColor: $00CAF0A6;
      PanelButtonsColor: $00B4D199;
      SelectedRowColor: $00B3DAFF;
      FontColor: $000083FF
      ),
    (
      Name: 'SUNDAY';
      Caption: 'Солнечно';
      GridGradientStartColor: $00BCFFFF;
      GridGradientEndColor: $0000E6E6;
      PanelFilterColor: $00B4FFFF;
      PanelButtonsColor: $0000D2D2;
      SelectedRowColor: $00FFE8CC;
      FontColor: $00E8A200
    ),
    (
      Name: 'GLOOMILY';
      Caption: 'Мрачно';
      GridGradientStartColor: $00AAAAAA;
      GridGradientEndColor: $00969696;
      PanelFilterColor: $00C3C3C3;
      PanelButtonsColor: $007F7F7F;
      SelectedRowColor: $00B3DAFF;
      FontColor: $000083FF
    )
  );

type
  TKhalaTheme = class(TObject)
  private
    FThemeID: Integer;
    FName: String;
    FCaption: String;
    FGridGradientStartColor: TColor;
    FGridGradientEndColor: TColor;
    FPanelFilterColor: TColor;
    FPanelButtonsColor: TColor;
    FSelectedRowColor: TColor;
    FSelectedRowFontColor: TColor;
    FFontColor: TColor;
    //--
    function GetThemes(Index: Integer): TUITheme;
    function GetThemesCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetTheme(ThemeID: Integer);
    //--
    property ThemeID: Integer read FThemeID;
    property Name: String read FName;
    property Caption: String read FCaption;
    property GridGradientStartColor: TColor read FGridGradientStartColor;
    property GridGradientEndColor: TColor read FGridGradientEndColor;
    property PanelFilterColor: TColor read FPanelFilterColor;
    property PanelButtonsColor: TColor read FPanelButtonsColor;
    property SelectedRowColor: TColor read FSelectedRowColor;
    property SelectedRowFontColor: TColor read FSelectedRowFontColor;
    property FontColor: TColor read FFontColor;
    property ThemesCount: Integer read GetThemesCount;
    property Themes[Index: Integer]: TUITheme read GetThemes; default;
  end;

procedure ChooseTheme(ThemeID: Integer);
procedure DeInitThemesManager;
procedure InitThemesManager;

var
  KhalaTheme: TKhalaTheme;

implementation

uses
  Winapi.Windows, Registry, Main;

//---------------------------------------------------------------------------

procedure ChooseTheme(ThemeID: Integer);
begin
  if KhalaTheme = nil then
    KhalaTheme := TKhalaTheme.Create;
  KhalaTheme.SetTheme(ThemeID);
end;

//---------------------------------------------------------------------------

procedure DeInitThemesManager;
begin
  KhalaTheme.Destroy;
end;

//---------------------------------------------------------------------------

procedure InitThemesManager;
begin
  if KhalaTheme = nil then
    KhalaTheme := TKhalaTheme.Create;
end;


{ TKhalaTheme }
//---------------------------------------------------------------------------

function TKhalaTheme.GetThemes(Index: Integer): TUITheme;
begin
  Result := ThemesArray[Index];
end;

//---------------------------------------------------------------------------

function TKhalaTheme.GetThemesCount: Integer;
begin
  Result := Length(ThemesArray);
end;

//---------------------------------------------------------------------------

constructor TKhalaTheme.Create;
begin
  inherited Create;

  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    OpenKeyReadOnly(S_REG_SETTINGS_KEY);

    if ValueExists('ThemeID') then
      SetTheme(ReadInteger('ThemeID'))
    else
      SetTheme(1);

    CloseKey;
    Free;
  end;
end;

//---------------------------------------------------------------------------

destructor TKhalaTheme.Destroy;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    OpenKey(S_REG_SETTINGS_KEY, True);
    WriteInteger('ThemeID', FThemeID);
    CloseKey;
    Free;
  end;

  inherited Destroy;
end;

//---------------------------------------------------------------------------

procedure TKhalaTheme.SetTheme(ThemeID: Integer);
begin
  try
    FThemeID := ThemeID;
    FName := ThemesArray[ThemeID].Name;
    FCaption := ThemesArray[ThemeID].Caption;
    FGridGradientStartColor := ThemesArray[ThemeID].GridGradientStartColor;
    FGridGradientEndColor := ThemesArray[ThemeID].GridGradientEndColor;
    FPanelFilterColor := ThemesArray[ThemeID].PanelFilterColor;
    FPanelButtonsColor := ThemesArray[ThemeID].PanelButtonsColor;
    FSelectedRowColor := ThemesArray[ThemeID].SelectedRowColor;
    FFontColor := ThemesArray[ThemeID].FontColor;
  except
    ThemeID := 0;
    FThemeID := ThemeID;
    FName := 'N/A';
    FCaption := 'N/A';
    FGridGradientStartColor := clBtnFace;
    FGridGradientEndColor := clBtnFace;
    FPanelFilterColor := clBtnFace;
    FPanelButtonsColor := clBtnFace;
    FSelectedRowColor := clHighlight;
    FFontColor := clWindowText;
  end;

  if frmMain <> nil then
    PostMessage(frmMain.Handle, KH_RESET_THEME, 0, 0);
end;

end.
