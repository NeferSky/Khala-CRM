object dmData: TdmData
  OldCreateOrder = False
  Left = 813
  Top = 308
  Height = 233
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
  object qryReport: TFDQuery
    Connection = connData
    Transaction = trnData
    SQL.Strings = (
      'select * from tbl_Rep'
      'where ID = :REPORTID')
    Left = 136
    Top = 24
    ParamData = <
      item
        Name = 'REPORTID'
        ParamType = ptInput
      end>
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 88
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select top 10 * from dbo.App_SelectAccounts()')
    Left = 160
    Top = 80
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'SERVER=TERRASOFT\MSSQLDEVELOPMENT'
      'User_Name=sa'
      'Password=123'
      'ApplicationName=Architect'
      'Workstation=TERRASOFT'
      'DATABASE=TSDevelopDB'
      'MARS=yes'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 144
  end
end
