program fd_fd;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Edit in 'Edit.pas' {frmDatabase},
  Data in 'Data.pas' {dmData: TDataModule},
  fd_Const in 'fd_Const.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
