object dmReportGenerator: TdmReportGenerator
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 738
  Top = 473
  Height = 337
  Width = 357
  object frOOXMLExport: TfrxXLSXExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ChunkSize = 0
    OpenAfterExport = True
    PictureType = gpPNG
    Left = 144
    Top = 128
  end
  object frBIFFExport: TfrxBIFFExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = True
    SingleSheet = True
    RowHeightScale = 1.000000000000000000
    ChunkSize = 0
    Inaccuracy = 10.000000000000000000
    FitPages = False
    Pictures = True
    ParallelPages = 0
    Left = 144
    Top = 72
  end
  object frFireDACSupport: TfrxFDComponents
    DefaultDatabase = dmData.FDConnection
    Left = 40
    Top = 72
  end
  object frReport: TfrxReport
    Version = '5.4.6'
    DataSet = frdsData
    DataSetName = 'sa'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42933.480998819450000000
    ReportOptions.LastChange = 42933.480998819450000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 16
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
    end
  end
  object qryReport: TFDQuery
    Connection = dmData.FDConnection
    Transaction = dmData.FDTransaction
    UpdateTransaction = trnReport
    Left = 40
    Top = 128
  end
  object trnReport: TFDTransaction
    Connection = dmData.FDConnection
    Left = 40
    Top = 184
  end
  object dlgOpenReport: TOpenDialog
    Filter = 'Fast Report Files|*.fr3|All Files|*.*'
    Left = 248
    Top = 16
  end
  object frdsData: TfrxDBDataset
    UserName = 'sa'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 144
    Top = 16
  end
end
