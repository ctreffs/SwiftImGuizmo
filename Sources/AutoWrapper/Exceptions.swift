//
//  Exceptions.swift
//
//
//  Created by Christian Treffs on 26.10.19.
//

// Conversion process is not perfect yet so we have a small list of exceptions
public enum Exceptions {
    /// Set of missing functions that are not exposed to Swift automatically,
    /// but are present in definitions.json
    ///
    /// causes "Use of unresolved identifier '...'" compiler error.
    public static let unresolvedIdentifier: Set<String> = []

    /// causes "Use of undeclared type '...'" compiler error.
    public static let undeclardTypes: [String: Declaration] = [:]

    public static let stripPrefix: Set<String> = [
        "ig"
    ]
}

public struct Declaration {
    public let name: String
    public let typealiasType: String
    public var dataType: DataType {
        DataType(meta: .primitive, type: .custom(name), isConst: true)
    }
}

extension Declaration: Equatable { }
extension Declaration: Hashable { }
