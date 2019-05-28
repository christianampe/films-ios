//
//  MemoryCache.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol MemoryCacheProtocol {
    associatedtype Value: AnyObject
    
    func setObject(_ object: Value, forKey key: NSString)
    func object(forKey key: NSString) -> Value?
}

class MemoryCache<Value: AnyObject>: MemoryCacheProtocol {
    private let storage = NSCache<NSString, Value>()
}

extension MemoryCache {
    func setObject(_ object: Value, forKey key: NSString) {
        storage.setObject(object, forKey: key)
    }
    
    func object(forKey key: NSString) -> Value? {
        return storage.object(forKey: key)
    }
}
