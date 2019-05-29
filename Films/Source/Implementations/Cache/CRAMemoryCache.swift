//
//  CRAMemoryCache.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

class CRAMemoryCache<T: AnyObject>: CRACacheProtocol {
    private let storage = NSCache<NSString, T>()
}

extension CRAMemoryCache {
    func setObject(_ object: T, forKey key: NSString) {
        storage.setObject(object, forKey: key)
    }
    
    func object(forKey key: NSString) -> T? {
        return storage.object(forKey: key)
    }
}
