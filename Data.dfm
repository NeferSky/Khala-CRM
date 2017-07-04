object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 1626
  Top = 374
  Height = 309
  Width = 302
  object IBDatabase: TIBDatabase
    DatabaseName = '127.0.0.1/3050:E:\Work\Firebird\KhalaCRM.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=9225894'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = IBTransaction
    ServerType = 'IBServer'
    Left = 32
    Top = 16
  end
  object IBTransaction: TIBTransaction
    DefaultDatabase = IBDatabase
    Left = 32
    Top = 72
  end
end
