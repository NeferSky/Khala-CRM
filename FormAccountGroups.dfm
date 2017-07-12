inherited frmAccountGroups: TfrmAccountGroups
  Left = 370
  Top = 259
  Caption = 'frmAccountGroups'
  ExplicitLeft = 370
  ExplicitTop = 259
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
    object fdDataGroupName: TStringField
      DisplayLabel = #1043#1088#1091#1087#1087#1072
      FieldName = 'GroupName'
      Origin = 'GroupName'
      Size = 250
    end
    object fdDataDescription: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'Description'
      Origin = 'Description'
      Size = 250
    end
    object fdDataBindDate: TSQLTimeStampField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1088#1080#1074#1103#1079#1082#1080
      FieldName = 'BindDate'
      Origin = 'BindDate'
    end
    object fdDataBinderName: TStringField
      DisplayLabel = #1055#1088#1080#1074#1103#1079#1072#1083
      FieldName = 'BinderName'
      Origin = 'BinderName'
      Size = 250
    end
  end
end
