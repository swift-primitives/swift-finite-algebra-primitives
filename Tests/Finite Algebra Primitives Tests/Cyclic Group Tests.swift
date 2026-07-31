// Cyclic Group Tests.swift

import Finite_Algebra_Primitives_Test_Support
import Testing

@testable import Finite_Algebra_Primitives

// MARK: - Generic ℤ/Nℤ witness, N = 2 (Parity)

@Suite
struct `Cyclic Group - Z2 over Parity` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Cyclic Group - Z2 over Parity`.Unit {
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
}

extension `Cyclic Group - Z2 over Parity`.`Edge Case` {
    @Test
    func `every element is self-inverse`() {
        let group = Algebra.Group<Parity>.cyclic
        #expect(group.inverting(.even) == .even)
        #expect(group.inverting(.odd) == .odd)
    }
}

// MARK: - Classification conformances

@Suite
struct `Classification Finite Conformances` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Classification Finite Conformances`.Unit {
    @Test
    func `parity count and ordinals`() {
        #expect(Parity.count == 2)
        #expect(Parity.even.ordinal == 0)
        #expect(Parity.odd.ordinal == 1)
    }
}
