unit Data;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Dialogs,
  Data.DB, IBX.IBDatabase, IBX.IBDatabaseInfo;

type
  TdmData = class(TDataModule)
    IBDatabase: TIBDatabase;
    IBTransaction: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FConfigPath: String;
    procedure ReadParams;
    procedure WriteParams;
  public
    { Public declarations }
  end;

var
  dmData: TdmData;

implementation

uses
  IniFiles, NsCipher, NsWinUtils, NsConvertUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

//---------------------------------------------------------------------------

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  FConfigPath := GetAppPath + '\DBParams.cfg';
  FConfigPath := 'C:\DBParams.cfg';
  ReadParams;
  IBDatabase.Open;
end;

//---------------------------------------------------------------------------

procedure TdmData.DataModuleDestroy(Sender: TObject);
begin
  IBDatabase.Close;
  //WriteParams;
end;

//---------------------------------------------------------------------------

procedure TdmData.ReadParams;
var
  Ini: TIniFile;
  DatabaseName, ServerName, Params: String;
begin
  Ini := TIniFile.Create(FConfigPath);
  try
    if Ini.SectionExists('Database') then
    begin
      ServerName := Ini.ReadString('Database', 'ServerName', 'DefaultServerName');
      DatabaseName := Ini.ReadString('Database', 'DatabaseName', 'DefaultDatabaseName');
      Params := Ini.ReadString('Database', 'ConnectionString', '')
    end;
  finally
    Ini.Free;
  end;

  IBDatabase.DatabaseName := Format('%s:%s', [ServerName, DatabaseName]);
  IBDatabase.Params.Text := TXEBICipher.Crypt(HexToStr(Params), 'En taro Adun!');
end;

//---------------------------------------------------------------------------

procedure TdmData.WriteParams;
var
  Ini: TIniFile;
  DatabaseName, ServerName, Params: String;
begin
  Params := StrToHex(TXEBICipher.Crypt(IBDatabase.Params.Text, 'En taro Adun!'));
  ServerName := Copy(IBDatabase.DatabaseName, 1, Pos(':', IBDatabase.DatabaseName) - 1);
  DatabaseName := Copy(IBDatabase.DatabaseName, Pos(':', IBDatabase.DatabaseName) + 1, Length(IBDatabase.DatabaseName) - Pos(':', IBDatabase.DatabaseName));

  Ini := TIniFile.Create(FConfigPath);
  try
    Ini.WriteString('Database', 'ServerName', ServerName);
    Ini.WriteString('Database', 'DatabaseName', DatabaseName);
    Ini.WriteString('Database', 'ConnectionString', Params);
  finally
    Ini.Free;
  end;
end;

end.
