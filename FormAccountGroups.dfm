inherited frmAccountGroups: TfrmAccountGroups
  Caption = 'frmAccountGroups'
  PixelsPerInch = 96
  TextHeight = 13
  inherited frData: TfrxReport
    Datasets = <>
    Variables = <>
    Style = <>
  end
  inherited dsData: TIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM ACCOUNT_GROUPS_SEL(:MASTER_ID)')
    object dsDataID: TIBStringField
      FieldName = 'ID'
      Origin = '"ACCOUNT_GROUPS_SEL"."ID"'
      Visible = False
      FixedChar = True
      Size = 36
    end
    object dsDataGROUP_NAME: TIBStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'GROUP_NAME'
      Origin = '"ACCOUNT_GROUPS_SEL"."GROUP_NAME"'
      Size = 250
    end
    object dsDataDESCRIPTION: TIBStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'DESCRIPTION'
      Origin = '"ACCOUNT_GROUPS_SEL"."DESCRIPTION"'
      Size = 250
    end
    object dsDataBIND_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1088#1080#1074#1103#1079#1082#1080
      FieldName = 'BIND_DATE'
      Origin = '"ACCOUNT_GROUPS_SEL"."BIND_DATE"'
    end
    object dsDataBINDER: TIBStringField
      DisplayLabel = #1055#1088#1080#1074#1103#1079#1072#1083
      FieldName = 'BINDER'
      Origin = '"ACCOUNT_GROUPS_SEL"."BINDER"'
      Size = 250
    end
  end
end
