
program Eclipses;

{ Date of solar eclipses }

uses
  SysUtils, Classes,
  Moon; { https://github.com/wp-xyz/delphimoon }

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

{.$DEFINE HTML}

const
  CFormat = {$IFDEF HTML}'<tr><td>%s</td><td>%s</td></tr>'{$ELSE}'%s | %s'{$ENDIF};
  CSolarEclipse = TRUE;

var
  fromDate, toDate, dt: TDateTime;
  ec: TEclipse;
  
begin
  DefaultFormatSettings.DateSeparator := '/';
  
  fromDate := EncodeDate(CurrentYear, 1, 1);
  toDate   := EncodeDate(2049, 12, 31);
  
  dt := fromDate;
  repeat
    ec := NextEclipse(dt, CSolarEclipse);
    if dt <= toDate then
      WriteLn(Format(CFormat, [FormatDateTime('dd/mm/yyyy hh:nn', dt), CFrench[ec]]));
    dt := dt + 24;
  until dt >= toDate;
end.
