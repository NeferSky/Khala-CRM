unit fd_Const;

interface

uses
  System.Classes, System.SysUtils;

var
  DriverList: TStringList;

procedure CreateDriverList;
procedure FreeDriverList;

implementation

// Native

procedure CreateDriverList;
begin
  DriverList := TStringList.Create;
  DriverList.Clear;
  DriverList.Add('FB');
  DriverList.Add('IB');
  DriverList.Add('IBLite');
  DriverList.Add('MSSQL');
  DriverList.Add('MySQL');
  DriverList.Add('PG');
  DriverList.Add('SQLite');
end;

procedure FreeDriverList;
begin
  DriverList.Clear;
  FreeAndNil(DriverList);
end;

initialization
  CreateDriverList;

finalization
  FreeDriverList;

end.
