//
//  NullEncodable.swift
//  swift-paperless
//
//  Created by Paul Gessinger on 12.08.23.
//

import Foundation

@propertyWrapper
struct NullCodable<T> {
    var wrappedValue: T?

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
}

extension NullCodable: Encodable where T: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch wrappedValue {
        case .none:
            try container.encodeNil()
        case .some(let value):
            try container.encode(value)
        }
    }
}

extension NullCodable: Decodable where T: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            wrappedValue = try container.decode(T.self)
        }
    }
}

extension NullCodable: Equatable where T: Equatable {}
extension NullCodable: Hashable where T: Hashable {}
