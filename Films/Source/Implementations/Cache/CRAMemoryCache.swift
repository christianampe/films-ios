//
//  CRAMemoryCache.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

class CRAMemoryCache<T: Any>: CRACacheProtocol {
    private let storage = NSCache<NSString, AnyObject>()
}

extension CRAMemoryCache {
    func setObject(_ object: T, forKey key: NSString) {
        guard let classObject = classObject(from: object) else {
            assertionFailure("this point should never be reached")
            return
        }
        
        storage.setObject(classObject, forKey: key)
    }
    
    func object(forKey key: NSString) -> T? {
        guard let object = storage.object(forKey: key) as? T else {
            assertionFailure("corrupt data types")
            return nil
        }
        
        return object
    }
}

private extension CRAMemoryCache {
    func classObject(from object: T) -> AnyObject? {
        guard let displayStyle = Mirror(reflecting: object).displayStyle else {
            assertionFailure("internal apple bug")
            return nil
        }
        
        switch displayStyle {
        case .class:
            return object as AnyObject
        case .struct:
            return CRAStructContainer(object: object)
        default:
            assertionFailure("\(displayStyle) is not currently supported in the cache")
            return nil
        }
    }
}

private class CRAStructContainer<T: Any> {
    let object: T
    
    init(object: T) {
        self.object = object
    }
}

