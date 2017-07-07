unit Data;

interface

{ $DEFINE MAKE_PARAMS}

uses
  System.SysUtils, System.Classes,
  Vcl.Dialogs,
  Data.DB,
  IBX.IBDatabase, IBX.IBDatabaseInfo,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Comp.Client;

type
  TdmData = class(TDataModule)
    FDConnection: TFDConnection;
    FDTransaction: TFDTransaction;
    //--
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FConfigPath: String;
    //--
    procedure ReadParams;
    procedure WriteParams;
  public
    { Public declarations }
  end;

var
  dmData: TdmData;

implementation

uses
  System.IniFiles,
  NsCipher, NsWinUtils, NsConvertUtils, Kh_Utils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmData }
//---------------------------------------------------------------------------

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  FConfigPath := GetAppPath + '\DBParams.cfg';
  {$IFNDEF MAKE_PARAMS}
  ReadParams;
  {$ENDIF}
  FDConnection.Open;
end;

//---------------------------------------------------------------------------

procedure TdmData.DataModuleDestroy(Sender: TObject);
begin
  FDConnection.Close;
  {$IFDEF MAKE_PARAMS}
  WriteParams;
  {$ENDIF}
end;

//---------------------------------------------------------------------------

procedure TdmData.ReadParams;
var
  Ini: TIniFile;
  Params: String;

begin
  Ini := TIniFile.Create(FConfigPath);
  try
    if Ini.SectionExists('Database') then
      Params := Ini.ReadString('Database', 'ConnectionString', '')
  finally
    Ini.Free;
  end;

  FDConnection.Params.Text := TXEBICipher.Crypt(HexToStr(Params), TUtils.Smile);
end;

//---------------------------------------------------------------------------

procedure TdmData.WriteParams;
var
  Ini: TIniFile;
  Params: String;

begin
  Params := StrToHex(TXEBICipher.Crypt(FDConnection.Params.Text, TUtils.Smile));

  Ini := TIniFile.Create(FConfigPath);
  try
    Ini.WriteString('Database', 'ConnectionString', Params);
  finally
    Ini.Free;
  end;
end;

end.
