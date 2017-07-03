inherited frmPageAccounts: TfrmPageAccounts
  Left = 322
  Top = 261
  Caption = 'frmPageAccounts'
  ExplicitLeft = 322
  ExplicitTop = 261
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlLeft: TPanel
    ExplicitLeft = 1
  end
  inherited pnlWorkArea: TPanel
    inherited pcDetails: TPageControl
      ActivePage = tsAccountContacts
      object tsAccountContacts: TTabSheet
        Caption = #1050#1086#1085#1090#1072#1082#1090#1099
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
