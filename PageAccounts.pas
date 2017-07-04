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
    //--
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetPage(AOwner: TComponent;
      AParent: TWinControl): TfrmBasePage; override;
  end;

var
  frmPageAccounts: TfrmPageAccounts;

implementation

uses
  FormAccounts, FormAccountContacts;

{$R *.dfm}

{ TfrmPageAccounts }
//---------------------------------------------------------------------------

class function TfrmPageAccounts.GetPage(AOwner: TComponent;
  AParent: TWinControl): TfrmBasePage;
begin
  if frmPageAccounts = nil then
    frmPageAccounts := TfrmPageAccounts.ACreate(AOwner, AParent);

  Result := frmPageAccounts;
end;

//---------------------------------------------------------------------------

procedure TfrmPageAccounts.FormCreate(Sender: TObject);
begin
  inherited;

  MasterForm := TfrmAccounts.CreateForm(Self,
    pcMaster.Pages[pcMaster.ActivePageIndex], True);

  DetailsList.Add(TfrmAccountContacts.CreateForm(Self,
    pcDetails.Pages[pcDetails.ActivePageIndex], False));

  MasterForm.MoveFirst;
end;

end.
