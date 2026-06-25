// Algebra.Group+Finite.Enumerable.swift

public import Algebra_Group_Primitives
public import Finite_Primitives

// MARK: - Generic Cyclic (ℤ/Nℤ) Group over Finite.Enumerable

/// Cyclic-group witnesses for any finite enumerable type.
///
/// An N-element `Finite.Enumerable` is isomorphic to the cyclic group **ℤ/Nℤ**
/// via its `ordinal` bijection: each value maps to an integer in `0..<N`, and
/// the group operation is addition modulo `N`. This generic witness confers
/// that structure on *every* conformer — `Interval.Bound`, `Interval.Boundary`,
/// `Interval.Endpoint`, the order types (`Order.Direction`, `Order.Monotonicity`),
/// the algebra classifications (`Parity`, `Polarity`), `Comparison`, the numeric
/// classifications (`Numeric.Sign`, `Numeric.Ternary`), and any user
/// `Finite.Enumerable` — regardless of the conformer's home domain.
///
/// - Identity: the value at ordinal `0`.
/// - Combining: `a ∗ b` is the value at ordinal `(a.ordinal + b.ordinal) mod N`.
/// - Inverting: `a⁻¹` is the value at ordinal `(N − a.ordinal) mod N`.
///
/// For the two-element case (`N == 2`) this is exactly the Z₂ group that the
/// per-type witnesses previously expressed; for larger `N` it is the general
/// cyclic group.
///
/// ## Example
///
/// ```swift
/// let group = Algebra.Group<Interval.Bound>.cyclic
/// group(.lower, .upper)        // .upper  (0 + 1 mod 2)
/// group(.upper, .upper)        // .lower  (1 + 1 mod 2)
/// ```
extension Algebra.Group where Element: Finite.Enumerable {
    /// The cyclic group ℤ/Nℤ over this finite enumerable type.
    @inlinable
    public static var cyclic: Self {
        .init(
            identity: Element(_unchecked: (), ordinal: .zero),
            combining: { lhs, rhs in
                let modulus = Element.count.rawValue
                let sum = (lhs.ordinal.rawValue + rhs.ordinal.rawValue) % modulus
                return Element(_unchecked: (), ordinal: Ordinal(sum))
            },
            inverting: { value in
                let modulus = Element.count.rawValue
                let inverse = (modulus - value.ordinal.rawValue) % modulus
                return Element(_unchecked: (), ordinal: Ordinal(inverse))
            }
        )
    }
}
