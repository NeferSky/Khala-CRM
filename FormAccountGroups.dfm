inherited frmAccountGroups: TfrmAccountGroups
  Left = 370
  Top = 259
  Caption = 'frmAccountGroups'
  ExplicitLeft = 370
  ExplicitTop = 259
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
      'SELECT * FROM ACCOUNT_GROUPS_SEL(:MASTER_ID) ')
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
    object fdDataGROUP_NAME: TStringField
      DisplayLabel = #1043#1088#1091#1087#1087#1072
      FieldName = 'GROUP_NAME'
      Origin = 'GROUP_NAME'
      Size = 250
    end
    object fdDataDESCRIPTION: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'DESCRIPTION'
      Origin = 'DESCRIPTION'
      Size = 250
    end
    object fdDataBIND_DATE: TSQLTimeStampField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1088#1080#1074#1103#1079#1082#1080
      FieldName = 'BIND_DATE'
      Origin = 'BIND_DATE'
    end
    object fdDataBINDER: TStringField
      DisplayLabel = #1055#1088#1080#1074#1103#1079#1072#1083
      FieldName = 'BINDER'
      Origin = 'BINDER'
      Size = 250
    end
  end
end
