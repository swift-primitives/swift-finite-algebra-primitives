// Cyclic Group Tests.swift

import Finite_Algebra_Primitives_Test_Support
import Testing

@testable import Finite_Algebra_Primitives

// MARK: - Generic ℤ/Nℤ witness, N = 2 (Parity)

@Suite
struct `Cyclic Group - Z2 over Parity` {
    @Test
    func `identity is even`() {
        let group = Algebra.Group<Parity>.cyclic
        #expect(group.identity == .even)
    }

    @Test
    func `addition modulo 2`() {
        let group = Algebra.Group<Parity>.cyclic
        #expect(group(.even, .even) == .even)
        #expect(group(.even, .odd) == .odd)
        #expect(group(.odd, .even) == .odd)
        #expect(group(.odd, .odd) == .even)
    }

    @Test
    func `every element is self-inverse`() {
        let group = Algebra.Group<Parity>.cyclic
        #expect(group.inverting(.even) == .even)
        #expect(group.inverting(.odd) == .odd)
    }
}

// MARK: - Generic ℤ/Nℤ witness, N = 3 (Sign)

@Suite
struct `Cyclic Group - Z3 over Sign` {
    @Test
    func `addition modulo 3`() {
        // Sign ordinals: positive=0, negative=1, zero=2.
        let group = Algebra.Group<Sign>.cyclic
        #expect(group.identity == .positive)             // ordinal 0
        #expect(group(.negative, .negative) == .zero)    // 1+1 = 2
        #expect(group(.negative, .zero) == .positive)    // 1+2 = 3 mod 3 = 0
        #expect(group(.zero, .zero) == .negative)        // 2+2 = 4 mod 3 = 1
    }

    @Test
    func `inverse via modular negation`() {
        let group = Algebra.Group<Sign>.cyclic
        // inverse of ordinal 1 (negative) is ordinal 2 (zero); 1+2 = 0.
        #expect(group.inverting(.negative) == .zero)
        // inverse of ordinal 2 (zero) is ordinal 1 (negative); 2+1 = 0.
        #expect(group.inverting(.zero) == .negative)
        // identity is its own inverse.
        #expect(group.inverting(.positive) == .positive)
    }
}

// MARK: - Classification conformances

@Suite
struct `Classification Finite Conformances` {
    @Test
    func `parity count and ordinals`() {
        #expect(Parity.count == 2)
        #expect(Parity.even.ordinal == 0)
        #expect(Parity.odd.ordinal == 1)
    }

    @Test
    func `monotonicity is enumerable`() {
        #expect(Monotonicity.count == 3)
        #expect(Monotonicity.increasing.ordinal == 0)
    }

    @Test
    func `ternary is enumerable`() {
        #expect(Ternary.count == 3)
        #expect(Ternary.negative.ordinal == 0)
        #expect(Ternary.positive.ordinal == 2)
    }
}
