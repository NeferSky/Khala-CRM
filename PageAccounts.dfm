inherited frmPageAccounts: TfrmPageAccounts
  Left = 1813
  Top = 26
  Caption = 'frmPageAccounts'
  ExplicitLeft = 1813
  ExplicitTop = 26
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlLeft: TPanel
    ExplicitLeft = 1
  end
  inherited pnlWorkArea: TPanel
    inherited pcDetails: TPageControl
      ActivePage = tsAccountGroups
      object tsAccountContacts: TTabSheet
        Caption = #1050#1086#1085#1090#1072#1082#1090#1099
      end
      object tsAccountGroups: TTabSheet
        Caption = #1043#1088#1091#1087#1087#1099
        ImageIndex = 1
      end
    end
    inherited pcMaster: TPageControl
      ActivePage = tsAccounts
      object tsAccounts: TTabSheet
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099
      end
    end
  end
end
