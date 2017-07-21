inherited frmAccountEdit: TfrmAccountEdit
  Left = 1368
  Top = 82
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
  ClientHeight = 628
  ClientWidth = 793
  ExplicitLeft = 1368
  ExplicitTop = 82
  ExplicitWidth = 809
  ExplicitHeight = 667
  PixelsPerInch = 96
  TextHeight = 13
  inherited sbStatusBar: TStatusBar
    Top = 609
    Width = 793
  end
  inherited pnlButtons: TPanel
    Top = 572
    Width = 793
    ExplicitWidth = 793
    inherited btnOk: TBitBtn
      Left = 621
      ExplicitLeft = 621
    end
    inherited btnCancel: TBitBtn
      Left = 702
      ExplicitLeft = 702
    end
  end
  object gbxPostAddress: TGroupBox [2]
    Left = 0
    Top = 273
    Width = 793
    Height = 184
    Align = alTop
    Caption = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089' '#1076#1086#1089#1090#1072#1074#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object lblIndex: TLabel
      Left = 81
      Top = 47
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1085#1076#1077#1082#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCity: TLabel
      Left = 330
      Top = 47
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = #1043#1086#1088#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblPOBox: TLabel
      Left = 100
      Top = 74
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = #1040'/'#1071
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblStreet: TLabel
      Left = 330
      Top = 74
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = #1059#1083#1080#1094#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblHouse: TLabel
      Left = 98
      Top = 101
      Width = 20
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1086#1084
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLiter: TLabel
      Left = 344
      Top = 101
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = #1051#1080#1090#1077#1088#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblSlash: TLabel
      Left = 605
      Top = 101
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = #1044#1088#1086#1073#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCorpus: TLabel
      Left = 82
      Top = 128
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1086#1088#1087#1091#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblBuilding: TLabel
      Left = 332
      Top = 128
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = #1057#1090#1088#1086#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRoom: TLabel
      Left = 579
      Top = 128
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1084#1077#1097#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblNote: TLabel
      Left = 63
      Top = 155
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = #1059#1090#1086#1095#1085#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtFullAddress: TEdit
      Left = 8
      Top = 17
      Width = 776
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edtFullAddress'
    end
    object edtIndex: TEdit
      Left = 124
      Top = 44
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'edtIndex'
    end
    object edtCity: TButtonedEdit
      Left = 367
      Top = 44
      Width = 417
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = 'edtCity'
    end
    object edtPOBox: TEdit
      Left = 124
      Top = 71
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'edtPOBox'
    end
    object edtStreet: TEdit
      Left = 367
      Top = 71
      Width = 417
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'edtStreet'
    end
    object edtHouse: TEdit
      Left = 124
      Top = 98
      Width = 141
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'edtHouse'
    end
    object edtLiter: TEdit
      Left = 387
      Top = 98
      Width = 141
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = 'edtLiter'
    end
    object edtSlash: TEdit
      Left = 643
      Top = 98
      Width = 141
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = 'edtSlash'
    end
    object edtCorpus: TEdit
      Left = 124
      Top = 125
      Width = 141
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = 'edtCorpus'
    end
    object edtBuilding: TEdit
      Left = 387
      Top = 125
      Width = 141
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      Text = 'edtBuilding'
    end
    object edtRoom: TEdit
      Left = 643
      Top = 125
      Width = 141
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = 'edtRoom'
    end
    object edtNote: TEdit
      Left = 124
      Top = 152
      Width = 660
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      Text = 'edtNote'
    end
  end
  object gbxDescription: TGroupBox [3]
    Left = 0
    Top = 457
    Width = 793
    Height = 115
    Align = alClient
    Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object lblCallNote: TLabel
      Left = 20
      Top = 90
      Width = 98
      Height = 13
      Caption = #1052#1077#1090#1082#1072' '#1076#1083#1103' '#1086#1073#1079#1074#1086#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtCallNote: TEdit
      Left = 124
      Top = 87
      Width = 660
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'edtCallNote'
    end
    object memNote: TMemo
      Left = 8
      Top = 17
      Width = 776
      Height = 64
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object pnlTop: TPanel [4]
    Left = 0
    Top = 0
    Width = 793
    Height = 273
    Align = alTop
    ParentColor = True
    TabOrder = 4
    object lblName: TLabel
      Left = 70
      Top = 32
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object lblFullName: TLabel
      Left = 31
      Top = 59
      Width = 87
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
    end
    object lblCategory: TLabel
      Left = 8
      Top = 86
      Width = 110
      Height = 13
      Alignment = taRightJustify
      Caption = #1060#1086#1088#1084#1072' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
    end
    object lblType: TLabel
      Left = 491
      Top = 86
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = #1058#1080#1087
    end
    object lblContact: TLabel
      Left = 24
      Top = 113
      Width = 94
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1089#1085#1086#1074#1085#1086#1081' '#1082#1086#1085#1090#1072#1082#1090
    end
    object lblOwner: TLabel
      Left = 428
      Top = 113
      Width = 81
      Height = 13
      Alignment = taRightJustify
      Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081
    end
    object lblINN: TLabel
      Left = 97
      Top = 140
      Width = 21
      Height = 13
      Alignment = taRightJustify
      Caption = #1048#1053#1053
    end
    object lblKPP: TLabel
      Left = 488
      Top = 140
      Width = 21
      Height = 13
      Alignment = taRightJustify
      Caption = #1050#1055#1055
    end
    object lblLegalAddress: TLabel
      Left = 15
      Top = 167
      Width = 103
      Height = 13
      Alignment = taRightJustify
      Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
    end
    object lblPostAddress: TLabel
      Left = 34
      Top = 194
      Width = 84
      Height = 13
      Alignment = taRightJustify
      Caption = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089
    end
    object lblRealPostAddress: TLabel
      Left = -1
      Top = 221
      Width = 119
      Height = 13
      Alignment = taRightJustify
      Caption = #1040#1076#1088#1077#1089' '#1076#1086#1089#1090#1072#1074#1082#1080' ('#1050#1091#1076#1072')'
    end
    object lblRealPostAddressContact: TLabel
      Left = 0
      Top = 248
      Width = 118
      Height = 13
      Alignment = taRightJustify
      Caption = #1040#1076#1088#1077#1089' '#1076#1086#1089#1090#1072#1074#1082#1080' ('#1050#1086#1084#1091')'
    end
    object edtName: TEdit
      Left = 124
      Top = 29
      Width = 660
      Height = 21
      TabOrder = 0
      Text = 'edtName'
    end
    object edtFullName: TEdit
      Left = 124
      Top = 56
      Width = 660
      Height = 21
      TabOrder = 1
      Text = 'edtFullName'
    end
    object edtCategory: TButtonedEdit
      Left = 124
      Top = 83
      Width = 269
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = 'edtCategory'
    end
    object cmbType: TComboBox
      Left = 515
      Top = 83
      Width = 269
      Height = 21
      TabOrder = 3
      Text = 'cmbType'
    end
    object edtContact: TButtonedEdit
      Left = 124
      Top = 110
      Width = 269
      Height = 21
      ReadOnly = True
      TabOrder = 4
      Text = 'edtContact'
    end
    object edtOwner: TButtonedEdit
      Left = 515
      Top = 110
      Width = 269
      Height = 21
      ReadOnly = True
      TabOrder = 5
      Text = 'edtOwner'
    end
    object edtINN: TEdit
      Left = 124
      Top = 137
      Width = 269
      Height = 21
      TabOrder = 6
      Text = 'edtINN'
    end
    object edtKPP: TEdit
      Left = 515
      Top = 137
      Width = 269
      Height = 21
      TabOrder = 7
      Text = 'edtKPP'
    end
    object edtLegalAddress: TEdit
      Left = 124
      Top = 164
      Width = 660
      Height = 21
      TabOrder = 8
      Text = 'edtLegalAddress'
    end
    object edtPostAddress: TEdit
      Left = 124
      Top = 191
      Width = 660
      Height = 21
      TabOrder = 9
      Text = 'edtPostAddress'
    end
    object edtRealPostAddress: TEdit
      Left = 124
      Top = 218
      Width = 660
      Height = 21
      TabOrder = 10
      Text = 'edtRealPostAddress'
    end
    object edtRealPostAddressContact: TEdit
      Left = 124
      Top = 245
      Width = 660
      Height = 21
      TabOrder = 11
      Text = 'edtRealPostAddressContact'
    end
    object chbActive: TCheckBox
      Left = 73
      Top = 6
      Width = 64
      Height = 17
      Alignment = taLeftJustify
      Caption = #1040#1082#1090#1080#1074#1077#1085
      TabOrder = 12
    end
  end
  inherited pmnuStatusBar: TPopupMenu
    Left = 24
    Top = 488
  end
  inherited qryGetRecord: TFDQuery
    SQL.Strings = (
      
        'select * from dbo.App_GetAccount('#39'{00000000-0000-0000-0000-00000' +
        '0000000}'#39')')
    object qryGetRecordAccountID: TGuidField
      FieldName = 'AccountID'
      Origin = 'AccountID'
      Size = 38
    end
    object qryGetRecordCreatedOn: TSQLTimeStampField
      FieldName = 'CreatedOn'
      Origin = 'CreatedOn'
    end
    object qryGetRecordCreatedByID: TGuidField
      FieldName = 'CreatedByID'
      Origin = 'CreatedByID'
      Size = 38
    end
    object qryGetRecordModifiedOn: TSQLTimeStampField
      FieldName = 'ModifiedOn'
      Origin = 'ModifiedOn'
    end
    object qryGetRecordModifiedByID: TGuidField
      FieldName = 'ModifiedByID'
      Origin = 'ModifiedByID'
      Size = 38
    end
    object qryGetRecordAccountName: TStringField
      FieldName = 'AccountName'
      Origin = 'AccountName'
      Size = 250
    end
    object qryGetRecordOfficialAccountName: TStringField
      FieldName = 'OfficialAccountName'
      Origin = 'OfficialAccountName'
      Size = 500
    end
    object qryGetRecordPrimaryContactID: TGuidField
      FieldName = 'PrimaryContactID'
      Origin = 'PrimaryContactID'
      Size = 38
    end
    object qryGetRecordPrimaryContactName: TStringField
      FieldName = 'PrimaryContactName'
      Origin = 'PrimaryContactName'
      Size = 250
    end
    object qryGetRecordOwnerID: TGuidField
      FieldName = 'OwnerID'
      Origin = 'OwnerID'
      Size = 38
    end
    object qryGetRecordOwnerName: TStringField
      FieldName = 'OwnerName'
      Origin = 'OwnerName'
      Size = 250
    end
    object qryGetRecordCityID: TGuidField
      FieldName = 'CityID'
      Origin = 'CityID'
      Size = 38
    end
    object qryGetRecordCityName: TStringField
      FieldName = 'CityName'
      Origin = 'CityName'
      Size = 250
    end
    object qryGetRecordAccountTypeID: TGuidField
      FieldName = 'AccountTypeID'
      Origin = 'AccountTypeID'
      Size = 38
    end
    object qryGetRecordAccountTypeName: TStringField
      FieldName = 'AccountTypeName'
      Origin = 'AccountTypeName'
      Size = 250
    end
    object qryGetRecordAccountCategoryID: TGuidField
      FieldName = 'AccountCategoryID'
      Origin = 'AccountCategoryID'
      Size = 38
    end
    object qryGetRecordAccountCategoryName: TStringField
      FieldName = 'AccountCategoryName'
      Origin = 'AccountCategoryName'
      Size = 250
    end
    object qryGetRecordInn: TStringField
      FieldName = 'Inn'
      Origin = 'Inn'
      Size = 50
    end
    object qryGetRecordKpp: TStringField
      FieldName = 'Kpp'
      Origin = 'Kpp'
      Size = 50
    end
    object qryGetRecordPostAddress: TStringField
      FieldName = 'PostAddress'
      Origin = 'PostAddress'
      Size = 250
    end
    object qryGetRecordLegalAddress: TStringField
      FieldName = 'LegalAddress'
      Origin = 'LegalAddress'
      Size = 250
    end
    object qryGetRecordRealPostAddress: TStringField
      FieldName = 'RealPostAddress'
      Origin = 'RealPostAddress'
      Size = 250
    end
    object qryGetRecordRealPostAddressContact: TStringField
      FieldName = 'RealPostAddressContact'
      Origin = 'RealPostAddressContact'
      Size = 250
    end
    object qryGetRecordNote: TStringField
      FieldName = 'Note'
      Origin = 'Note'
      Size = 8000
    end
    object qryGetRecordCallNote: TStringField
      FieldName = 'CallNote'
      Origin = 'CallNote'
      Size = 250
    end
    object qryGetRecordClientsValueID: TGuidField
      FieldName = 'ClientsValueID'
      Origin = 'ClientsValueID'
      Size = 38
    end
    object qryGetRecordPostAddressIndex: TStringField
      FieldName = 'PostAddressIndex'
      Origin = 'PostAddressIndex'
      Size = 6
    end
    object qryGetRecordPostAddressStreet: TStringField
      FieldName = 'PostAddressStreet'
      Origin = 'PostAddressStreet'
      Size = 200
    end
    object qryGetRecordPostAddressHouse: TStringField
      FieldName = 'PostAddressHouse'
      Origin = 'PostAddressHouse'
      Size = 60
    end
    object qryGetRecordPostAddressLetter: TStringField
      FieldName = 'PostAddressLetter'
      Origin = 'PostAddressLetter'
      Size = 2
    end
    object qryGetRecordPostAddressSlash: TStringField
      FieldName = 'PostAddressSlash'
      Origin = 'PostAddressSlash'
      Size = 8
    end
    object qryGetRecordPostAddressCorpus: TStringField
      FieldName = 'PostAddressCorpus'
      Origin = 'PostAddressCorpus'
      Size = 8
    end
    object qryGetRecordPostAddressBuilding: TStringField
      FieldName = 'PostAddressBuilding'
      Origin = 'PostAddressBuilding'
      Size = 8
    end
    object qryGetRecordPostAddressRoom: TStringField
      FieldName = 'PostAddressRoom'
      Origin = 'PostAddressRoom'
      Size = 15
    end
    object qryGetRecordPostAddressPoBox: TStringField
      FieldName = 'PostAddressPoBox'
      Origin = 'PostAddressPoBox'
      Size = 15
    end
    object qryGetRecordPostAddressNote: TStringField
      FieldName = 'PostAddressNote'
      Origin = 'PostAddressNote'
      Size = 200
    end
    object qryGetRecordActive: TIntegerField
      FieldName = 'Active'
      Origin = 'Active'
    end
  end
end
