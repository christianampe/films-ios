//
//  CRACache.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRACacheProtocol {
    associatedtype T: Any
    
    func setObject(_ object: T, forKey key: String)
    func object(forKey key: String) -> T?
}

class CRACache<T: Any>: CRACacheProtocol {
    
}

extension CRACache {
    func setObject(_ object: T, forKey key: String) {
        
    }
    
    func object(forKey key: String) -> T? {
        return nil
    }
}
