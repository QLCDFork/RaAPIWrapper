//
//  AnyAPIHashableParameter.swift
//  RaAPIWrapper
//
//  Created by Rakuyo on 2022/12/15.
//  Copyright © 2022 Rakuyo. All rights reserved.
//

import Foundation

/// API parameters.
public typealias APIHashableParameter = AnyAPIHashableParameter.Input

/// Make `Encodable` follow `Hashable` protocol.
public struct AnyAPIHashableParameter: AnyAPIHashable {
    public typealias Value = Encodable
    
    public typealias Input = Value & Hashable
    
    public let value: Value
    
    public let equals: (Value) -> Bool
    
    public let hash: (_ hasher: inout Hasher) -> Void
    
    public init<T: Input>(_ value: T) {
        self.value = value
        self.equals = { ($0 as? T == value) }
        self.hash = { $0.combine(value) }
    }
}

// MARK: - Encodable

extension AnyAPIHashableParameter: Encodable {
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
