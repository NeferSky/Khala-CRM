unit FormAccountEdit;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseEditForm, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet;

type
  TfrmAccountEdit = class(TfrmBaseEditForm)
    gbxPostAddress: TGroupBox;
    gbxDescription: TGroupBox;
    pnlTop: TPanel;
    edtName: TEdit;
    edtFullName: TEdit;
    edtCategory: TButtonedEdit;
    cmbType: TComboBox;
    edtContact: TButtonedEdit;
    edtOwner: TButtonedEdit;
    edtINN: TEdit;
    edtKPP: TEdit;
    edtLegalAddress: TEdit;
    edtPostAddress: TEdit;
    edtRealPostAddress: TEdit;
    edtRealPostAddressContact: TEdit;
    edtFullAddress: TEdit;
    edtIndex: TEdit;
    edtCity: TButtonedEdit;
    edtPOBox: TEdit;
    edtStreet: TEdit;
    edtHouse: TEdit;
    edtLiter: TEdit;
    edtSlash: TEdit;
    edtCorpus: TEdit;
    edtBuilding: TEdit;
    edtRoom: TEdit;
    edtNote: TEdit;
    edtCallNote: TEdit;
    memNote: TMemo;
    lblName: TLabel;
    lblFullName: TLabel;
    lblCategory: TLabel;
    lblType: TLabel;
    lblContact: TLabel;
    lblOwner: TLabel;
    lblINN: TLabel;
    lblKPP: TLabel;
    lblLegalAddress: TLabel;
    lblPostAddress: TLabel;
    lblRealPostAddress: TLabel;
    lblRealPostAddressContact: TLabel;
    lblIndex: TLabel;
    lblCity: TLabel;
    lblPOBox: TLabel;
    lblStreet: TLabel;
    lblHouse: TLabel;
    lblLiter: TLabel;
    lblSlash: TLabel;
    lblCorpus: TLabel;
    lblBuilding: TLabel;
    lblRoom: TLabel;
    lblNote: TLabel;
    lblCallNote: TLabel;
    qryGetRecordAccountID: TGuidField;
    qryGetRecordCreatedOn: TSQLTimeStampField;
    qryGetRecordCreatedByID: TGuidField;
    qryGetRecordModifiedOn: TSQLTimeStampField;
    qryGetRecordModifiedByID: TGuidField;
    qryGetRecordAccountName: TStringField;
    qryGetRecordOfficialAccountName: TStringField;
    qryGetRecordPrimaryContactID: TGuidField;
    qryGetRecordPrimaryContactName: TStringField;
    qryGetRecordOwnerID: TGuidField;
    qryGetRecordOwnerName: TStringField;
    qryGetRecordCityID: TGuidField;
    qryGetRecordCityName: TStringField;
    qryGetRecordAccountTypeID: TGuidField;
    qryGetRecordAccountTypeName: TStringField;
    qryGetRecordAccountCategoryID: TGuidField;
    qryGetRecordAccountCategoryName: TStringField;
    qryGetRecordInn: TStringField;
    qryGetRecordKpp: TStringField;
    qryGetRecordPostAddress: TStringField;
    qryGetRecordLegalAddress: TStringField;
    qryGetRecordRealPostAddress: TStringField;
    qryGetRecordRealPostAddressContact: TStringField;
    qryGetRecordNote: TStringField;
    qryGetRecordCallNote: TStringField;
    qryGetRecordClientsValueID: TGuidField;
    qryGetRecordPostAddressIndex: TStringField;
    qryGetRecordPostAddressStreet: TStringField;
    qryGetRecordPostAddressHouse: TStringField;
    qryGetRecordPostAddressLetter: TStringField;
    qryGetRecordPostAddressSlash: TStringField;
    qryGetRecordPostAddressCorpus: TStringField;
    qryGetRecordPostAddressBuilding: TStringField;
    qryGetRecordPostAddressRoom: TStringField;
    qryGetRecordPostAddressPoBox: TStringField;
    qryGetRecordPostAddressNote: TStringField;
    qryGetRecordActive: TIntegerField;
    chbActive: TCheckBox;
  private
    { Private declarations }
    procedure Prepare;
  public
    { Public declarations }
    class function CreateEditForm(AOwner: TComponent; RecordID: TGuid): TfrmBaseEditForm;
  end;

