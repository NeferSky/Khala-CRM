inherited frmAccounts: TfrmAccounts
  Left = 490
  Top = 407
  Caption = 'frmAccounts'
  ExplicitLeft = 490
  ExplicitTop = 407
  PixelsPerInch = 96
  TextHeight = 13
  inherited frData11: TfrxReport
    Datasets = <>
    Variables = <>
    Style = <>
  end
  inherited fdData: TFDQuery
    SQL.Strings = (
      'SELECT * FROM ACCOUNT_SEL ')
    ParamData = <
      item
        Name = 'MASTERID'
        ParamType = ptInput
      end>
    object fdDataID: TStringField
      FieldName = 'ID'
      Origin = 'ID'
      Visible = False
      FixedChar = True
      Size = 36
    end
    object fdDataAccountName: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'AccountName'
      Origin = 'AccountName'
      Size = 250
    end
    object fdDataAccountTypeName: TStringField
      DisplayLabel = #1058#1080#1087
      FieldName = 'AccountTypeName'
      Origin = 'AccountTypeName'
      Size = 250
    end
    object fdDataContactName: TStringField
      DisplayLabel = #1054#1089#1085#1086#1074#1085#1086#1081' '#1082#1086#1085#1090#1072#1082#1090
      FieldName = 'ContactName'
      Origin = 'ContactName'
      Size = 250
    end
    object fdDataOwnerName: TStringField
      DisplayLabel = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081
      FieldName = 'OwnerName'
      Origin = 'OwnerName'
      Size = 250
    end
    object fdDataCreatorName: TStringField
      DisplayLabel = #1057#1086#1079#1076#1072#1083
      FieldName = 'CreatorName'
      Origin = 'CreatorName'
      Size = 250
    end
    object fdDataCreatedDate: TSQLTimeStampField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      FieldName = 'CreatedDate'
      Origin = 'CreatedDate'
    end
    object fdDataModifierName: TStringField
      DisplayLabel = #1048#1079#1084#1077#1085#1080#1083
      FieldName = 'ModifierName'
      Origin = 'ModifierName'
      Size = 250
    end
    object fdDataModifiedDate: TSQLTimeStampField
      DisplayLabel = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      FieldName = 'ModifiedDate'
      Origin = 'ModifiedDate'
    end
    object fdDataOfficialAccountName: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'OfficialAccountName'
      Origin = 'OfficialAccountName'
      Size = 500
    end
    object fdDataCityName: TStringField
      DisplayLabel = #1043#1086#1088#1086#1076
      FieldName = 'CityName'
      Origin = 'CityName'
      Size = 250
    end
    object fdDataPostAutonom: TStringField
      DisplayLabel = #1060#1077#1076#1077#1088#1072#1083#1100#1085#1099#1081' '#1086#1082#1088#1091#1075
      FieldName = 'PostAutonom'
      Origin = 'PostAutonom'
      Size = 250
    end
    object fdDataAccountINN: TStringField
      DisplayLabel = #1048#1053#1053
      FieldName = 'AccountINN'
      Origin = 'AccountINN'
      Size = 50
    end
    object fdDataAccountKPP: TStringField
      DisplayLabel = #1050#1055#1055
      FieldName = 'AccountKPP'
      Origin = 'AccountKPP'
      Size = 50
    end
    object fdDataAccountCategoryName: TStringField
      DisplayLabel = #1060#1086#1088#1084#1072' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
      FieldName = 'AccountCategoryName'
      Origin = 'AccountCategoryName'
      Size = 250
    end
    object fdDataRegionName: TStringField
      DisplayLabel = #1054#1073#1083#1072#1089#1090#1100
      FieldName = 'RegionName'
      Origin = 'RegionName'
      Size = 250
    end
    object fdDataAccountPostAddress: TStringField
      DisplayLabel = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089
      FieldName = 'AccountPostAddress'
      Origin = 'AccountPostAddress'
      Size = 250
    end
    object fdDataAccountLegalAddress: TStringField
      DisplayLabel = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
      FieldName = 'AccountLegalAddress'
      Origin = 'AccountLegalAddress'
      Size = 250
    end
    object fdDataAccountCallNote: TStringField
      DisplayLabel = #1052#1077#1090#1082#1072' '#1076#1083#1103' '#1086#1073#1079#1074#1086#1085#1072
      FieldName = 'AccountCallNote'
      Origin = 'AccountCallNote'
      Size = 250
    end
    object fdDataClientsValue: TStringField
      DisplayLabel = #1042#1072#1078#1085#1086#1089#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
      FieldName = 'ClientsValue'
      Origin = 'ClientsValue'
      Size = 250
    end
    object fdDataTimeDifference: TIntegerField
      DisplayLabel = #1056#1072#1079#1085#1080#1094#1072' '#1074#1088#1077#1084#1077#1085#1080' '#1089' '#1052#1086#1089#1082#1074#1086#1081
      FieldName = 'TimeDifference'
      Origin = 'TimeDifference'
    end
  end
  inherited alActions: TActionList
    inherited actEdit: TAction
      OnExecute = actEditExecute
    end
    inherited actDelete: TAction
      OnExecute = actDeleteExecute
    end
  end
end
