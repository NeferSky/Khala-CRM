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

  ThemesArray: Array[0..5] of TUITheme =
  (
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
      )
  );

type
  TKhalaTheme = class
  private
    FThemeID: Integer;
    FName: String;
    FCaption: String;
    FGridGradientStartColor: TColor;
    FGridGradientEndColor: TColor;
    FPanelFilterColor: TColor;
    FPanelButtonsColor: TColor;
    FSelectedRowColor: TColor;
    FFontColor: TColor;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetTheme(ThemeID: Integer);
    property Name: String read FName;
    property Caption: String read FCaption;
    property GridGradientStartColor: TColor read FGridGradientStartColor;
    property GridGradientEndColor: TColor read FGridGradientEndColor;
    property PanelFilterColor: TColor read FPanelFilterColor;
    property PanelButtonsColor: TColor read FPanelButtonsColor;
    property SelectedRowColor: TColor read FSelectedRowColor;
    property FontColor: TColor read FFontColor;
  end;

procedure InitThemesManager;
procedure DeInitThemesManager;
procedure ChooseTheme(ThemeID: Integer);

var
  KhalaTheme: TKhalaTheme;

implementation

uses
  Windows, Registry;

procedure InitThemesManager;
begin
  if KhalaTheme = nil then
    KhalaTheme := TKhalaTheme.Create;
end;

procedure DeInitThemesManager;
begin
  KhalaTheme.Destroy;
end;

procedure ChooseTheme(ThemeID: Integer);
begin
  if KhalaTheme = nil then
    KhalaTheme := TKhalaTheme.Create;
  KhalaTheme.SetTheme(ThemeID);
end;

{ TKhalaTheme }

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

  PostMessage(0, KH_RESET_THEME, 0, 0);
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

end.
