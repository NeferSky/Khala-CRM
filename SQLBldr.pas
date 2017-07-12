unit SQLBldr;

interface

uses
  Classes, SysUtils, DB, FireDAC.Comp.Client, FireDAC.Stan.Intf;

type
  PDataSet = ^TFDQuery;

type
  TSQLBuilder = class(TObject)
  private
    FSelectPart: String; // select ... from ...
    FWherePart: String; // where ...
    FFilterPart: String; // тоже where
    FOrderPart: String; // order by ...
    FSortPart: String; // asc/desc
    FOffsetPart: Integer; // rows ... to ...
    FMasterID: String; // ID из мастер-датасета
    FDataSet: PDataSet; // Датасет на фрейме-владельце. Надо бы через pointer с ним работать, наверное
    FqryRowCount: TFDQuery; // Местный датасет для получения кол-ва строк
    FRowCount: Integer; // Кол-во строк, возвращаемых запросом
    FSQLRowCount: String; // Костыль для передачи в запрос подсчета строк
    function BuildForFirebird: String;
    function BuildForMSSQL: String;
    function BuildForMySQL: String;
    function BuildForPostgreSQL: String;
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
    function GetMasterID: String;
    procedure SetMasterID(const Value: String);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    function BuildQuery(NeedExecute: Boolean = True): String;
    function GetSQLQuery: String;
    property MasterID: String read GetMasterID write SetMasterID;
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

function TSQLBuilder.BuildForFirebird: String;
var
  AWherePart, AOrderPart, ASortPart, AOffsetPart: String;

begin
  // Условие Where набирается из непосредственно where и быстрого фильтра
  if FWherePart <> '' then
  begin
    AWherePart := Format(' WHERE %s ', [FWherePart]);
    if FFilterPart <> '' then
      AWherePart := AWherePart + Format(' AND %s ', [FFilterPart]);
  end
  else
  begin
    if FFilterPart <> '' then
      AWherePart := Format(' WHERE %s ', [FFilterPart])
    else
      AWherePart := '';
  end;

  // Sort должен быть строго в присутствии OrderBy, поэтому включается в его состав.
  if (FSortPart = 'ASC') or (FSortPart = 'DESC') then
    ASortPart := FSortPart
  else
    ASortPart := '';

  if FOrderPart <> '' then
    AOrderPart := Format(' ORDER BY %s %s ', [FOrderPart, ASortPart])
  else
    AOrderPart := '';

  if FOffsetPart > 0 then
    AOffsetPart := Format(' ROWS %d TO %d ',
      [((FOffsetPart - 1) * RECS_ON_PAGE) + 1, FOffsetPart * RECS_ON_PAGE])
  else
    AOffsetPart := Format(' ROWS %d TO %d ',
      [1, RECS_ON_PAGE]);

  Result := FSelectPart + AWherePart + AOrderPart + AOffsetPart;
  FSQLRowCount := FSelectPart + AWherePart;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.BuildForMSSQL: String;
var
  AWherePart, AOrderPart, ASortPart, AOffsetPart: String;

begin
  // Условие Where набирается из непосредственно where и быстрого фильтра
  if FWherePart <> '' then
  begin
    AWherePart := Format(' WHERE %s ', [FWherePart]);
    if FFilterPart <> '' then
      AWherePart := AWherePart + Format(' AND %s ', [FFilterPart]);
  end
  else
  begin
    if FFilterPart <> '' then
      AWherePart := Format(' WHERE %s ', [FFilterPart])
    else
      AWherePart := '';
  end;

  // Sort и Offset должны быть строго в присутствии OrderBy, поэтому включаются в его состав.
  if (FSortPart = 'ASC') or (FSortPart = 'DESC') then
    ASortPart := FSortPart
  else
    ASortPart := '';

  AOffsetPart := Format(' OFFSET %d ROWS FETCH NEXT %d ROWS ONLY ',
    [((FOffsetPart - 1) * RECS_ON_PAGE), RECS_ON_PAGE]);

  if FOrderPart <> '' then
    AOrderPart := Format(' ORDER BY %s %s %s ', [FOrderPart, ASortPart, AOffsetPart])
  else
    AOrderPart := '';

  Result := FSelectPart + AWherePart + AOrderPart;
  FSQLRowCount := FSelectPart + AWherePart;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.BuildForMySQL: String;
var
  AWherePart, AOrderPart, ASortPart, AOffsetPart: String;

begin
  // Условие Where набирается из непосредственно where и быстрого фильтра
  if FWherePart <> '' then
  begin
    AWherePart := Format(' WHERE %s ', [FWherePart]);
    if FFilterPart <> '' then
      AWherePart := AWherePart + Format(' AND %s ', [FFilterPart]);
  end
  else
  begin
    if FFilterPart <> '' then
      AWherePart := Format(' WHERE %s ', [FFilterPart])
    else
      AWherePart := '';
  end;

  // Sort должен быть строго в присутствии OrderBy, поэтому включается в его состав.
  if (FSortPart = 'ASC') or (FSortPart = 'DESC') then
    ASortPart := FSortPart
  else
    ASortPart := '';

  if FOrderPart <> '' then
    AOrderPart := Format(' ORDER BY %s %s ', [FOrderPart, ASortPart])
  else
    AOrderPart := '';

  AOffsetPart := Format(' LIMIT %d, %d ',
    [(FOffsetPart - 1) * RECS_ON_PAGE, RECS_ON_PAGE]);

  Result := FSelectPart + AWherePart + AOrderPart + AOffsetPart;
  FSQLRowCount := FSelectPart + AWherePart;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.BuildForPostgreSQL: String;
