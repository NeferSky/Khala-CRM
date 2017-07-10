object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 898
  Top = 374
  Height = 309
  Width = 302
  object FDConnection: TFDConnection
    Params.Strings = (
      'DATABASE=TSDevelopDB'
      'Password=123'
      'User_Name=sa'
      'SERVER=TERRASOFT\MSSQLDEVELOPMENT'
      'ApplicationName=Architect'
      'Workstation=TERRASOFT'
      'MARS=yes'
      'DriverID=MSSQL')
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 24
    Top = 24
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 24
    Top = 80
  end
end
