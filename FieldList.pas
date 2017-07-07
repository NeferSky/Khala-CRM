unit FieldList;

interface

uses
  SysUtils, Classes, Controls, Forms, ComCtrls;

type
  TfrmColumnsList = class(TForm)
    tvColumnsList: TTreeView;
    //--
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvColumnsListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvColumnsListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvColumnsListStartDrag(Sender: TObject;
      var DragObject: TDragObject);
  private
    { Private declarations }
    FAssociate: TControl; // ������ �� ����
    FDraggedColumn: TTreeNode; // �������, ������� ��������������� �� ����� � ����
    FDraggedGridCol: String; // �������, ������� ��������������� �� ����� � ����
    //--
    function GetColumnsList: TStringList;
    procedure SetColumnsList(const Value: TStringList);
  public
    { Public declarations }
    procedure AddDraggedColumn;
    procedure RemoveDraggedColumn;
    //--
    property Associate: TControl read FAssociate write FAssociate;
    property ColumnsList: TStringList read GetColumnsList write SetColumnsList;
    property DraggedColumn: TTreeNode read FDraggedColumn write FDraggedColumn;
  end;

implementation

uses
  BaseForm;

{$R *.dfm}

{ TfrmFieldList }
//---------------------------------------------------------------------------

procedure TfrmColumnsList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//
end;

//---------------------------------------------------------------------------

procedure TfrmColumnsList.tvColumnsListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
// ��������� ������������ ������� �����
begin
  tvColumnsList.Items.Add(nil, (Owner as TfrmBaseForm).GetDraggedFromGridColumn);
end;

//---------------------------------------------------------------------------

procedure TfrmColumnsList.tvColumnsListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
// ��������� ������������ ������� �����

  function IsGridColumnMoving: Boolean;
  begin
    Result := (Source as TControl) = Associate;
  end;

begin
  Accept := IsGridColumnMoving;
end;

//---------------------------------------------------------------------------

procedure TfrmColumnsList.tvColumnsListStartDrag(Sender: TObject;
  var DragObject: TDragObject);
// ���������� ��������
begin
  FDraggedColumn := TTreeView(Sender).Selected;
end;

//---------------------------------------------------------------------------

function TfrmColumnsList.GetColumnsList: TStringList;
var
  I: Integer;

begin
  if Result = nil then
    Result := TStringList.Create;

  Result.Clear;
  for I := 0 to tvColumnsList.Items.Count - 1 do
    Result.Add(tvColumnsList.Items.Item[I].Text);
end;

//---------------------------------------------------------------------------

procedure TfrmColumnsList.SetColumnsList(const Value: TStringList);
var
  I: Integer;
begin
  tvColumnsList.Items.Clear;
  for I := 0 to Value.Count - 1 do
    tvColumnsList.Items.Add(nil, Value[I]);
end;

//---------------------------------------------------------------------------

procedure TfrmColumnsList.AddDraggedColumn;
// ��������� ��������� ����, ������� �� ���� ����
begin
  tvColumnsList.Items.Add(nil, FDraggedGridCol);
end;

//---------------------------------------------------------------------------

procedure TfrmColumnsList.RemoveDraggedColumn;
// ������ ����, ������������� ����-������
begin
  tvColumnsList.Items.Delete(FDraggedColumn);
end;

end.
