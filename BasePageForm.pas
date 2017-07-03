unit BasePageForm;

interface

uses
  System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pcDetailsChange(Sender: TObject);
  private
    { Private declarations }
  protected
    DetailsList: TList;
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
  Kh_Utils, BaseForm, Dialogs;

{$R *.dfm}

//---------------------------------------------------------------------------

constructor TfrmBasePage.ACreate(AOwner: TComponent; AParent: TWinControl);
begin
  inherited Create(AOwner);
  DetailsList := TList.Create;
  Parent := AParent;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.FormCreate(Sender: TObject);
begin
  // ѕодсветка контролов при наведении курсора
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

procedure TfrmBasePage.MasterProc(ID: String);
var
  I: Integer;
begin
  for I := 0 to DetailsList.Count - 1 do
  begin
    TfrmBaseForm(DetailsList[I]).MasterID := ID;
    TfrmBaseForm(DetailsList[I]).RebuildQuery;
  end;
end;

//---------------------------------------------------------------------------

procedure TfrmBasePage.pcDetailsChange(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DetailsList.Count - 1 do
    TfrmBaseForm(DetailsList[I]).Disconnect;

  TfrmBaseForm(DetailsList.Items[pcDetails.ActivePageIndex]).Connect;
end;

end.
