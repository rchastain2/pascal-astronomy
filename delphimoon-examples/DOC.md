
# DelphiMoon documentation

## NextEclipse

Calculates the next eclipse.

```pascal
function NextEclipse(var date:TDateTime; sun:boolean):TEclipse;
```

Calculates the next eclipse after the given date. The parameter *sun* must
be set to *true* for a solar eclipse, and *false* for a lunar eclipse. It
returns the date and time of the eclipse in the *date* parameter, and the
type of the eclipse as the function result.

## TEclipse
 
```objectpascal
type TEclipse = (none, partial, noncentral, circular, circulartotal, total, halfshadow);
```

Different kinds of solar and lunar eclipses possible.

| Value         | Meaning |
| ------------- | ------- |
| none          | No eclipse at all. |
| partial       | Partial eclipse, just a segment of the sun is obscured. This happens when the center of the moon disc and the sun disc don't meet. |
| noncentral    | A total eclipse, but without the centers of the shadow region hitting earth, so only the polar regions get into the total area of the shadow. |
| circular      | Because of a different size of the discs there remains an illuminated ring around the shadowed part of the sun. Also called annular eclipse. |
| circulartotal | An eclipse which is total on part of the ground track, and circular on another part. |
| total         | A total eclipse. |
| halfshadow    | For lunar eclipses only. The moon is not hit by the full shadow, but because of the distance from earth being too large only hit by the penumbra (half shadow). |
