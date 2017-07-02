object frmFastFilter: TfrmFastFilter
  Left = 785
  Top = 530
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'frmFastFilter'
  ClientHeight = 105
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblFields: TLabel
    Left = 8
    Top = 19
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1055#1086#1083#1077
  end
  object lblValue: TLabel
    Left = 8
    Top = 43
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077
  end
  object cmbColumns: TComboBox
    Left = 72
    Top = 16
    Width = 305
    Height = 21
    DropDownCount = 10
    TabOrder = 0
    TabStop = False
    Text = 'cmbColumns'
    OnChange = cmbColumnsChange
    OnKeyPress = cmbColumnsKeyPress
    OnSelect = cmbColumnsChange
  end
  object edtValue: TEdit
    Left = 72
    Top = 40
    Width = 305
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object btnOk: TButton
    Left = 224
    Top = 72
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 304
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object udValue: TUpDown
    Left = 361
    Top = 39
    Width = 17
    Height = 21
    TabOrder = 4
  end
  object chbValue: TCheckBox
    Left = 72
    Top = 43
    Width = 97
    Height = 17
    Caption = 'chbValue'
    TabOrder = 5
    OnClick = chbValueClick
  end
  object dtValue: TDateTimePicker
    Left = 72
    Top = 40
    Width = 305
    Height = 21
    Date = 42891.000000000000000000
    Time = 42891.000000000000000000
    TabOrder = 6
  end
end
