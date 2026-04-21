
program Eclipses;

{ Date of solar eclipses for the 21st century. }

uses
  SysUtils, Classes,
  Moon; { https://github.com/wp-xyz/delphimoon }

const
  CYear1 = 2000;
  CYear2 = 2099;
  CSolarEclipses = TRUE;
  CFrenchName: array[TEclipse] of string = ('', 'partielle', 'non centrale', 'annulaire', 'hybride', 'totale', 'pénombrale');
  
var
  dt, fromDate, toDate: TDateTime;
  eclipseValue: TEclipse;
  
begin
  DefaultFormatSettings.DateSeparator := '/';
  
  fromDate := EncodeDate(CYear1, 1, 1);
  toDate := EncodeDate(CYear2, 12, 31);
  
  WriteLn('# Éclipses');
  WriteLn;
  WriteLn('Prévision des éclipses solaires pour le XXI<sup>e</sup> siècle, basée sur l''unité [Moon](https://github.com/wp-xyz/delphimoon) d''Andreas Hörstemeier.');
  WriteLn;
  WriteLn('Date et heure | Type d''éclipse');
  WriteLn(':---: | :---:');
  
  dt := fromDate;
  repeat
    eclipseValue := NextEclipse(dt, CSolarEclipses);
    if dt <= toDate then
      WriteLn(Format('%s | %s', [FormatDateTime('dd/mm/yyyy hh:nn', dt), CFrenchName[eclipseValue]]));
    dt := dt + 24;
  until dt >= toDate;
end.
