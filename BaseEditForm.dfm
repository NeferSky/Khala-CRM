object frmBaseEditForm: TfrmBaseEditForm
  Left = 1917
  Top = 67
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'BaseEditForm'
  ClientHeight = 601
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbStatusBar: TStatusBar
    Left = 0
    Top = 582
    Width = 800
    Height = 19
    Panels = <
      item
        Style = psOwnerDraw
        Width = 50
      end>
    PopupMenu = pmnuStatusBar
    OnDrawPanel = sbStatusBarDrawPanel
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 545
    Width = 800
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      800
      37)
    object btnOk: TBitBtn
      Left = 628
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TBitBtn
      Left = 709
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pmnuStatusBar: TPopupMenu
    Left = 40
    Top = 496
    object mnuCopyID: TMenuItem
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1080#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
      OnClick = mnuCopyIDClick
    end
  end
  object spEdit: TFDStoredProc
    Connection = dmData.FDConnection
    Transaction = trnEdit
    Left = 16
    Top = 16
  end
  object trnEdit: TFDTransaction
    Connection = dmData.FDConnection
    Left = 16
    Top = 72
  end
  object qryGetRecord: TFDQuery
    Connection = dmData.FDConnection
    Transaction = dmData.FDTransaction
    Left = 72
    Top = 16
  end
end
