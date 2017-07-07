object frmBasePage: TfrmBasePage
  Left = 2015
  Top = 218
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frmBasePage'
  ClientHeight = 601
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splLeft: TSplitter
    Left = 161
    Top = 0
    Height = 601
    ExplicitLeft = 232
    ExplicitTop = 160
    ExplicitHeight = 100
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 601
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object splFilter: TSplitter
      Left = 0
      Top = 341
      Width = 161
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 518
    end
    object pnlFilterArea: TPanel
      Left = 0
      Top = 344
      Width = 161
      Height = 257
      Align = alBottom
      Color = clActiveCaption
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 343
      ExplicitWidth = 159
    end
    object pnlActions: TPanel
      Left = 0
      Top = 0
      Width = 161
      Height = 32
      Align = alTop
      ParentColor = True
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 159
      object lblActions: TLabel
        Left = 8
        Top = 8
        Width = 66
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = #1044#1077#1081#1089#1090#1074#1080#1103' '#9660
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblReports: TLabel
        Left = 80
        Top = 8
        Width = 64
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = #1054#1090#1095#1077#1090#1099' '#9660
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pnlWorkArea: TPanel
    Left = 164
    Top = 0
    Width = 690
    Height = 601
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object splDetails: TSplitter
      Left = 0
      Top = 346
      Width = 690
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 311
    end
    object pcDetails: TPageControl
      Left = 0
      Top = 349
      Width = 690
      Height = 252
      Align = alBottom
      TabOrder = 0
      OnChange = pcDetailsChange
    end
    object pcMaster: TPageControl
      Left = 0
      Top = 0
      Width = 690
      Height = 346
      Align = alClient
      TabOrder = 1
    end
  end
end
