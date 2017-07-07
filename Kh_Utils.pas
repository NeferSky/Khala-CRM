unit Kh_Utils;

// Тут общесистемная хрень

interface

uses
  Vcl.StdCtrls, System.UITypes, Classes;

type TUtils = class
public
  class procedure ControlMouseEnter(Sender: TObject);
  class procedure ControlMouseLeave(Sender: TObject);
  class procedure ControlSetChecked(Sender: TObject);
  class procedure ControlSetUnchecked(Sender: TObject);
  class procedure ControlMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  class procedure ControlMouseUp(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  class function Smile: String;
end;

implementation

uses
  Vcl.Graphics, UIThemes, Vcl.Buttons;

//---------------------------------------------------------------------------

class procedure TUtils.ControlMouseEnter(Sender: TObject);
var
  FS: TFontStyles;
begin
  if (Sender is TLabel) then
  begin
    FS := (Sender as TLabel).Font.Style;
    Include(FS, fsUnderline);
    (Sender as TLabel).Font.Style := FS;
    (Sender as TLabel).Font.Color := KhalaTheme.FontColor;
  end;

  if (Sender is TButton) then
  begin
    FS := (Sender as TButton).Font.Style;
    Include(FS, fsUnderline);
    (Sender as TButton).Font.Style := FS;
    (Sender as TButton).Font.Color := KhalaTheme.FontColor;
  end;

  if (Sender is TBitBtn) then
  begin
    FS := (Sender as TBitBtn).Font.Style;
    Include(FS, fsUnderline);
    (Sender as TBitBtn).Font.Style := FS;
    (Sender as TBitBtn).Font.Color := KhalaTheme.FontColor;
  end;

  if (Sender is TEdit) then
  begin
    FS := (Sender as TEdit).Font.Style;
    Include(FS, fsUnderline);
    (Sender as TEdit).Font.Style := FS;
    (Sender as TEdit).Font.Color := KhalaTheme.FontColor;
  end;
end;

//---------------------------------------------------------------------------

class procedure TUtils.ControlMouseLeave(Sender: TObject);
var
  FS: TFontStyles;
begin
  if (Sender is TLabel) then
  begin
    FS := (Sender as TLabel).Font.Style;
    Exclude(FS, fsUnderline);
    (Sender as TLabel).Font.Style := FS;
    (Sender as TLabel).Font.Color := CL_TEXT;
  end;

  if (Sender is TButton) then
  begin
    FS := (Sender as TButton).Font.Style;
    Exclude(FS, fsUnderline);
    (Sender as TButton).Font.Style := FS;
    (Sender as TButton).Font.Color := CL_TEXT;
  end;

  if (Sender is TBitBtn) then
  begin
    FS := (Sender as TBitBtn).Font.Style;
    Exclude(FS, fsUnderline);
    (Sender as TBitBtn).Font.Style := FS;
    (Sender as TBitBtn).Font.Color := CL_TEXT;
  end;

  if (Sender is TEdit) then
  begin
    FS := (Sender as TEdit).Font.Style;
    Exclude(FS, fsUnderline);
    (Sender as TEdit).Font.Style := FS;
    (Sender as TEdit).Font.Color := CL_TEXT;
  end;
end;

//---------------------------------------------------------------------------

class procedure TUtils.ControlSetChecked(Sender: TObject);
var
  FS: TFontStyles;
begin
  if (Sender is TLabel) then
  begin
    FS := (Sender as TLabel).Font.Style;
    Include(FS, fsBold);
    Exclude(FS, fsUnderline);
    (Sender as TLabel).Font.Style := FS;
    (Sender as TLabel).Font.Color := CL_TEXT;
  end;

  if (Sender is TButton) then
  begin
    FS := (Sender as TButton).Font.Style;
    Include(FS, fsBold);
    Exclude(FS, fsUnderline);
    (Sender as TButton).Font.Style := FS;
    (Sender as TButton).Font.Color := CL_TEXT;
  end;

  if (Sender is TBitBtn) then
  begin
    FS := (Sender as TBitBtn).Font.Style;
    Include(FS, fsBold);
    Exclude(FS, fsUnderline);
    (Sender as TBitBtn).Font.Style := FS;
    (Sender as TBitBtn).Font.Color := CL_TEXT;
  end;

  if (Sender is TEdit) then
  begin
    FS := (Sender as TEdit).Font.Style;
    Include(FS, fsBold);
    Exclude(FS, fsUnderline);
    (Sender as TEdit).Font.Style := FS;
    (Sender as TEdit).Font.Color := CL_TEXT;
  end;
end;

//---------------------------------------------------------------------------

class procedure TUtils.ControlSetUnchecked(Sender: TObject);
var
  FS: TFontStyles;
begin
  if (Sender is TLabel) then
  begin
    FS := (Sender as TLabel).Font.Style;
    Exclude(FS, fsBold);
    Include(FS, fsUnderline);
    (Sender as TLabel).Font.Style := FS;
    (Sender as TLabel).Font.Color := CL_TEXT;
  end;

  if (Sender is TButton) then
  begin
    FS := (Sender as TButton).Font.Style;
    Exclude(FS, fsBold);
    Include(FS, fsUnderline);
    (Sender as TButton).Font.Style := FS;
    (Sender as TButton).Font.Color := CL_TEXT;
  end;

  if (Sender is TBitBtn) then
  begin
    FS := (Sender as TBitBtn).Font.Style;
    Exclude(FS, fsBold);
    Include(FS, fsUnderline);
    (Sender as TBitBtn).Font.Style := FS;
    (Sender as TBitBtn).Font.Color := CL_TEXT;
  end;

  if (Sender is TEdit) then
  begin
    FS := (Sender as TEdit).Font.Style;
    Exclude(FS, fsBold);
    Include(FS, fsUnderline);
    (Sender as TEdit).Font.Style := FS;
    (Sender as TEdit).Font.Color := CL_TEXT;
  end;
end;

//---------------------------------------------------------------------------

class procedure TUtils.ControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FS: TFontStyles;
begin
  if (Sender is TLabel) then
  begin
    FS := (Sender as TLabel).Font.Style;
    Include(FS, fsBold);
    (Sender as TLabel).Font.Style := FS;
  end;

  if (Sender is TButton) then
  begin
    FS := (Sender as TButton).Font.Style;
    Include(FS, fsBold);
    (Sender as TButton).Font.Style := FS;
  end;

  if (Sender is TBitBtn) then
  begin
    FS := (Sender as TBitBtn).Font.Style;
    Include(FS, fsBold);
    (Sender as TBitBtn).Font.Style := FS;
  end;

  if (Sender is TEdit) then
  begin
    FS := (Sender as TEdit).Font.Style;
    Include(FS, fsBold);
    (Sender as TEdit).Font.Style := FS;
  end;
end;

//---------------------------------------------------------------------------

class procedure TUtils.ControlMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FS: TFontStyles;
begin
  if (Sender is TLabel) then
  begin
    FS := (Sender as TLabel).Font.Style;
    Exclude(FS, fsBold);
    (Sender as TLabel).Font.Style := FS;
  end;

  if (Sender is TButton) then
  begin
    FS := (Sender as TButton).Font.Style;
    Exclude(FS, fsBold);
    (Sender as TButton).Font.Style := FS;
  end;

  if (Sender is TBitBtn) then
  begin
    FS := (Sender as TBitBtn).Font.Style;
    Exclude(FS, fsBold);
    (Sender as TBitBtn).Font.Style := FS;
  end;

  if (Sender is TEdit) then
  begin
    FS := (Sender as TEdit).Font.Style;
    Exclude(FS, fsBold);
    (Sender as TEdit).Font.Style := FS;
  end;
end;

//---------------------------------------------------------------------------

function B(I, K: Integer): Integer;
begin
  Result := K + I - K - I;
end;

//---------------------------------------------------------------------------

function A(I: Integer): Integer;
var
  R: Integer;
  K: Integer;
begin
  R := I;
  Result := $7B;
  for K := 1 to I do
  begin
    if Result = R then
      R := Result;
    Result := B(I, R);
    if I > R then
      R := R + 1;
  end;
  if Result > I then Exit;
  R := Result + Result - R;
  Result := I;

  // Нужно только это
  R := I - Ord(' ');
  Result := R;

  R := I - B(I, R);
end;

//---------------------------------------------------------------------------

class function TUtils.Smile: String;
// Обфускация пароля
begin
  Result :=
    Chr(A($65)) + Chr(A($8E)) +   Chr(A($40)) +
    Chr(A($94)) + Chr(A($81)) + Chr(A($92)) + Chr(A($8F)) +   Chr(A($40)) +
    Chr(A($61)) + Chr(A($84)) + Chr(A($95)) + Chr(A($8E)) +   Chr(A($41));
end;

end.
