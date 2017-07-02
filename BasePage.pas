unit BasePage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, NJ_Utils;

type
  TfrBasePage = class(TFrame)
    pnlLeft: TPanel;
    pnlWorkArea: TPanel;
    splLeft: TSplitter;
    splDetails: TSplitter;
    pnlFilterArea: TPanel;
    splFilter: TSplitter;
    pnlActions: TPanel;
    lblActions: TLabel;
    lblReports: TLabel;
    pcDetails: TPageControl;
    pcMaster: TPageControl;
    procedure lblActionsMouseEnter(Sender: TObject);
    procedure lblActionsMouseLeave(Sender: TObject);
    procedure lblReportsMouseEnter(Sender: TObject);
    procedure lblReportsMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);
  end;

implementation

uses
  NJ_Consts;

{$R *.dfm}

{ TfrBasePage }

constructor TfrBasePage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {
  // А в BaseFrame так работает. А тут - нет. Непонятно.
  lblActions.OnMouseEnter := TUtils.LabelMouseEnter;
  lblActions.OnMouseLeave := TUtils.LabelMouseLeave;

  lblReports.OnMouseEnter := TUtils.LabelMouseEnter;
  lblReports.OnMouseLeave := TUtils.LabelMouseLeave;
  }
end;

procedure TfrBasePage.lblActionsMouseEnter(Sender: TObject);
begin
  TUtils.ControlMouseEnter(Sender);
end;

procedure TfrBasePage.lblActionsMouseLeave(Sender: TObject);
begin
  TUtils.ControlMouseLeave(Sender);
end;

procedure TfrBasePage.lblReportsMouseEnter(Sender: TObject);
begin
  TUtils.ControlMouseEnter(Sender);
end;

procedure TfrBasePage.lblReportsMouseLeave(Sender: TObject);
begin
  TUtils.ControlMouseLeave(Sender);
end;

end.
