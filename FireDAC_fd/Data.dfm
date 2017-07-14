object dmData: TdmData
  OldCreateOrder = False
  Left = 1849
  Top = 115
  Height = 213
  Width = 241
  object connData: TFDConnection
    Params.Strings = (
      'DriverID=MSSQL')
    LoginPrompt = False
    Transaction = trnData
    Left = 24
    Top = 24
  end
  object trnData: TFDTransaction
    Connection = connData
    Left = 80
    Top = 24
  end
end
