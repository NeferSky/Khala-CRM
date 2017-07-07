object frmLogon: TfrmLogon
  Left = 804
  Top = 201
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
  ClientHeight = 137
  ClientWidth = 324
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
  object edtUserName: TLabeledEdit
    Left = 8
    Top = 24
    Width = 308
    Height = 21
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = #1051#1086#1075#1080#1085':'
    TabOrder = 0
    Text = 'Developer'
  end
  object edtPassword: TLabeledEdit
    Left = 8
    Top = 72
    Width = 308
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1072#1088#1086#1083#1100':'
    PasswordChar = '*'
    TabOrder = 1
    Text = '2'
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 100
    Width = 324
    Height = 37
    Align = alBottom
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 96
    object btnOK: TButton
      Left = 152
      Top = 6
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 233
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 8
      TabOrder = 1
    end
  end
  object connLogon: TFDConnection
    Params.Strings = (
      'User_Name=login'
      'DriverID=FB'
      'CharacterSet=WIN1251'
      'Database=E:\Work\Firebird\KHALACRM.FDB'
      'Password=2')
    Connected = True
    LoginPrompt = False
    Transaction = trnLogon
    Left = 88
    Top = 8
  end
  object trnLogon: TFDTransaction
    Options.ReadOnly = True
    Options.AutoStart = False
    Options.AutoStop = False
    Connection = connLogon
    Left = 152
    Top = 8
  end
  object spLogon: TFDStoredProc
    Connection = connLogon
    Transaction = trnLogon
    StoredProcName = 'LOGON'
    Left = 216
    Top = 8
    ParamData = <
      item
        Position = 1
        Name = 'LOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 250
      end
      item
        Position = 2
        Name = 'PASS'
        DataType = ftString
        ParamType = ptInput
        Size = 250
      end
      item
        Position = 3
        Name = 'SUCCESS'
        DataType = ftBoolean
        ParamType = ptOutput
      end>
  end
end
