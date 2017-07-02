inherited frmAccountContacts: TfrmAccountContacts
  Caption = 'frmAccountContacts'
  PixelsPerInch = 96
  TextHeight = 13
  inherited frData: TfrxReport
    Datasets = <>
    Variables = <>
    Style = <>
  end
  inherited dsData: TIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM ACCOUNT_CONTACT_SEL(:MASTER_ID) ')
    object dsDataID: TIBStringField
      FieldName = 'ID'
      Origin = '"ACCOUNT_CONTACT_SEL"."ID"'
      Visible = False
      Size = 38
    end
    object dsDataCONTACT_NAME: TIBStringField
      DisplayLabel = #1048#1084#1103
      FieldName = 'CONTACT_NAME'
      Origin = '"ACCOUNT_CONTACT_SEL"."CONTACT_NAME"'
      Size = 250
    end
    object dsDataJOB_TITLE: TIBStringField
      DisplayLabel = #1044#1086#1086#1083#1078#1085#1086#1089#1090#1100
      FieldName = 'JOB_TITLE'
      Origin = '"ACCOUNT_CONTACT_SEL"."JOB_TITLE"'
      Size = 250
    end
    object dsDataJOB_NAME: TIBStringField
      DisplayLabel = #1044#1086#1083#1078#1085#1086#1089#1090#1100'2'
      FieldName = 'JOB_NAME'
      Origin = '"ACCOUNT_CONTACT_SEL"."JOB_NAME"'
      Size = 250
    end
    object dsDataCOMM_TYPE1: TIBStringField
      DisplayLabel = #1058#1080#1087' '#1089#1088#1077#1076#1089#1090#1074#1072' '#1089#1074#1103#1079#1080' 1'
      FieldName = 'COMM_TYPE1'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM_TYPE1"'
      Size = 250
    end
    object dsDataCOMM1: TIBStringField
      DisplayLabel = #1057#1074#1103#1079#1100' 1'
      FieldName = 'COMM1'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM1"'
      Size = 250
    end
    object dsDataCOMM_TYPE2: TIBStringField
      DisplayLabel = #1058#1080#1087' '#1089#1088#1077#1076#1089#1090#1074#1072' '#1089#1074#1103#1079#1080' 2'
      FieldName = 'COMM_TYPE2'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM_TYPE2"'
      Size = 250
    end
    object dsDataCOMM2: TIBStringField
      DisplayLabel = #1057#1074#1103#1079#1100' 2'
      FieldName = 'COMM2'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM2"'
      Size = 250
    end
    object dsDataCOMM_TYPE3: TIBStringField
      DisplayLabel = #1058#1080#1087' '#1089#1088#1077#1076#1089#1090#1074#1072' '#1089#1074#1103#1079#1080' 3'
      FieldName = 'COMM_TYPE3'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM_TYPE3"'
      Size = 250
    end
    object dsDataCOMM3: TIBStringField
      DisplayLabel = #1057#1074#1103#1079#1100' 3'
      FieldName = 'COMM3'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM3"'
      Size = 250
    end
    object dsDataCOMM_TYPE4: TIBStringField
      DisplayLabel = #1058#1080#1087' '#1089#1088#1077#1076#1089#1090#1074#1072' '#1089#1074#1103#1079#1080' 4'
      FieldName = 'COMM_TYPE4'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM_TYPE4"'
      Size = 250
    end
    object dsDataCOMM4: TIBStringField
      DisplayLabel = #1057#1074#1103#1079#1100' 4'
      FieldName = 'COMM4'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM4"'
      Size = 250
    end
    object dsDataCOMM_TYPE5: TIBStringField
      DisplayLabel = #1058#1080#1087' '#1089#1088#1077#1076#1089#1090#1074#1072' '#1089#1074#1103#1079#1080' 5'
      FieldName = 'COMM_TYPE5'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM_TYPE5"'
      Size = 250
    end
    object dsDataCOMM5: TIBStringField
      DisplayLabel = #1057#1074#1103#1079#1100' 5'
      FieldName = 'COMM5'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM5"'
      Size = 250
    end
    object dsDataCOMM_TYPE6: TIBStringField
      DisplayLabel = #1058#1080#1087' '#1089#1088#1077#1076#1089#1090#1074#1072' '#1089#1074#1103#1079#1080' 6'
      FieldName = 'COMM_TYPE6'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM_TYPE6"'
      Size = 250
    end
    object dsDataCOMM6: TIBStringField
      DisplayLabel = #1057#1074#1103#1079#1100' 6'
      FieldName = 'COMM6'
      Origin = '"ACCOUNT_CONTACT_SEL"."COMM6"'
      Size = 250
    end
  end
end
