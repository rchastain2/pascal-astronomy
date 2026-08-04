
program Eclipses;

{ Date of solar eclipses }

uses
  SysUtils, Classes,
  Moon; { https://github.com/wp-xyz/delphimoon }

const
  CSolarEclipse = TRUE; { Uniquement les éclipses solaires }

{$DEFINE FRENCH}
{$IFDEF FRENCH}
const
  CFrench: array[TEclipse] of string = (
    { none          } '',
    { partial       } 'partielle',
    { noncentral    } 'non centrale',
    { circular      } 'annulaire',
    { circulartotal } 'hybride',
    { total         } 'totale',
    { halfshadow    } 'pénombrale'
  );
{$ENDIF}

var
  fromDate, toDate, dt: TDateTime;
  ecl: TEclipse;
  
begin
  fromDate := EncodeDate(CurrentYear, 1, 1);
  toDate   := EncodeDate(2099, 12, 31);
  
  dt := fromDate;
  repeat
    ecl := NextEclipse(dt, CSolarEclipse);
    if dt <= toDate then
      WriteLn(
        {$IFDEF FRENCH}
        FormatDateTime('dd"/"mm"/"yyyy hh:nn', dt), ' ', CFrench[ecl]
        {$ELSE}
        FormatDateTime('dd-mm-yyyy hh:nn', dt), ' ', ecl
        {$ENDIF}
      );
    dt := dt + 24;
  until dt >= toDate;
end.
