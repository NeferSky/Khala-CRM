object frmDatabase: TfrmDatabase
  Left = 1351
  Top = 143
  BorderStyle = bsDialog
  Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 183
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblServerName: TLabel
    Left = 8
    Top = 38
    Width = 71
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1057#1077#1088#1074#1077#1088
  end
  object lblDatabaseName: TLabel
    Left = 8
    Top = 65
    Width = 71
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
  end
  object lblUserName: TLabel
    Left = 8
    Top = 92
    Width = 71
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1051#1086#1075#1080#1085
  end
  object lblPassword: TLabel
    Left = 8
    Top = 119
    Width = 71
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object lblDriverID: TLabel
    Left = 8
    Top = 11
    Width = 71
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1044#1088#1072#1081#1074#1077#1088
  end
  object edtServerName: TEdit
    Left = 93
    Top = 35
    Width = 200
    Height = 21
    TabOrder = 0
  end
  object edtDatabaseName: TEdit
    Left = 93
    Top = 62
    Width = 300
    Height = 21
    TabOrder = 1
  end
  object edtUserName: TEdit
    Left = 93
    Top = 89
    Width = 200
    Height = 21
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 93
    Top = 116
    Width = 200
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object btnCheckConnect: TButton
    Left = 96
    Top = 146
    Width = 135
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
    TabOrder = 4
    OnClick = btnCheckConnectClick
  end
  object btnOk: TButton
    Left = 237
    Top = 146
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 318
    Top = 146
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 6
  end
  object cmbDriverID: TComboBox
    Left = 93
    Top = 8
    Width = 200
    Height = 21
    Style = csDropDownList
    TabOrder = 7
  end
end
