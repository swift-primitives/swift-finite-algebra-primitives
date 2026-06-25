# ``Finite_Algebra_Primitives``

The single `finite ⊗ algebra` integration surface.

## Overview

`swift-finite-algebra-primitives` is the one bridge holding the entire
integration between the `Finite.Enumerable` capability and the `Algebra`
classifications. It depends on `swift-finite-primitives`,
`swift-algebra-primitives`, and `swift-algebra-group-primitives`, and provides:

- **The generic cyclic-group witness** — `Algebra.Group<Element>.cyclic` for any
  `Element: Finite.Enumerable`. An N-element `Finite.Enumerable` is isomorphic
  to ℤ/Nℤ via its `ordinal` bijection, so this witness confers cyclic-group
  structure on *every* conformer (`Interval.Bound`, `Interval.Boundary`,
  `Interval.Endpoint`, the algebra classifications, `Comparison`, …) without a
  per-type witness. For the two-element case it is exactly the Z₂ group the
  per-type witnesses previously expressed.

- **The algebra-classification `Finite.Enumerable` conformances** —
  `Parity` and `Polarity` (declared in `swift-algebra-primitives`) are conformed
  to `Finite.Enumerable` (declared in `swift-finite-primitives`) here, because the
  conformance needs *both* packages and belongs in neither. These are retroactive
  conformances per [API-IMPL-018] (the bridge owns neither the types nor the
  protocol). The numeric classifications `Numeric.Sign` and `Numeric.Ternary`
  carry the analogous conformance in `swift-finite-primitives`' `Finite Numeric
  Primitives` integration target, not here.

This placement is what lets `swift-finite-primitives` drop its dependency on
`swift-algebra-primitives` / `swift-algebra-group-primitives`: the directions of
the `finite ⊗ algebra` integration (the generic witness AND the classification
conformances) both live here, downstream of finite and algebra.
