unit ReportGen;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Dialogs,
  Data.DB,
  frxClass, frxFDComponents, frxExportBIFF, frxExportXLSX,
  FireDAC.Comp.DataSet, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data, frxDBSet;

type
  TdmReportGenerator = class(TDataModule)
    frOOXMLExport: TfrxXLSXExport;
    frBIFFExport: TfrxBIFFExport;
    frFireDACSupport: TfrxFDComponents;
    frReport: TfrxReport;
    qryReport: TFDQuery;
    trnReport: TFDTransaction;
    dlgOpenReport: TOpenDialog;
    frdsData: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FReportName: String; // Временное хранение имени отчета, т.к. оно нужно когда запрос уже закрыт
  public
    { Public declarations }
    procedure Run(ReportID: TGuid; const DataSet: TFDDataSet = nil);
    procedure RunPrint(ReportID: TGuid; const DataSet: TFDDataSet = nil);
    procedure RunExport(ReportID: TGuid; const DataSet: TFDDataSet = nil);
    function Download(ReportID: TGuid): Boolean;
    function Upload(ReportID: TGuid): Boolean;
    procedure Design(ReportID: TGuid);
  end;

var
  dmReportGenerator: TdmReportGenerator;

implementation

uses
  Kh_Consts, NsWinUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

//---------------------------------------------------------------------------

procedure TdmReportGenerator.DataModuleCreate(Sender: TObject);
begin
//
end;

//---------------------------------------------------------------------------

procedure TdmReportGenerator.DataModuleDestroy(Sender: TObject);
begin
//
end;

//---------------------------------------------------------------------------

procedure TdmReportGenerator.Design(ReportID: TGuid);
begin
  if Download(ReportID) then
    frReport.DesignReport;
end;

//---------------------------------------------------------------------------

function TdmReportGenerator.Download(ReportID: TGuid): Boolean;
const
  MSOFFICE2007 = 12.0;
  SQL_GET_REPORT = 'select * from dbo.App_GetReport(:ReportID)';

var
  ReportStream: TMemoryStream;
  ReportExists: Boolean;

begin
  Result := False;
  try
    if qryReport.Active then
      qryReport.Close;

    try
      qryReport.SQL.Text := SQL_GET_REPORT;
      qryReport.ParamByName('ReportID').AsGUID := ReportID;
      qryReport.Open;

      ReportExists := qryReport.RecordCount > 0;
      if ReportExists then
        try
          ReportStream := TMemoryStream.Create;
          TBlobField(qryReport.FieldByName('ReportData')).SaveToStream(ReportStream);
          if ReportStream.Size > 0 then
          begin
            ReportStream.Position := 0;
            frReport.LoadFromStream(ReportStream);
            FReportName := qryReport.FieldByName('Name').AsString;
            Result := True;
          end;
        finally
          ReportStream.Free;
        end;
    except
      raise EPrepareReportError.Create;
    end;
  finally
    qryReport.Close;
  end;
end;

//---------------------------------------------------------------------------

procedure TdmReportGenerator.Run(ReportID: TGuid; const DataSet: TFDDataSet = nil);
// Запуск отчета из меню отчетов
begin
  if Download(ReportID) then
  begin
    frdsData.DataSet := DataSet;

    frReport.PrepareReport;
    frReport.DesignReport;
    frReport.ShowReport;

    //frXLSExport.FileName := MakeFileName(Sender as TReportMenuItem);
    //frReport.Export(frXLSExport);
    // Такой экспорт не подходит, потому что после закрытия MSExcel не
    // выгружается из памяти. Поэтому используется типизированный фильтр
    // экспорта для BIFF.
    // BIFF - свой собственный бинарный формат файлов MSExcel 2003 и
    // старше, но поддерживается и младшими версиями. "Тот самый" XLS.
    // Фильтр экспорта для OfficeOpenXML на форме - для потомков. Моих,
    // в смысле. На то время, когда приспичит переехать на XLSX.
    frBIFFExport.FileName := Format('%sReport/%s.xls', [GetAppPath, FReportName]);
    frReport.Export(frBIFFExport);
  end;
end;

//---------------------------------------------------------------------------

procedure TdmReportGenerator.RunExport(ReportID: TGuid;
  const DataSet: TFDDataSet);
// Запуск экспорта в excel из грида
begin
  if Download(ReportID) then
  begin
    frdsData.DataSet := DataSet;

    frReport.PrepareReport;
    frBIFFExport.FileName := Format('%sReport/%s.xls', [GetAppPath, FReportName]);
    frReport.Export(frBIFFExport);
  end;
end;

//---------------------------------------------------------------------------

procedure TdmReportGenerator.RunPrint(ReportID: TGuid;
  const DataSet: TFDDataSet);
// Запуск печати из грида
begin
  if Download(ReportID) then
  begin
    frdsData.DataSet := DataSet;

    frReport.PrepareReport;
    frReport.ShowReport;
  end;
end;

//---------------------------------------------------------------------------

function TdmReportGenerator.Upload(ReportID: TGuid): Boolean;
var
  ReportStream: TMemoryStream;

begin
  Result := False;
  if dlgOpenReport.Execute then
  begin
    ReportStream := TMemoryStream.Create;
    ReportStream.LoadFromFile(dlgOpenReport.FileName);
    try
      qryReport.ParamByName('ReportID').AsGUID := ReportID;
      qryReport.Open;

      if qryReport.RecordCount > 0 then
        qryReport.Edit
      else
      begin
        qryReport.Insert;
        qryReport.FieldByName('ID').AsString := GUIDToString(ReportID);
      end;

      ReportStream.Position := 0;
      TBlobField(qryReport.FieldByName('ReportData')).LoadFromStream(ReportStream);
      qryReport.Post;
      Result := True;
    finally
      qryReport.Close;
    end;
  end;
end;

end.
