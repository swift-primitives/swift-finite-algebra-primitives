# Finite Algebra Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

The integration surface where the finite capability meets the algebra classifications: a cyclic-group (ℤ/Nℤ) witness for every `Finite.Enumerable`, plus `Finite.Enumerable` conformances for the `Parity` and `Polarity` classifications.

---

## Quick Start

Any N-element `Finite.Enumerable` is isomorphic to the cyclic group **ℤ/Nℤ**: each value maps to an integer in `0..<N` via its `ordinal`, and the group operation is addition modulo `N`. This package confers that structure on every conformer through a single static accessor — `Algebra.Group<Element>.cyclic` — without reimplementing the group per type.

```swift
import Finite_Algebra_Primitives

// Parity is a 2-element Finite.Enumerable, so its cyclic group is ℤ/2ℤ.
let z2 = Algebra.Group<Parity>.cyclic

z2.identity            // .even   — the value at ordinal 0
z2(.even, .odd)        // .odd    — 0 + 1 mod 2
z2(.odd, .odd)         // .even   — 1 + 1 mod 2
z2.inverting(.odd)     // .odd    — every element is self-inverse in ℤ/2ℤ
```

The same accessor scales to any cardinality. `Polarity` has three values (`positive`, `negative`, `neutral`), so it yields ℤ/3ℤ:

```swift
import Finite_Algebra_Primitives

Polarity.count                  // 3
Polarity.negative.ordinal       // 1

let z3 = Algebra.Group<Polarity>.cyclic

z3(.negative, .negative)        // .neutral    — 1 + 1 mod 3 = 2
z3(.negative, .neutral)         // .positive   — 1 + 2 mod 3 = 0
z3.inverting(.negative)         // .neutral    — 3 − 1 mod 3 = 2
```

Importing `Finite_Algebra_Primitives` re-exports all four bridged primitives — the `Finite` capability, the `Algebra` and `Algebra.Group` machinery, and the `Parity` / `Polarity` classifications — so the conformances and the group are visible from one import.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-finite-algebra-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Finite Algebra Primitives", package: "swift-finite-algebra-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

One library product plus its test-support spine. This package adds no new types: it bridges four existing primitives — `swift-finite-primitives`, `swift-algebra-primitives`, `swift-parity-primitives`, and `swift-polarity-primitives` — and re-exports them.

| Product | Target | Purpose |
|---------|--------|---------|
| `Finite Algebra Primitives` | `Sources/Finite Algebra Primitives/` | The integration surface: `Algebra.Group<Element>.cyclic` (the ℤ/Nℤ group over any `Finite.Enumerable`), `Finite.Enumerable` conformances for `Parity` and `Polarity`, and a re-export of the four bridged primitives. |
| `Finite Algebra Primitives Test Support` | `Tests/Support/` | Re-exports the main target and the upstream algebra test support for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
