unit FieldList;

interface

uses
  SysUtils, Classes, Controls, Forms, ComCtrls;

type
  TfrmColumnsList = class(TForm)
    tvColumnsList: TTreeView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvColumnsListStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure tvColumnsListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvColumnsListDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
    FDraggedColumn: TTreeNode;
    FDraggedGridCol: String;
    FAssociate: TControl;
    function GetColumnsList: TStringList;
    procedure SetColumnsList(const Value: TStringList);
  public
    { Public declarations }
    procedure RemoveDraggedColumn;
    procedure AddDraggedColumn;
    property ColumnsList: TStringList read GetColumnsList write SetColumnsList;
    property DraggedColumn: TTreeNode read FDraggedColumn write FDraggedColumn;
    property Associate: TControl read FAssociate write FAssociate;
  end;

implementation

uses
  BaseForm;

{$R *.dfm}

//---------------------------------------------------------------------------
{ TfrmFieldList }

// Принимаем брошенное поле, создаем из него ноду
procedure TfrmColumnsList.AddDraggedColumn;
begin
  tvColumnsList.Items.Add(nil, FDraggedGridCol);
end;

//---------------------------------------------------------------------------

procedure TfrmColumnsList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//
end;

//---------------------------------------------------------------------------

// Геттер свойства
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

// Отдаем поле, передвигаемое драг-дропом
procedure TfrmColumnsList.RemoveDraggedColumn;
begin
  tvColumnsList.Items.Delete(FDraggedColumn);
end;

//---------------------------------------------------------------------------

// Сеттер свойства
procedure TfrmColumnsList.SetColumnsList(const Value: TStringList);
var
  I: Integer;
begin
  tvColumnsList.Items.Clear;
  for I := 0 to Value.Count - 1 do
    tvColumnsList.Items.Add(nil, Value[I]);
end;

//---------------------------------------------------------------------------

// Инициируем драггинг
procedure TfrmColumnsList.tvColumnsListStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FDraggedColumn := TTreeView(Sender).Selected;
end;
    
//---------------------------------------------------------------------------

// Принимаем перемещаемую колонку грида
procedure TfrmColumnsList.tvColumnsListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);

  function IsGridColumnMoving: Boolean;
  begin
    Result := (Source as TControl) = Associate;
  end;

begin
  Accept := IsGridColumnMoving;
end;

//---------------------------------------------------------------------------

// Принимаем перемещаемую колонку грида
procedure TfrmColumnsList.tvColumnsListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  tvColumnsList.Items.Add(nil, (Owner as TfrmBaseForm).GetDraggedFromGridColumn);
end;

end.
