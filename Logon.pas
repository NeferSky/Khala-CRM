unit Logon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FSuccess: Boolean;
  public
    { Public declarations }
    property Success: Boolean read FSuccess;
  end;

var
  Form1: TForm1;

function Logon: Boolean;

implementation

uses
  UIThemes;

{$R *.dfm}

function Logon: Boolean;
begin
  Result := False;
  try
    Form1 := TForm1.Create(Application);
    Form1.ShowModal;
    Result := Form1.Success;
    Form1.Free;
  finally
    Form1 := nil;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Color := KhalaTheme.PanelFilterColor;
  FSuccess := False;
end;

end.
