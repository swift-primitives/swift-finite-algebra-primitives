// Polarity+Finite.swift

public import Algebra_Primitives
public import Finite_Primitives

extension Polarity: @retroactive Finite.Enumerable {
    /// Number of polarity values.
    @inlinable
    public static var count: Cardinal { 3 }

    /// Ordinal of this value (0: positive, 1: negative, 2: neutral).
    @inlinable
    public var ordinal: Ordinal {
        switch self {
        case .positive: 0
        case .negative: 1
        case .neutral: 2
        }
    }

    /// Creates a value from its ordinal.
    @inlinable
    public init(_unchecked: Void, ordinal: Ordinal) {
        self = [.positive, .negative, .neutral][ordinal]
    }
}
