//
//  KeyNamespaceable.swift
//  WeedmapsChallenge
//
//  Created by Christian Ampe on 5/27/19.
//

import Foundation

protocol KeyNamespaceable {}

extension KeyNamespaceable {
    private static func namespace(_ key: String) -> String {
        return "\(Self.self).\(key)"
    }
    
    static func namespace<T: RawRepresentable>(_ key: T) -> String where T.RawValue == String {
        return namespace(key.rawValue)
    }
}
