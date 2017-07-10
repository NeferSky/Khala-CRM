inherited frmAccountContacts: TfrmAccountContacts
  Left = 338
  Top = 239
  Caption = 'frmAccountContacts'
  ExplicitLeft = 338
  ExplicitTop = 239
  ExplicitWidth = 695
  ExplicitHeight = 468
  PixelsPerInch = 96
  TextHeight = 13
  inherited frData: TfrxReport
    Datasets = <>
    Variables = <>
    Style = <>
  end
  inherited fdData: TFDQuery
    SQL.Strings = (
      'SELECT * FROM ACCOUNT_CONTACT_SEL(:MASTER_ID)')
    ParamData = <
      item
        Name = 'MASTER_ID'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 36
      end>
    object fdDataID: TStringField
      FieldName = 'ID'
      Origin = 'ID'
      Visible = False
      FixedChar = True
      Size = 36
    end
    object fdDataCONTACT_NAME: TStringField
      DisplayLabel = #1048#1084#1103
      FieldName = 'CONTACT_NAME'
      Origin = 'CONTACT_NAME'
      Size = 250
    end
    object fdDataJOB_TITLE: TStringField
      DisplayLabel = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      FieldName = 'JOB_TITLE'
      Origin = 'JOB_TITLE'
      Size = 250
    end
    object fdDataJOB_NAME: TStringField
      DisplayLabel = #1044#1086#1083#1078#1085#1086#1089#1090#1100' 2'
      FieldName = 'JOB_NAME'
      Origin = 'JOB_NAME'
      Size = 250
    end
    object fdDataCOMM_TYPE1: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 1'
      FieldName = 'COMM_TYPE1'
      Origin = 'COMM_TYPE1'
      Size = 250
    end
    object fdDataCOMM1: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 1'
      FieldName = 'COMM1'
      Origin = 'COMM1'
      Size = 250
    end
    object fdDataCOMM_TYPE2: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 2'
      FieldName = 'COMM_TYPE2'
      Origin = 'COMM_TYPE2'
      Size = 250
    end
    object fdDataCOMM2: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 2'
      FieldName = 'COMM2'
      Origin = 'COMM2'
      Size = 250
    end
    object fdDataCOMM_TYPE3: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 3'
      FieldName = 'COMM_TYPE3'
      Origin = 'COMM_TYPE3'
      Size = 250
    end
    object fdDataCOMM3: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 3'
      FieldName = 'COMM3'
      Origin = 'COMM3'
      Size = 250
    end
    object fdDataCOMM_TYPE4: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 4'
      FieldName = 'COMM_TYPE4'
      Origin = 'COMM_TYPE4'
      Size = 250
    end
    object fdDataCOMM4: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 4'
      FieldName = 'COMM4'
      Origin = 'COMM4'
      Size = 250
    end
    object fdDataCOMM_TYPE5: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 5'
      FieldName = 'COMM_TYPE5'
      Origin = 'COMM_TYPE5'
      Size = 250
    end
    object fdDataCOMM5: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 5'
      FieldName = 'COMM5'
      Origin = 'COMM5'
      Size = 250
    end
    object fdDataCOMM_TYPE6: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 6'
      FieldName = 'COMM_TYPE6'
      Origin = 'COMM_TYPE6'
      Size = 250
    end
    object fdDataCOMM6: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 6'
      FieldName = 'COMM6'
      Origin = 'COMM6'
      Size = 250
    end
  end
end
