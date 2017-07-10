inherited frmAccounts: TfrmAccounts
  Left = 544
  Top = 352
  Caption = 'frmAccounts'
  ExplicitLeft = 544
  ExplicitTop = 352
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
      'SELECT * FROM ACCOUNT_SEL ')
    object fdDataID: TStringField
      FieldName = 'ID'
      Origin = 'ID'
      Visible = False
      FixedChar = True
      Size = 36
    end
    object fdDataACCOUNT_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'ACCOUNT_NAME'
      Origin = 'ACCOUNT_NAME'
      Size = 250
    end
    object fdDataACCOUNT_TYPE_NAME: TStringField
      DisplayLabel = #1058#1080#1087
      FieldName = 'ACCOUNT_TYPE_NAME'
      Origin = 'ACCOUNT_TYPE_NAME'
      Size = 250
    end
    object fdDataCONTACT_NAME: TStringField
      DisplayLabel = #1054#1089#1085#1086#1074#1085#1086#1081' '#1082#1086#1085#1090#1072#1082#1090
      FieldName = 'CONTACT_NAME'
      Origin = 'CONTACT_NAME'
      Size = 250
    end
    object fdDataOWNER_NAME: TStringField
      DisplayLabel = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081
      FieldName = 'OWNER_NAME'
      Origin = 'OWNER_NAME'
      Size = 250
    end
    object fdDataCREATOR_NAME: TStringField
      DisplayLabel = #1057#1086#1079#1076#1072#1083
      FieldName = 'CREATOR_NAME'
      Origin = 'CREATOR_NAME'
      Size = 250
    end
    object fdDataCREATED_DATE: TSQLTimeStampField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      FieldName = 'CREATED_DATE'
      Origin = 'CREATED_DATE'
    end
    object fdDataMODIFIER_NAME: TStringField
      DisplayLabel = #1048#1079#1084#1077#1085#1080#1083
      FieldName = 'MODIFIER_NAME'
      Origin = 'MODIFIER_NAME'
      Size = 250
    end
    object fdDataMODIFIED_DATE: TSQLTimeStampField
      DisplayLabel = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      FieldName = 'MODIFIED_DATE'
      Origin = 'MODIFIED_DATE'
    end
    object fdDataOFFICIAL_ACCOUNT_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'OFFICIAL_ACCOUNT_NAME'
      Origin = 'OFFICIAL_ACCOUNT_NAME'
      Size = 500
    end
    object fdDataCITY_NAME: TStringField
      DisplayLabel = #1043#1086#1088#1086#1076
      FieldName = 'CITY_NAME'
      Origin = 'CITY_NAME'
      Size = 250
    end
    object fdDataPOST_AUTONOM: TStringField
      DisplayLabel = #1060#1077#1076#1077#1088#1072#1083#1100#1085#1099#1081' '#1086#1082#1088#1091#1075
      FieldName = 'POST_AUTONOM'
      Origin = 'POST_AUTONOM'
      Size = 250
    end
    object fdDataACCOUNT_INN: TStringField
      DisplayLabel = #1048#1053#1053
      FieldName = 'ACCOUNT_INN'
      Origin = 'ACCOUNT_INN'
      Size = 50
    end
    object fdDataACCOUNT_KPP: TStringField
      DisplayLabel = #1050#1055#1055
      FieldName = 'ACCOUNT_KPP'
      Origin = 'ACCOUNT_KPP'
      Size = 50
    end
    object fdDataACCOUNT_CATEGORY_NAME: TStringField
      DisplayLabel = #1060#1086#1088#1084#1072' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
      FieldName = 'ACCOUNT_CATEGORY_NAME'
      Origin = 'ACCOUNT_CATEGORY_NAME'
      Size = 250
    end
    object fdDataREGION_NAME: TStringField
      DisplayLabel = #1054#1073#1083#1072#1089#1090#1100
      FieldName = 'REGION_NAME'
      Origin = 'REGION_NAME'
      Size = 250
    end
    object fdDataACCOUNT_POST_ADDRESS: TStringField
      DisplayLabel = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089
      FieldName = 'ACCOUNT_POST_ADDRESS'
      Origin = 'ACCOUNT_POST_ADDRESS'
      Size = 250
    end
    object fdDataACCOUNT_LEGAL_ADDRESS: TStringField
      DisplayLabel = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
      FieldName = 'ACCOUNT_LEGAL_ADDRESS'
      Origin = 'ACCOUNT_LEGAL_ADDRESS'
      Size = 250
    end
    object fdDataACCOUNT_CALL_NOTE: TStringField
      DisplayLabel = #1052#1077#1090#1082#1072' '#1076#1083#1103' '#1086#1073#1079#1074#1086#1085#1072
      FieldName = 'ACCOUNT_CALL_NOTE'
      Origin = 'ACCOUNT_CALL_NOTE'
      Size = 250
    end
    object fdDataCLIENTS_VALUE_ID: TStringField
      DisplayLabel = #1042#1072#1078#1085#1086#1089#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
      FieldName = 'CLIENTS_VALUE_ID'
      Origin = 'CLIENTS_VALUE_ID'
      FixedChar = True
      Size = 36
    end
    object fdDataTIME_DIFFERENCE: TIntegerField
      DisplayLabel = #1056#1072#1079#1085#1080#1094#1072' '#1074#1088#1077#1084#1077#1085#1080' '#1089' '#1052#1086#1089#1082#1074#1086#1081
      FieldName = 'TIME_DIFFERENCE'
      Origin = 'TIME_DIFFERENCE'
    end
  end
end
