unit BasePageForm;

interface

uses
  Messages, System.Classes,
  Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  BaseForm, Kh_Consts;

type
  TfrmBasePage = class(TForm)
    splLeft: TSplitter;
    pnlLeft: TPanel;
    splFilter: TSplitter;
    pnlFilterArea: TPanel;
    pnlActions: TPanel;
    lblActions: TLabel;
    lblReports: TLabel;
    pnlWorkArea: TPanel;
    splDetails: TSplitter;
    pcDetails: TPageControl;
    pcMaster: TPageControl;
    TabSheet1: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pcDetailsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ResetTheme(var Msg: TMessage); message KH_RESET_THEME;
  protected
    DetailsList: TList<TfrmBaseForm>;
    MasterForm: TfrmBaseForm;
    class function GetPage(AOwner: TComponent;
      AParent: TWinControl): TfrmBasePage; virtual;
  public
    { Public declarations }
    constructor ACreate(AOwner: TComponent; AParent: TWinControl);
    procedure MasterProc(ID: String);
  published
    property Parent;
  end;

var
  frmBasePage: TfrmBasePage;

implementation

uses
  Kh_Utils, Dialogs, UIThemes;

{$R *.dfm}

{ TfrmBasePage }
//---------------------------------------------------------------------------

constructor TfrmBasePage.ACreate(AOwner: TComponent; AParent: TWinControl);
begin
  inherited Create(AOwner);
  DetailsList := TList<TfrmBaseForm>.Create;
  Parent := AParent;
end;

//---------------------------------------------------------------------------

class function TfrmBasePage.GetPage(AOwner: TComponent;
  AParent: TWinControl): TfrmBasePage;
begin
  // virtual;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.FormCreate(Sender: TObject);
begin
  // ��������� ��������� ��� ��������� �������
  lblActions.OnMouseEnter := TUtils.ControlMouseEnter;
  lblActions.OnMouseLeave := TUtils.ControlMouseLeave;

  lblReports.OnMouseEnter := TUtils.ControlMouseEnter;
  lblReports.OnMouseLeave := TUtils.ControlMouseLeave;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.FormDestroy(Sender: TObject);
begin
  DetailsList.Free;
end;

//---------------------------------------------------------------------------

// ���������� ������ ����
procedure TfrmBasePage.FormShow(Sender: TObject);
begin
  Self.Color := KhalaTheme.PanelFilterColor;
  pnlFilterArea.Color := KhalaTheme.PanelButtonsColor;
end;

//---------------------------------------------------------------------------

// ���������� ������-��������� �������� ��� ������������ �� �������
procedure TfrmBasePage.MasterProc(ID: String);
var
  I: Integer;
  NeedUpdate: Boolean;
  SlaveExistsVoobscheOrNot: Boolean;

begin
  if ID = '' then
  begin
    for I := 0 to DetailsList.Count - 1 do
      DetailsList[I].Disconnect;
  end
  else
  begin
    // ��� �������� �������� ��� ������ ��� �� ���
    SlaveExistsVoobscheOrNot := (pcDetails.ActivePageIndex <= DetailsList.Count - 1)
      and (DetailsList[pcDetails.ActivePageIndex] <> nil);

    // ����� �� ������������� ������ �� �������� �������
    if SlaveExistsVoobscheOrNot then
      NeedUpdate := DetailsList[pcDetails.ActivePageIndex].MasterID <> ID;

    // ����� �������� - ����
    for I := 0 to DetailsList.Count - 1 do
      DetailsList[I].MasterID := ID;

    // �������������� �������� �� �������� �������, ���� �����
    if SlaveExistsVoobscheOrNot and NeedUpdate then
      DetailsList[pcDetails.ActivePageIndex].RebuildQuery;
  end;
end;

//---------------------------------------------------------------------------

// ���������� ��������� �� ��������, ����� ���, ��� ������� ������ (��� ��������,
// ����� �� ������������� �� 5-10 ��������� �� ���� ����������� �� �������)
procedure TfrmBasePage.pcDetailsChange(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DetailsList.Count - 1 do
    DetailsList[I].Disconnect;

  DetailsList.Items[pcDetails.ActivePageIndex].Connect;
end;

procedure TfrmBasePage.ResetTheme(var Msg: TMessage);
begin

end;

end.