const
  SQL_PROCEDURE_UPDATE = 'dbo.App_AccountUpdate';
  SQL_GET_ACCOUNT = 'select * from dbo.App_GetAccount(:RecordID) ';

var
  frmAccountEdit: TfrmAccountEdit;

implementation

{$R *.dfm}

{ TfrmAccountEdit }
//---------------------------------------------------------------------------

class function TfrmAccountEdit.CreateEditForm(AOwner: TComponent;
  RecordID: TGuid): TfrmBaseEditForm;
begin
  with TfrmAccountEdit.ACreate(AOwner, RecordID) do
  begin
    UpdateSQLProcedure := SQL_PROCEDURE_UPDATE;
    SelectSQLText := SQL_GET_ACCOUNT;
    Open;
    Prepare;
    Show;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmAccountEdit.Prepare;
begin
  chbActive.Checked := qryGetRecord.FieldByName('Active').AsInteger = 1;
  edtName.Text := qryGetRecord.FieldByName('AccountName').AsString;
  edtFullName.Text := qryGetRecord.FieldByName('OfficialAccountName').AsString;
  edtCategory.Text := qryGetRecord.FieldByName('AccountCategoryName').AsString;
  cmbType.Text := qryGetRecord.FieldByName('AccountTypeName').AsString;
  edtContact.Text := qryGetRecord.FieldByName('PrimaryContactName').AsString;
  edtOwner.Text := qryGetRecord.FieldByName('OwnerName').AsString;
  edtINN.Text := qryGetRecord.FieldByName('Inn').AsString;
  edtKPP.Text := qryGetRecord.FieldByName('Kpp').AsString;
  edtLegalAddress.Text := qryGetRecord.FieldByName('LegalAddress').AsString;
  edtPostAddress.Text := qryGetRecord.FieldByName('PostAddress').AsString;
  edtRealPostAddress.Text := qryGetRecord.FieldByName('RealPostAddress').AsString;
  edtRealPostAddressContact.Text := qryGetRecord.FieldByName('RealPostAddressContact').AsString;
  edtIndex.Text := qryGetRecord.FieldByName('PostAddressIndex').AsString;
  edtCity.Text := qryGetRecord.FieldByName('CityName').AsString;
  edtPOBox.Text := qryGetRecord.FieldByName('PostAddressPOBox').AsString;
  edtStreet.Text := qryGetRecord.FieldByName('PostAddressStreet').AsString;
  edtHouse.Text := qryGetRecord.FieldByName('PostAddressHouse').AsString;
  edtLiter.Text := qryGetRecord.FieldByName('PostAddressLetter').AsString;
  edtSlash.Text := qryGetRecord.FieldByName('PostAddressSlash').AsString;
  edtCorpus.Text := qryGetRecord.FieldByName('PostAddressCorpus').AsString;
  edtBuilding.Text := qryGetRecord.FieldByName('PostAddressBuilding').AsString;
  edtRoom.Text := qryGetRecord.FieldByName('PostAddressRoom').AsString;
  edtNote.Text := qryGetRecord.FieldByName('PostAddressNote').AsString;

  edtFullAddress.Text := Format('%s %s %s %s %s %s %s %s %s %s',
    [edtIndex.Text, edtCity.Text, edtPOBox.Text, edtStreet.Text, edtHouse.Text,
    edtLiter.Text, edtSlash.Text, edtCorpus.Text, edtBuilding.Text, edtRoom.Text]);

  memNote.Lines.Text := qryGetRecord.FieldByName('Note').AsString;
  edtCallNote.Text := qryGetRecord.FieldByName('CallNote').AsString;
end;

end.
