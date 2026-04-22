
unit WorkArea;

interface

function GetWorkArea(out AWidth, AHeight: integer): boolean;
function GetDimensions(out AWidth, AHeight: integer): boolean;

implementation

uses 
  SysUtils, Process, RegExpr;

function GetWorkArea(out AWidth, AHeight: integer): boolean;
var 
  s: ansistring;
  e: TRegExpr;
begin
  result := RunCommand('xprop', ['-root', '_NET_WORKAREA'], s);
  if result then
  begin
    // _NET_WORKAREA(CARDINAL) = 0, 0, 1600, 856
    e := TRegExpr.Create('_NET_WORKAREA\(CARDINAL\) = 0, 0, (\d+), (\d+)');
    result := e.Exec(s);
    if result then
    begin
      AWidth  := StrToInt(e.Match[1]);
      AHeight := StrToInt(e.Match[2]);
    end;
    e.Free;
  end;
end;

function GetDimensions(out AWidth, AHeight: integer): boolean;
var 
  s: ansistring;
  e: TRegExpr;
begin
  result := RunCommand('xdpyinfo', [], s);
  if result then
  begin
    //  dimensions:    1600x900 pixels (423x238 millimeters)
    e := TRegExpr.Create('dimensions:\s+(\d+)x(\d+) pixels');
    result := e.Exec(s);
    if result then
    begin
      AWidth  := StrToInt(e.Match[1]);
      AHeight := StrToInt(e.Match[2]);
    end;
    e.Free;
  end;
end;

end.
