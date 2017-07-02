unit SQLBldr;

interface

uses
  Classes, SysUtils, DB, IBX.IBCustomDataSet, IBX.IBSQL;

type
  ERebuildQuery = class(Exception)
    constructor Create;
  end;

type
  PDataSet = ^TIBDataSet;

type
  TSQLBuilder = class(TObject)
  private
    FSelectPart: String; // select ... from ...
    FWherePart: String; // where ...
    FFilterPart: String; // тоже where
    FOrderPart: String; // order by ...
    FSortPart: String; // asc/desc
    FOffsetPart: Integer; // rows ... to ...
    FDataSet: PDataSet; // Датасет на фрейме-владельце. Надо бы через pointer с ним работать, наверное
    FsqlRowCount: TIBSQL; // Местный датасет для получения кол-ва строк
    FRowCount: Integer; // Кол-во строк, возвращаемых запросом
    procedure ExecuteQuery(QueryText: String);
    procedure CalcRowCount(QueryText: String);
    function GetDataSet: PDataSet;
    function GetSelectPart: String;
    function GetWherePart: String;
    function GetOrderPart: String;
    function GetSortPart: String;
    function GetOffsetPart: Integer;
    procedure SetDataSet(const Value: PDataSet);
    procedure SetSelectPart(const Value: String);
    procedure SetWherePart(const Value: String);
    procedure SetOrderPart(const Value: String);
    procedure SetSortPart(const Value: String);
    procedure SetOffsetPart(const Value: Integer);
    function GetFilterPart: String;
    procedure SetFilterPart(const Value: String);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    function BuildQuery(NeedExecute: Boolean = True): String;
    function GetSQLQuery: String;
    property DataSet: PDataSet read GetDataSet write SetDataSet;
    property SelectPart: String read GetSelectPart write SetSelectPart;
    property WherePart: String read GetWherePart write SetWherePart;
    property FilterPart: String read GetFilterPart write SetFilterPart;
    property OrderPart: String read GetOrderPart write SetOrderPart;
    property SortPart: String read GetSortPart write SetSortPart;
    property OffsetPart: Integer read GetOffsetPart write SetOffsetPart;
    property RowCount: Integer read FRowCount;
  end;

implementation

uses
  Kh_Consts;

//---------------------------------------------------------------------------
{ TSQLBuilder }

// Собираем текст SQL-запроса, возвращаем его, а при необходимости - еще и
// сразу запускаем
function TSQLBuilder.BuildQuery(NeedExecute: Boolean = True): String;
var
  WherePart, OrderPart, SortPart, OffsetPart: String;

begin
  // Условие Where набирается из непосредственно where и быстрого фильтра
  if FWherePart <> '' then
  begin
    WherePart := Format(' WHERE %s ', [FWherePart]);
    if FFilterPart <> '' then
      WherePart := WherePart + Format(' AND %s ', [FFilterPart]);
  end
  else
  begin
    if FFilterPart <> '' then
      WherePart := Format(' WHERE %s ', [FFilterPart])
    else
      WherePart := '';
  end;

  // Sort должен быть строго в присутствии OrderBy, поэтому включается в его состав.
  if (FSortPart = 'ASC') or (FSortPart = 'DESC') then
    SortPart := FSortPart
  else
    SortPart := '';

  if FOrderPart <> '' then
    OrderPart := Format(' ORDER BY %s %s ', [FOrderPart, SortPart])
  else
    OrderPart := '';

  if FOffsetPart > 0 then
    OffsetPart := Format(' ROWS %d TO %d ',
      [((FOffsetPart - 1) * RECS_ON_PAGE) + 1, FOffsetPart * RECS_ON_PAGE])
  else
    OffsetPart := Format(' ROWS %d TO %d ',
      [1, RECS_ON_PAGE]);

  Result := FSelectPart + WherePart + OrderPart + OffsetPart;

  try
    if NeedExecute and (FDataSet <> nil) then
    begin
      ExecuteQuery(Result);
      CalcRowCount(FSelectPart + WherePart);
    end;
  except
    on E: ERebuildQuery do
      if NeedExecute and (FDataSet <> nil) then
      begin
        ExecuteQuery(FSelectPart);
        CalcRowCount(FSelectPart);
      end;
  end;
end;

//---------------------------------------------------------------------------

// Вычисление полного количества строк, возвращаемых запросом
procedure TSQLBuilder.CalcRowCount(QueryText: String);
begin
  FRowCount := 0;

  if FsqlRowCount = nil then
    Exit;

  if FsqlRowCount.Open then
    FsqlRowCount.Close;

  try
    FsqlRowCount.SQL.Text := Format('SELECT Count(*) FROM(%s)', [QueryText]);
    FsqlRowCount.ExecQuery;
    FRowCount := FsqlRowCount.Fields[0].AsInteger;
  finally
    FsqlRowCount.Close;
  end;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.ExecuteQuery(QueryText: String);
begin
  if FDataSet^.Active then
    FDataSet^.Close;

  try
    FDataSet^.SelectSQL.Text := QueryText;
    FDataSet^.Open;
    FDataSet^.FetchAll;
  except
    raise ERebuildQuery.Create;
  end;
end;

//---------------------------------------------------------------------------
// Конструктор, деструктор
//---------------------------------------------------------------------------

constructor TSQLBuilder.Create(AOwner: TComponent);
begin
  inherited Create;

  FDataSet := nil;
  FsqlRowCount := TIBSQL.Create(AOwner);
end;

//---------------------------------------------------------------------------

destructor TSQLBuilder.Destroy;
begin
  FsqlRowCount.Free;
  FDataSet := nil;

  inherited;
end;

//---------------------------------------------------------------------------
// Геттеры-сеттеры свойств
//---------------------------------------------------------------------------

function TSQLBuilder.GetDataSet: PDataSet;
begin
  Result := FDataSet;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.GetFilterPart: String;
begin
  Result := FFilterPart;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.GetOffsetPart: Integer;
begin
  Result := FOffsetPart;
end;
      
//---------------------------------------------------------------------------

function TSQLBuilder.GetOrderPart: String;
begin
  Result := FOrderPart;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.GetSelectPart: String;
begin
  Result := FSelectPart;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.GetSortPart: String;
begin
  Result := FSortPart;
end;
   
//---------------------------------------------------------------------------

function TSQLBuilder.GetSQLQuery: String;
begin
  Result := BuildQuery;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.GetWherePart: String;
begin
  Result := FWherePart;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.SetDataSet(const Value: PDataSet);
begin
  if FDataSet <> Value then
  begin
    FDataSet := Value;
    FsqlRowCount.Database := Value^.Database;
    FsqlRowCount.Transaction := Value^.Transaction;
  end;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.SetFilterPart(const Value: String);
begin
  if FFilterPart <> Value then
    FFilterPart := Value;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.SetOffsetPart(const Value: Integer);
begin
  if FOffsetPart <> Value then
    FOffsetPart := Value;
end;
     
//---------------------------------------------------------------------------

procedure TSQLBuilder.SetOrderPart(const Value: String);
begin
  if FOrderPart <> Value then
    FOrderPart := Value;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.SetSelectPart(const Value: String);
begin
  if FSelectPart <> Value then
    FSelectPart := Value;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.SetSortPart(const Value: String);
begin
  if FSortPart <> Value then
    FSortPart := Value;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.SetWherePart(const Value: String);
begin
  if FWherePart <> Value then
    FWherePart := Value;
end;

//---------------------------------------------------------------------------

{ ERebuildQuery }

constructor ERebuildQuery.Create;
begin
  inherited Create('Rebuild query problem');
end;

end.
