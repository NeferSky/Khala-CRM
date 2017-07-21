unit Data;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Comp.Client, FireDAC.Phys.Infx, FireDAC.Phys.InfxDef,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.Phys.IBLiteDef, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TdmData = class(TDataModule)
    connData: TFDConnection;
    trnData: TFDTransaction;
    qryReport: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    FDConnection1: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function Connect: Boolean;
    procedure Disconnect;
    procedure SetParams(ServerName, DatabaseName, UserName, Password,
      DriverID: String);
    procedure Upload(ReportID: String; ReportStream: TMemoryStream);
  end;

const
  FB_STRING =
    'User_Name=%s' + #13#10 +
    'Password=%s' + #13#10 +
    'Database=%s' + #13#10 +
    'Server=%s' + #13#10 +
    'Protocol=TCPIP' + #13#10 +
    'Port=3050' + #13#10 +
    'CharacterSet=WIN1251' + #13#10 +
    'DriverID=%s';
  IB_STRING =
    'Database=%s' + #13#10 +
    'User_Name=%s' + #13#10 +
    'Password=%s' + #13#10 +
    'Protocol=TCPIP' + #13#10 +
    'Server=%s' + #13#10 +
    'Port=3050' + #13#10 +
    'CharacterSet=WIN1251' + #13#10 +
    'DriverID=%s';
  IBLITE_STRING =
    'Database=%s:%s' + #13#10 +
    'User_Name=%s' + #13#10 +
    'Password=%s' + #13#10 +
    'CharacterSet=WIN1251' + #13#10 +
    'DriverID=%s';
  MSSQL_STRING =
    'SERVER=%s' + #13#10 +
    'User_Name=%s' + #13#10 +
    'Password=%s' + #13#10 +
    'MARS=yes' + #13#10 +
    'DATABASE=%s' + #13#10 +
    'DriverID=%s';
  MYSQL_STRING =
    'Database=%s' + #13#10 +
    'User_Name=%s' + #13#10 +
    'Password=%s' + #13#10 +
    'Server=%s' + #13#10 +
    'CharacterSet=cp1251' + #13#10 +
    'DriverID=%s';
  PG_STRING =
    'Database=%s' + #13#10 +
    'User_Name=%s' + #13#10 +
    'Password=%s' + #13#10 +
    'Server=%s' + #13#10 +
    'CharacterSet=WIN1251' + #13#10 +
    'DriverID=%s';
  SQLITE_STRING =
    'Database=%s' + #13#10 +
    'User_Name=%s' + #13#10 +
    'Password=%s' + #13#10 +
    'DriverID=%s';

var
  dmData: TdmData;

implementation

uses
  fd_Const;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmData }
//---------------------------------------------------------------------------

function TdmData.Connect: Boolean;
begin
  Result := False;
  try
    connData.Open;
    Result := connData.Connected;
    FDQuery1.Open;
  except
    raise Exception.Create('Подключение не выполнено');
  end;
end;

//---------------------------------------------------------------------------

procedure TdmData.Disconnect;
begin
  connData.Close;
end;

//---------------------------------------------------------------------------

procedure TdmData.SetParams(ServerName, DatabaseName, UserName, Password,
  DriverID: String);
var
  DriverIndex: Integer;

begin
{
  First assign FDConnection.DriverName property, later FDConnection.Params.Text,
  which contains DriverID. Ex.:
    FDConnection.DriverName := DriverID;
    FDConnection.Params.Text := Format(MSSQL_STRING, [ServerName, UserName, Password, DatabaseName, DriverID]);
  Только так, и это FireDAC(c)
}
  connData.DriverName := DriverID;

  DriverIndex := DriverList.IndexOf(DriverID);

  case DriverIndex of
  0: connData.Params.Text := Format(FB_STRING, [UserName, Password, DatabaseName, ServerName, DriverID]);
  1: connData.Params.Text := Format(IB_STRING, [DatabaseName, UserName, Password, ServerName, DriverID]);
  2: connData.Params.Text := Format(IBLITE_STRING, [ServerName, DatabaseName, UserName, Password, DriverID]);
  3: connData.Params.Text := Format(MSSQL_STRING, [ServerName, UserName, Password, DatabaseName, DriverID]);
  4: connData.Params.Text := Format(MYSQL_STRING, [DatabaseName, UserName, Password, ServerName, DriverID]);
  5: connData.Params.Text := Format(PG_STRING, [DatabaseName, UserName, Password, ServerName, DriverID]);
  6: connData.Params.Text := Format(SQLITE_STRING, [ServerName, DatabaseName, UserName, Password, DriverID]);
  else
    connData.Params.Text := Format(MSSQL_STRING, [ServerName, UserName, Password, DatabaseName, DriverID]);
  end;
end;

//---------------------------------------------------------------------------

procedure TdmData.Upload(ReportID: String; ReportStream: TMemoryStream);
begin
  try
    qryReport.ParamByName('ReportID').AsGUID := StringToGUID(ReportID);
    qryReport.Open;

    if qryReport.RecordCount > 0 then
      qryReport.Edit
    else
    begin
      qryReport.Insert;
      qryReport.FieldByName('ID').AsString := ReportID;
    end;

    ReportStream.Position := 0;
    TBlobField(qryReport.FieldByName('ReportData')).LoadFromStream(ReportStream);
    qryReport.Post;

  finally
    qryReport.Close;
  end;
end;

end.
