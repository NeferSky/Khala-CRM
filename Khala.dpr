program Khala;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Data in 'Data.pas' {dmData: TDataModule},
  SQLBldr in 'SQLBldr.pas',
  Kh_Consts in 'Kh_Consts.pas',
  FieldList in 'FieldList.pas' {frmColumnsList},
  FastFilter in 'FastFilter.pas' {frmFastFilter},
  Kh_Utils in 'Kh_Utils.pas',
  BaseForm in 'BaseForm.pas' {frmBaseForm},
  FormAccounts in 'FormAccounts.pas' {frmAccounts},
  BasePageForm in 'BasePageForm.pas' {frmBasePage},
  PageAccounts in 'PageAccounts.pas' {frmPageAccounts},
  FormAccountContacts in 'FormAccountContacts.pas' {frmAccountContacts},
  NsCipher in '..\_Units\NsCipher.pas',
  NsConvertUtils in '..\_Units\NsConvertUtils.pas',
  NsWinUtils in '..\_Units\NsWinUtils.pas',
  UIThemes in 'UIThemes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Khala CRM';
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
