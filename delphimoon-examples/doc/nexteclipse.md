
## NextEclipse

Calculates the next eclipse.

```pascal
function NextEclipse(var date:TDateTime; sun:boolean):TEclipse;
```

Calculates the next eclipse after the given date. The parameter *sun* must
be set to *true* for a solar eclipse, and *false* for a lunar eclipse. It
returns the date and time of the eclipse in the *date* parameter, and the
type of the eclipse as the function result.
