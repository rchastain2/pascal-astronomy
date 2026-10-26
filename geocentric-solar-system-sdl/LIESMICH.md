# Geocentric solar system

Animierte geozentrische Darstellung des Sonnensystems.

Pascal-Version eines [JavaScript-Programms](https://github.com/Kharoh/Geocentric-Solar-System.git).

## Darstellung

Wie das Original löscht das Programm den Bildschirm zwischen zwei Bildern nicht: Es überdeckt das vorherige Bild mit einem halbtransparenten dunkelgrauen Schleier (`rgba(18, 18, 18, 0.5)`), sodass bewegte Himmelskörper eine kurze, verblassende Spur hinterlassen.

## Kompilierung

Korrigieren Sie die Pfade zu den Units [SDL2][1] und [AGGPas][2] in der *Makefile*
(abhängig von Ihrer Installation), dann:

```bash
make
```

## Interessante Links

- [Eccentrics, Deferents, Epicycles, and Equants](https://www.mathpages.com/home/kmath639/kmath639.htm)
- [orrery](https://github.com/duffyg/orrery)
- [Ptolemy’s cosmos](https://rhodesmill.org/ptolemy/)

[1]: https://github.com/PascalGameDevelopment/SDL2-for-Pascal
[2]: https://github.com/graemeg/fpGUI/tree/develop/framework/src/main/pascal/corelib/render/software
