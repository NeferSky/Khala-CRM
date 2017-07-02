object frmColumnsList: TfrmColumnsList
  Left = 969
  Top = 780
  BorderStyle = bsSizeToolWin
  Caption = #1055#1088#1072#1074#1086#1081' '#1082#1085#1086#1087#1082#1086#1081'!'
  ClientHeight = 164
  ClientWidth = 185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object tvColumnsList: TTreeView
    Left = 0
    Top = 0
    Width = 185
    Height = 164
    Align = alClient
    DragMode = dmAutomatic
    Indent = 19
    TabOrder = 0
    OnDragDrop = tvColumnsListDragDrop
    OnDragOver = tvColumnsListDragOver
    OnStartDrag = tvColumnsListStartDrag
    ExplicitWidth = 193
    ExplicitHeight = 169
  end
end
