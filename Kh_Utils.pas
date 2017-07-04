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

end.