var
  AWherePart, AOrderPart, ASortPart, AOffsetPart: String;

begin
  // Условие Where набирается из непосредственно where и быстрого фильтра
  if FWherePart <> '' then
  begin
    AWherePart := Format(' WHERE %s ', [FWherePart]);
    if FFilterPart <> '' then
      AWherePart := AWherePart + Format(' AND %s ', [FFilterPart]);
  end
  else
  begin
    if FFilterPart <> '' then
      AWherePart := Format(' WHERE %s ', [FFilterPart])
    else
      AWherePart := '';
  end;

  // Sort должен быть строго в присутствии OrderBy, поэтому включается в его состав.
  if (FSortPart = 'ASC') or (FSortPart = 'DESC') then
    ASortPart := FSortPart
  else
    ASortPart := '';

  if FOrderPart <> '' then
    AOrderPart := Format(' ORDER BY %s %s ', [FOrderPart, ASortPart])
  else
    AOrderPart := '';

  AOffsetPart := Format(' LIMIT %d OFFSET %d ',
    [RECS_ON_PAGE, (FOffsetPart - 1) * RECS_ON_PAGE]);

  Result := FSelectPart + AWherePart + AOrderPart + AOffsetPart;
  FSQLRowCount := FSelectPart + AWherePart;
end;

//---------------------------------------------------------------------------

function TSQLBuilder.BuildQuery(NeedExecute: Boolean = True): String;
// Собираем текст SQL-запроса, возвращаем его, а при необходимости - еще и
// сразу запускаем
begin
  Result := BuildForMSSQL;

  try
    if NeedExecute and (FDataSet <> nil) then
    begin
      ExecuteQuery(Result);
      CalcRowCount(FSQLRowCount);
    end;

  except
    on E: ERebuildQueryError do
      if NeedExecute and (FDataSet <> nil) then
      begin
        ExecuteQuery(FSelectPart);
        CalcRowCount(FSelectPart);
      end;
  end;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.CalcRowCount(QueryText: String);
// Вычисление полного количества строк, возвращаемых запросом
begin
  FRowCount := 0;

  if FqryRowCount = nil then
    Exit;

  if FqryRowCount.Active then
    FqryRowCount.Close;

  try
    FqryRowCount.SQL.Text := Format('select Count(*) from(%s) a ', [QueryText]);

    if FqryRowCount.Params.Count > 0 then
    begin
      if FMasterID = '' then
        FMasterID := '{00000000-0000-0000-0000-000000000000}';

      // Смотрите все, это - костыль!
      // Непонятно почему, здесь жалуется, что
      // Parameter[MasterID] data type is unknown. Победить не удалось.
      // Удалось понять лишь то, что дело в самом FqryRowCount.
      // FDataSet^.ParamByName('MasterID').AsGUID := StringToGuid(FMasterID);
      FqryRowCount.SQL.Text := StringReplace(FqryRowCount.SQL.Text, ':MasterID', ''''+FMasterID+'''', []);
    end;

    FqryRowCount.Open;
    FRowCount := FqryRowCount.Fields[0].AsInteger;
  finally
    FqryRowCount.Close;
  end;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.ExecuteQuery(QueryText: String);
begin
  if FDataSet^.Active then
    FDataSet^.Close;

  try
    FDataSet^.SQL.Text := QueryText;

    if FDataSet^.Params.Count > 0 then
    begin
      // Если нет параметра от мастер-датасета, то либо этот датасет - мастер,
      // или форма в стадии создания. В обоих случаях в параметр можно пихать
      // все, что угодно.
      if FMasterID = '' then
        FMasterID := '{00000000-0000-0000-0000-000000000000}';

      FDataSet^.ParamByName('MasterID').AsGUID := StringToGuid(FMasterID);
    end;

    FDataSet^.Open;
    FDataSet^.FetchAll;
  except
    raise ERebuildQueryError.Create;
  end;
end;

//---------------------------------------------------------------------------

constructor TSQLBuilder.Create(AOwner: TComponent);
begin
  inherited Create;

  FDataSet := nil;
  FqryRowCount := TFDQuery.Create(AOwner);
end;

//---------------------------------------------------------------------------

destructor TSQLBuilder.Destroy;
begin
  FqryRowCount.Free;
  FDataSet := nil;

  inherited;
end;

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

function TSQLBuilder.GetMasterID: String;
begin
  Result := FMasterID;
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
    FqryRowCount.Connection := Value^.Connection;
    FqryRowCount.Transaction := Value^.Transaction;
  end;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.SetFilterPart(const Value: String);
begin
  if FFilterPart <> Value then
    FFilterPart := Value;
end;

//---------------------------------------------------------------------------

procedure TSQLBuilder.SetMasterID(const Value: String);
begin
  if FMasterID <> Value then
    FMasterID := Value;
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

end.
