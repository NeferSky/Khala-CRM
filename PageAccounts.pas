unit PageAccounts;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  BasePageForm, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.Menus, System.Actions, Vcl.ActnList,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPageAccounts = class(TfrmBasePage)
    tsAccounts: TTabSheet;
    tsAccountContacts: TTabSheet;
    tsAccountGroups: TTabSheet;
    //--
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetPage(AOwner: TComponent;
      AParent: TWinControl): TfrmBasePage; override;
  end;

const
  // A1DF9C82-C33D-44F4-8BD5-85DE2135C868
  FORM_ID: TGuid =
    (D1: $A1DF9C82; D2: $C33D; D3: $44F4; D4: ($8B, $D5, $85, $DE, $21, $35, $C8, $68));

var
  frmPageAccounts: TfrmPageAccounts;

implementation

uses
  FormAccounts, FormAccountContacts, FormAccountGroups;

{$R *.dfm}

{ TfrmPageAccounts }
//---------------------------------------------------------------------------

class function TfrmPageAccounts.GetPage(AOwner: TComponent;
  AParent: TWinControl): TfrmBasePage;
begin
  if frmPageAccounts = nil then
    frmPageAccounts := TfrmPageAccounts.ACreate(AOwner, AParent, FORM_ID);

  Result := frmPageAccounts;
end;

//---------------------------------------------------------------------------

procedure TfrmPageAccounts.FormCreate(Sender: TObject);
begin
  inherited;
  pcDetails.ActivePageIndex := 0;

  DetailsList.Add(TfrmAccountContacts.CreateForm(Self, tsAccountContacts, False));
  DetailsList.Add(TfrmAccountGroups.CreateForm(Self, tsAccountGroups, False));

  MasterForm := TfrmAccounts.CreateForm(Self, tsAccounts, True);
  MasterForm.MoveFirst;
end;

end.
