
{
  Geocentric Solar System
  
  Pascal version of this JavaScript program: https://github.com/Kharoh/Geocentric-Solar-System.git
}

uses
  SysUtils,
  Classes,
  ptc,
  agg_2D,
  agg_basics,
  workarea;

const
  globalScale   = 2;
  speedScale    = 0.5 * globalScale;
  distanceScale = 35 * globalScale;
  radiusScale   = 0.3 * globalScale;

var
  XCenter, YCenter: double;

(* TPlanet ------------------------------------------------------------------ *)

type
  TPlanet = class
    agg: Agg2D_ptr;
    color: record
      r, g, b: byte;
    end;
    x, y, radius: double;
    children: TFPList;
    isAttached: boolean;
    centerObject: TPlanet;
    distance, speed, argument: double;
    period: integer;
    constructor Create(agg_: Agg2D_ptr; color_: longword; radius_: double; centerObject_: TPlanet = nil; distance_: double = 0; period_: integer = 0);
    destructor Destroy; override;
    procedure Render();
    procedure Move();
    procedure RegisterChild(planet: TPlanet);
  end;

constructor TPlanet.Create(agg_: Agg2D_ptr; color_: longword; radius_: double; centerObject_: TPlanet = nil; distance_: double = 0; period_: integer = 0);
begin
  agg := agg_;
  with color do
  begin
    r := (color_ and $FF0000) shr 16;
    g := (color_ and $FF00) shr 8;
    b := color_ and $FF;
  end;
  radius := radius_ * radiusScale;
  children := TFPList.Create;
  isAttached := centerObject_ = nil;

  if isAttached then
  begin
    x := XCenter;
    y := YCenter;
  end else
  begin
    centerObject := centerObject_;
    centerObject.RegisterChild(self);
    distance := distance_ * distanceScale;
    period := period_;
    speed := 2 * PI / period * speedScale;
    argument := 0;
    
    x := Cos(argument) * distance + centerObject.x;
    y := Sin(argument) * distance + centerObject.y;
  end;
end;

destructor TPlanet.Destroy;
begin
  children.Free;
end;

procedure TPlanet.Render();
begin
  with color do
    agg^.fillColor(r, g, b);
  agg^.arc(x, y, radius, radius, 0, 2 * PI);
end;

procedure TPlanet.Move();
var
  i: integer;
begin
  if isAttached then
  begin
    x := XCenter;
    y := YCenter;
  end else
  begin
    argument := argument + speed;
    x := Cos(argument) * distance + centerObject.x;
    y := Sin(argument) * distance + centerObject.y;
  end;

  Render();
  for i := 0 to Pred(children.Count) do
    TPlanet(children.Items[i]).Move();
end;

procedure TPlanet.RegisterChild(planet: TPlanet);
begin
  children.Add(planet);
end;

(* -------------------------------------------------------------------------- *)

const
  CTitle = 'Geocentric Solar System';
  CDelay = 8;
  CWidth = 1600;
  CHeight = 900;
  
var
  LWidth, LHeight: integer;
  
var
  console: IPTCConsole;
  format: IPTCFormat;
  pixels: PUint32 = nil;
  agg: Agg2D_ptr;
  earth, moon, sun, mercury, venus, mars, jupiter, saturne, uranus, neptune: TPlanet;
  
begin
  console := TPTCConsoleFactory.CreateNew;
  format := TPTCFormatFactory.CreateNew(32, $00FF0000, $0000FF00, $000000FF);
  console.option('fullscreen output');
  
  if GetDimensions(LWidth, LHeight) then
    WriteLn(LWidth, 'x', LHeight)
  else
  begin
    LWidth := CWidth;
    LHeight := CHeight;
  end;
  
  console.open(CTitle, LWidth, LHeight, format);
  
  XCenter := console.width / 2;
  YCenter := console.height / 2;
  
  pixels := GetMem(console.width * console.height * SizeOf(Uint32));
  FillByte(pixels^, console.width * console.height * SizeOf(Uint32), 0);
  
  New(agg, Construct);
  agg^.attach(pbyte(pixels), console.width, console.height, console.width * 4);
  agg^.noLine;
  
  earth := TPlanet.Create(agg, $8BC3F7, 3);
  moon := TPlanet.Create(agg, $D3D3D3, 1, earth, 0.002, 27);
  sun := TPlanet.Create(agg, $F8ED93, 16, earth, 1, 365);
  mercury := TPlanet.Create(agg, $FFA500, 1, sun, 0.4, 88);
  venus := TPlanet.Create(agg, $A52A2A, 2, sun, 0.7, 225);
  mars := TPlanet.Create(agg, $FF4500, 3.5, sun, 1.5, 687);
  jupiter := TPlanet.Create(agg, $C99039, 15, sun, 5.2, 4380);
  saturne := TPlanet.Create(agg, $EAD6B8, 10, sun, 9.5, 10585);
  uranus := TPlanet.Create(agg, $D1E7E7, 10, sun, 19.6, 30660);
  neptune := TPlanet.Create(agg, $C6D3E3, 10, sun, 30, 49275);
  
  while not console.KeyPressed do
  begin
    agg^.clearAll(0, 0, 0);
    earth.Move();
    console.Load(pixels, console.width, console.height, console.width * 4, format, TPTCPaletteFactory.CreateNew);
    console.update;
    Sleep(CDelay);
  end;
  
  earth.Free;
  moon.Free;
  sun.Free;
  mercury.Free;
  venus.Free;
  mars.Free;
  jupiter.Free;
  saturne.Free;
  uranus.Free;
  neptune.Free;
  
  Dispose(agg, Destruct);
  FreeMem(pixels);
  
  if Assigned(console) then
    console.close;
end.
