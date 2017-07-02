unit PageAccounts;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  BasePageForm;

type
  TfrmPageAccounts = class(TfrmBasePage)
    tsAccounts: TTabSheet;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure CreatePageAccounts(AOwner: TComponent);

var
  frmPageAccounts: TfrmPageAccounts;

implementation

uses
  FormAccounts, FormAccountContacts;

{$R *.dfm}

procedure CreatePageAccounts(AOwner: TComponent);
begin
  if frmPageAccounts = nil then
  begin
    frmPageAccounts := TfrmPageAccounts.Create(AOwner);
    frmPageAccounts.Parent := (AOwner as TWinControl);
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmPageAccounts.FormCreate(Sender: TObject);
begin
  inherited;

  Align := alClient;
  CreateAccounts(pcMaster.Pages[pcMaster.ActivePageIndex], True);
  CreateAccountContacts(pcDetails.Pages[pcDetails.ActivePageIndex]);
end;

end.
