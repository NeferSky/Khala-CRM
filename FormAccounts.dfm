inherited frmAccounts: TfrmAccounts
  Left = 544
  Top = 352
  Caption = 'frmAccounts'
  ExplicitLeft = 544
  ExplicitTop = 352
  PixelsPerInch = 96
  TextHeight = 13
  inherited frData: TfrxReport
    Datasets = <>
    Variables = <>
    Style = <>
  end
  inherited dsData: TIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM ACCOUNT_SEL')
    object dsDataID: TIBStringField
      FieldName = 'ID'
      Origin = '"ACCOUNT_SEL"."ID"'
      Visible = False
      Size = 38
    end
    object dsDataACCOUNT_NAME: TIBStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'ACCOUNT_NAME'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_NAME"'
      Size = 250
    end
    object dsDataACCOUNT_TYPE_NAME: TIBStringField
      DisplayLabel = #1058#1080#1087
      FieldName = 'ACCOUNT_TYPE_NAME'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_TYPE_NAME"'
      Size = 250
    end
    object dsDataCONTACT_NAME: TIBStringField
      DisplayLabel = #1054#1089#1085#1086#1074#1085#1086#1081' '#1082#1086#1085#1090#1072#1082#1090
      FieldName = 'CONTACT_NAME'
      Origin = '"ACCOUNT_SEL"."CONTACT_NAME"'
      Size = 250
    end
    object dsDataOWNER_NAME: TIBStringField
      DisplayLabel = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081
      FieldName = 'OWNER_NAME'
      Origin = '"ACCOUNT_SEL"."OWNER_NAME"'
      Size = 250
    end
    object dsDataCREATOR_NAME: TIBStringField
      DisplayLabel = #1057#1086#1079#1076#1072#1083
      FieldName = 'CREATOR_NAME'
      Origin = '"ACCOUNT_SEL"."CREATOR_NAME"'
      Size = 250
    end
    object dsDataCREATED_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      FieldName = 'CREATED_DATE'
      Origin = '"ACCOUNT_SEL"."CREATED_DATE"'
    end
    object dsDataMODIFIER_NAME: TIBStringField
      DisplayLabel = #1048#1079#1084#1077#1085#1080#1083
      FieldName = 'MODIFIER_NAME'
      Origin = '"ACCOUNT_SEL"."MODIFIER_NAME"'
      Size = 250
    end
    object dsDataMODIFIED_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      FieldName = 'MODIFIED_DATE'
      Origin = '"ACCOUNT_SEL"."MODIFIED_DATE"'
    end
    object dsDataOFFICIAL_ACCOUNT_NAME: TIBStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
      DisplayWidth = 500
      FieldName = 'OFFICIAL_ACCOUNT_NAME'
      Origin = '"ACCOUNT_SEL"."OFFICIAL_ACCOUNT_NAME"'
      Size = 500
    end
    object dsDataCITY_NAME: TIBStringField
      DisplayLabel = #1043#1086#1088#1086#1076
      FieldName = 'CITY_NAME'
      Origin = '"ACCOUNT_SEL"."CITY_NAME"'
      Size = 250
    end
    object dsDataPOST_AUTONOM: TIBStringField
      DisplayLabel = #1060#1077#1076#1077#1088#1072#1083#1100#1085#1099#1081' '#1086#1082#1088#1091#1075
      FieldName = 'POST_AUTONOM'
      Origin = '"ACCOUNT_SEL"."POST_AUTONOM"'
      Size = 250
    end
    object dsDataACCOUNT_INN: TIBStringField
      DisplayLabel = #1048#1053#1053
      FieldName = 'ACCOUNT_INN'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_INN"'
      Size = 15
    end
    object dsDataACCOUNT_KPP: TIBStringField
      DisplayLabel = #1050#1055#1055
      FieldName = 'ACCOUNT_KPP'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_KPP"'
      Size = 15
    end
    object dsDataACCOUNT_CATEGORY_NAME: TIBStringField
      DisplayLabel = #1060#1086#1088#1084#1072' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
      FieldName = 'ACCOUNT_CATEGORY_NAME'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_CATEGORY_NAME"'
      Size = 250
    end
    object dsDataREGION_NAME: TIBStringField
      DisplayLabel = #1054#1073#1083#1072#1089#1090#1100
      FieldName = 'REGION_NAME'
      Origin = '"ACCOUNT_SEL"."REGION_NAME"'
      Size = 250
    end
    object dsDataACCOUNT_POST_ADDRESS: TIBStringField
      DisplayLabel = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089
      FieldName = 'ACCOUNT_POST_ADDRESS'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_POST_ADDRESS"'
      Size = 250
    end
    object dsDataACCOUNT_LEGAL_ADDRESS: TIBStringField
      DisplayLabel = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
      FieldName = 'ACCOUNT_LEGAL_ADDRESS'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_LEGAL_ADDRESS"'
      Size = 250
    end
    object dsDataACCOUNT_NOTE: TIBStringField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      FieldName = 'ACCOUNT_NOTE'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_NOTE"'
      Size = 4000
    end
    object dsDataACCOUNT_CALL_NOTE: TIBStringField
      DisplayLabel = #1052#1077#1090#1082#1072' '#1076#1083#1103' '#1086#1073#1079#1074#1086#1085#1072
      FieldName = 'ACCOUNT_CALL_NOTE'
      Origin = '"ACCOUNT_SEL"."ACCOUNT_CALL_NOTE"'
      Size = 250
    end
    object dsDataCLIENTS_VALUE_ID: TIBStringField
      DisplayLabel = #1042#1072#1078#1085#1086#1089#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
      FieldName = 'CLIENTS_VALUE_ID'
      Origin = '"ACCOUNT_SEL"."CLIENTS_VALUE_ID"'
      Size = 38
    end
    object dsDataTIME_DIFFERENCE: TIntegerField
      DisplayLabel = #1056#1072#1079#1085#1080#1094#1072' '#1074#1088#1077#1084#1077#1085#1080' '#1089' '#1052#1086#1089#1082#1074#1086#1081
      FieldName = 'TIME_DIFFERENCE'
      Origin = '"ACCOUNT_SEL"."TIME_DIFFERENCE"'
    end
  end
end
