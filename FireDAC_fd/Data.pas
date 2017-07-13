unit Data;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client,
  Data.DB;

type
  TdmData = class(TDataModule)
    connData: TFDConnection;
    trnData: TFDTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
    function Connect: Boolean;
    procedure Disconnect;
    procedure SetParams(ServerName, DatabaseName, UserName, Password,
      ServerType: String);
  end;

var
  dmData: TdmData;

implementation

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
  ServerType: String);
begin
//                                                                        // тута
end;

end.
