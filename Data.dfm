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
      'DriverID=FB'
      'Database=E:\Work\Firebird\KHALACRM.FDB'
      'Password=9225894'
      'User_Name=sysdba')
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
