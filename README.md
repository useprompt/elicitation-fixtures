# elicitation-fixtures

Sample iOS host apps used to exercise Prompt **onboarding** elicitation.

Onboarding starts by discovering how the host app is built (localization stores, SwiftUI copy patterns, UI tokens/forms, service layer shape, and related facets).

## Layout

```
onboarding/
  cosmos-catalog-all-mixed/
  cosmos-catalog-varied/
```

## cosmos-catalog-all-mixed

SwiftUI catalog of charted worlds: browse planetary parameters, field notes, and an observing queue.

Discovery profile: dual signals per facet so host discovery can observe `mixed` across the board.

## cosmos-catalog-varied

Same catalog product surface as `cosmos-catalog-all-mixed`, with a different host-discovery profile: one clear non-mixed observation per facet, varied across facets.
