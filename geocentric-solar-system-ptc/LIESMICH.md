# Geocentric solar system

Animierte geozentrische Darstellung des Sonnensystems.

Pascal-Version eines [JavaScript-Programms](https://github.com/Kharoh/Geocentric-Solar-System.git).

## Darstellung

Wie das Original löscht das Programm den Bildschirm zwischen zwei Bildern nicht: Es überdeckt das vorherige Bild mit einem halbtransparenten dunkelgrauen Schleier (`rgba(18, 18, 18, 0.5)`), sodass bewegte Himmelskörper eine kurze, verblassende Spur hinterlassen.

## Kompilierung

Korrigieren Sie den Pfad zu den [AGGPas][1]-Units in der *Makefile*
(abhängig von Ihrer Installation), dann:

```bash
make
```

## Interessante Links

- [Eccentrics, Deferents, Epicycles, and Equants](https://www.mathpages.com/home/kmath639/kmath639.htm)
- [orrery](https://github.com/duffyg/orrery)
- [Ptolemy’s cosmos](https://rhodesmill.org/ptolemy/)

[1]: https://github.com/graemeg/fpGUI/tree/develop/framework/src/main/pascal/corelib/render/software
