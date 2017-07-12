unit Kh_Consts;

interface

uses
  Messages, SysUtils;

type
  ERebuildQueryError = class(Exception)
    constructor Create;
  end;

  EPrepareReportError = class(Exception)
    constructor Create;
  end;

const
  // Digits
  RECS_ON_PAGE: Integer = 50;

  // Registry path
  S_REG_SETTINGS_KEY: String = 'Software\NeferSky\Khala';

  // Message
  KH_RESET_THEME = WM_USER + 123;

implementation

{ ERebuildQueryError }
//---------------------------------------------------------------------------

constructor ERebuildQueryError.Create;
begin
  inherited Create('Ошибка SQL при получении данных');
end;

{ EPrepareReportError }
//---------------------------------------------------------------------------

constructor EPrepareReportError.Create;
begin
  inherited Create('Ошибка при подготовке отчета');
end;

end.
