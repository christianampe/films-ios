//
//  CRAUserDefaultable.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRABoolUserDefaultable: CRAKeyNamespaceable {
    associatedtype BoolDefaultKey: RawRepresentable
}

protocol FloatUserDefaultable: CRAKeyNamespaceable {
    associatedtype FloatDefaultKey: RawRepresentable
}

protocol IntegerUserDefaultable: CRAKeyNamespaceable {
    associatedtype IntegerDefaultKey: RawRepresentable
}

protocol ObjectUserDefaultable: CRAKeyNamespaceable {
    associatedtype ObjectDefaultKey: RawRepresentable
}

protocol DoubleUserDefaultable: CRAKeyNamespaceable {
    associatedtype DoubleDefaultKey: RawRepresentable
}

protocol URLUserDefaultable: CRAKeyNamespaceable {
    associatedtype URLDefaultKey: RawRepresentable
}

protocol ArrayUserDefaultable: CRAKeyNamespaceable {
    associatedtype ArrayDefaultKey: RawRepresentable
}

extension CRABoolUserDefaultable where BoolDefaultKey.RawValue == String {
    static func set(_ bool: Bool, forKey key: BoolDefaultKey) {
        UserDefaults.standard.set(bool, forKey: namespace(key))
    }
    
    static func bool(forKey key: BoolDefaultKey) -> Bool {
        return UserDefaults.standard.bool(forKey: namespace(key))
    }
}

extension FloatUserDefaultable where FloatDefaultKey.RawValue == String {
    static func set(_ float: Float, forKey key: FloatDefaultKey) {
        UserDefaults.standard.set(float, forKey: namespace(key))
    }
    
    static func float(forKey key: FloatDefaultKey) -> Float {
        return UserDefaults.standard.float(forKey: namespace(key))
    }
}

extension IntegerUserDefaultable where IntegerDefaultKey.RawValue == String {
    static func set(_ integer: Int, forKey key: IntegerDefaultKey) {
        UserDefaults.standard.set(integer, forKey: namespace(key))
    }
    
    static func integer(forKey key: IntegerDefaultKey) -> Int {
        return UserDefaults.standard.integer(forKey: namespace(key))
    }
}

extension ObjectUserDefaultable where ObjectDefaultKey.RawValue == String {
    static func set(_ object: AnyObject, forKey key: ObjectDefaultKey) {
        UserDefaults.standard.set(object, forKey: namespace(key))
    }
    
    static func object(forKey key: ObjectDefaultKey) -> Any? {
        return UserDefaults.standard.object(forKey: namespace(key))
    }
}

extension DoubleUserDefaultable where DoubleDefaultKey.RawValue == String {
    static func set(_ double: Double, forKey key: DoubleDefaultKey) {
        UserDefaults.standard.set(double, forKey: namespace(key))
    }
    
    static func double(forKey key: DoubleDefaultKey) -> Double {
        return UserDefaults.standard.double(forKey: namespace(key))
    }
}

extension URLUserDefaultable where URLDefaultKey.RawValue == String {
    static func set(_ url: URL, forKey key: URLDefaultKey) {
        UserDefaults.standard.set(url, forKey: namespace(key))
    }
    
    static func url(forKey key: URLDefaultKey) -> URL? {
        return UserDefaults.standard.url(forKey: namespace(key))
    }
}

extension ArrayUserDefaultable where ArrayDefaultKey.RawValue == String {
    static func set(_ array: [Any], forKey key: ArrayDefaultKey) {
        UserDefaults.standard.set(array, forKey: namespace(key))
    }
    
    static func array(forKey key: ArrayDefaultKey) -> [Any]? {
        return UserDefaults.standard.array(forKey: namespace(key))
    }
}
