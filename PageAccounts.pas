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
    tsAccountContacts: TTabSheet;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure CreatePageAccounts(AOwner: TComponent; AParent: TWinControl);

var
  frmPageAccounts: TfrmPageAccounts;

implementation

uses
  FormAccounts, FormAccountContacts;

{$R *.dfm}

//---------------------------------------------------------------------------

procedure CreatePageAccounts(AOwner: TComponent; AParent: TWinControl);
begin
  if frmPageAccounts = nil then
    frmPageAccounts := TfrmPageAccounts.ACreate(AOwner, AParent);
end;

//---------------------------------------------------------------------------

procedure TfrmPageAccounts.FormCreate(Sender: TObject);
begin
  inherited;

  Align := alClient;
  DetailsList.Add(CreateAccounts(Self, pcMaster.Pages[pcMaster.ActivePageIndex], True));
  DetailsList.Add(CreateAccountContacts(Self, pcDetails.Pages[pcDetails.ActivePageIndex], False));
end;

end.
