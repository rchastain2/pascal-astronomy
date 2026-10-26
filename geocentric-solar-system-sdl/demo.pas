
{
  Geocentric Solar System
  
  Pascal version of this JavaScript program: https://github.com/Kharoh/Geocentric-Solar-System.git
}

uses
  SysUtils, Classes,
  SDL2,
  agg_2D,
  agg_basics;

const
  globalScale   = 2;
  speedScale    = 0.5 * globalScale;
  distanceScale = 30 * globalScale;
  radiusScale   = 0.3 * globalScale;
  CFrameDuration = 1000 / 60;

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
    procedure Move(const AElapsed: double);
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
  inherited Destroy;
end;

procedure TPlanet.Render();
begin
  with color do
    agg^.fillColor(r, g, b);
  agg^.arc(x, y, radius, radius, 0, 2 * PI);
end;

procedure TPlanet.Move(const AElapsed: double);
var
  i: integer;
begin
  if isAttached then
  begin
    x := XCenter;
    y := YCenter;
  end else
  begin
    argument := speed * AElapsed / CFrameDuration;
    x := Cos(argument) * distance + centerObject.x;
    y := Sin(argument) * distance + centerObject.y;
  end;

  Render();
  for i := 0 to Pred(children.Count) do
    TPlanet(children.Items[i]).Move(AElapsed);
end;

procedure TPlanet.RegisterChild(planet: TPlanet);
begin
  children.Add(planet);
end;

(* -------------------------------------------------------------------------- *)

const
  CTitle = 'Geocentric Solar System';
  SURFACE_WIDTH = 1600;
  SURFACE_HEIGHT = 900;

procedure Fail(const AMessage: string);
begin
  WriteLn(AMessage, ': ', SDL_GetError);
  SDL_Quit;
  Halt(1);
end;

var
  w1: pSDL_Window;
  r1: pSDL_Renderer;
  s1: pSDL_Surface;
  t1: pSDL_Texture;
  e1: pSDL_Event;
  
  agg: Agg2D_ptr;
  earth, moon, sun, mercury, venus, mars, jupiter, saturne, uranus, neptune: TPlanet;
  
  w, h: integer;
  loop: boolean = TRUE;
  startTime, frameStart, frameTime: qword;

begin
  if SDL_Init(SDL_INIT_VIDEO) < 0 then
    Fail('SDL_Init');

  w1 := SDL_CreateWindow(CTitle, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SURFACE_WIDTH, SURFACE_HEIGHT, SDL_WINDOW_SHOWN or SDL_WINDOW_FULLSCREEN_DESKTOP);
  if w1 = nil then
    Fail('SDL_CreateWindow');
  
  r1 := SDL_CreateRenderer(w1, -1, 0);
  if r1 = nil then
    Fail('SDL_CreateRenderer');
  
  SDL_GetRendererOutputSize(r1, @w, @h);
  
  XCenter := w / 2;
  YCenter := h / 2;
  
  s1 := SDL_CreateRGBSurface(0, w, h, 32, $00FF0000, $0000FF00, $000000FF, 0);
  if s1 = nil then
    Fail('SDL_CreateRGBSurface');
  
  t1 := SDL_CreateTexture(r1, SDL_PIXELFORMAT_RGB888, SDL_TEXTUREACCESS_STREAMING, w, h);
  if t1 = nil then
    Fail('SDL_CreateTexture');
  
  New(agg, Construct);
  agg^.attach(pbyte(s1^.pixels), s1^.w, s1^.h, s1^.pitch);
  agg^.noLine;
  agg^.clearAll(18, 18, 18);

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
  
  New(e1);
  
  startTime := GetTickCount64;
  
  while loop do
  begin
    while SDL_PollEvent(e1) = 1 do
      case e1^.type_ of
        SDL_KEYDOWN:
          case e1^.key.keysym.sym of
            SDLK_ESCAPE: loop := FALSE; // exit on pressing ESC key
          end;
        SDL_QUITEV:
          loop := FALSE;
      end;
    
    frameStart := GetTickCount64;

    agg^.fillColor(18, 18, 18, 128);
    agg^.rectangle(0, 0, w, h);

    earth.Move(frameStart - startTime);

    SDL_UpdateTexture(t1, nil, s1^.pixels, s1^.pitch);
    SDL_RenderCopy(r1, t1, nil, nil);
    SDL_RenderPresent(r1);

    frameTime := GetTickCount64 - frameStart;
    if frameTime < CFrameDuration then
      SDL_Delay(Round(CFrameDuration - frameTime));
  end;
  
  Dispose(e1);
  
  SDL_DestroyTexture(t1);
  SDL_FreeSurface(s1);
  
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
  
  SDL_DestroyRenderer(r1);
  SDL_DestroyWindow(w1);

  SDL_Quit;
end.
