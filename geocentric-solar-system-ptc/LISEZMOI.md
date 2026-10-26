# Geocentric solar system

Représentation animée géocentrique du système solaire.

Version Pascal de ce [programme JavaScript](https://github.com/Kharoh/Geocentric-Solar-System.git).

## Rendu

Comme l'original, le programme n'efface pas l'écran entre deux images : il recouvre l'image précédente d'un voile gris foncé semi-transparent (`rgba(18, 18, 18, 0.5)`), si bien que les astres en mouvement laissent une courte traînée qui s'estompe.

## Compilation

Corriger dans *Makefile* le chemin vers les unités [AGGPas][1] (en fonction de votre installation), puis :

```bash
make
```

## Liens intéressants

- [Eccentrics, Deferents, Epicycles, and Equants](https://www.mathpages.com/home/kmath639/kmath639.htm)
- [orrery](https://github.com/duffyg/orrery)
- [Ptolemy’s cosmos](https://rhodesmill.org/ptolemy/)

[1]: https://github.com/graemeg/fpGUI/tree/develop/framework/src/main/pascal/corelib/render/software
