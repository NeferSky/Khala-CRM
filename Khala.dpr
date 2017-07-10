program Khala;

uses
  Vcl.Forms,
  NsCipher in '..\_Units\NsCipher.pas',
  NsConvertUtils in '..\_Units\NsConvertUtils.pas',
  NsWinUtils in '..\_Units\NsWinUtils.pas',
  Kh_Consts in 'Kh_Consts.pas',
  Kh_Utils in 'Kh_Utils.pas',
  UIThemes in 'UIThemes.pas',
  SQLBldr in 'SQLBldr.pas',
  BaseForm in 'BaseForm.pas' {frmBaseForm},
  BasePageForm in 'BasePageForm.pas' {frmBasePage},
  Data in 'Data.pas' {dmData: TDataModule},
  Main in 'Main.pas' {frmMain},
  FormLogon in 'FormLogon.pas' {frmLogon},
  FieldList in 'FieldList.pas' {frmColumnsList},
  FastFilter in 'FastFilter.pas' {frmFastFilter},
  FormAccounts in 'FormAccounts.pas' {frmAccounts},
  FormAccountContacts in 'FormAccountContacts.pas' {frmAccountContacts},
  FormAccountGroups in 'FormAccountGroups.pas' {frmAccountGroups},
  PageAccounts in 'PageAccounts.pas' {frmPageAccounts},
  FormContacts in 'FormContacts.pas' {frmContacts},
  FormContactCommunication in 'FormContactCommunication.pas' {frmContactCommunication},
  FormContactAnniversary in 'FormContactAnniversary.pas' {frmContactAnniversary},
  FormContactTasks in 'FormContactTasks.pas' {frmContactTasks};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Khala CRM';
  InitThemesManager;
  Application.CreateForm(TdmData, dmData);
  if Logon then
  begin
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  end
  else
    dmData.Free;

end.
