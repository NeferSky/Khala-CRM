inherited frmAccountContacts: TfrmAccountContacts
  Left = 457
  Top = 313
  Caption = 'frmAccountContacts'
  ExplicitLeft = 457
  ExplicitTop = 313
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
    object fdDataContactName: TStringField
      DisplayLabel = #1048#1084#1103
      FieldName = 'ContactName'
      Origin = 'ContactName'
      Size = 250
    end
    object fdDataJobName: TStringField
      DisplayLabel = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      FieldName = 'JobName'
      Origin = 'JobName'
      Size = 250
    end
    object fdDataCommType1: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 1'
      FieldName = 'CommType1'
      Origin = 'CommType1'
      Size = 250
    end
    object fdDataComm1: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 1'
      FieldName = 'Comm1'
      Origin = 'Comm1'
      Size = 250
    end
    object fdDataCommType2: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 2'
      FieldName = 'CommType2'
      Origin = 'CommType2'
      Size = 250
    end
    object fdDataComm2: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 2'
      FieldName = 'Comm2'
      Origin = 'Comm2'
      Size = 250
    end
    object fdDataCommType3: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 3'
      FieldName = 'CommType3'
      Origin = 'CommType3'
      Size = 250
    end
    object fdDataComm3: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 3'
      FieldName = 'Comm3'
      Origin = 'Comm3'
      Size = 250
    end
    object fdDataCommType4: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 4'
      FieldName = 'CommType4'
      Origin = 'CommType4'
      Size = 250
    end
    object fdDataComm4: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 4'
      FieldName = 'Comm4'
      Origin = 'Comm4'
      Size = 250
    end
    object fdDataCommType5: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 5'
      FieldName = 'CommType5'
      Origin = 'CommType5'
      Size = 250
    end
    object fdDataComm5: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 5'
      FieldName = 'Comm5'
      Origin = 'Comm5'
      Size = 250
    end
    object fdDataCommType6: TStringField
      DisplayLabel = #1042#1080#1076' '#1089#1074#1103#1079#1080' 6'
      FieldName = 'CommType6'
      Origin = 'CommType6'
      Size = 250
    end
    object fdDataComm6: TStringField
      DisplayLabel = #1057#1088#1077#1076#1089#1090#1074#1086' '#1089#1074#1103#1079#1080' 6'
      FieldName = 'Comm6'
      Origin = 'Comm6'
      Size = 250
    end
  end
end
