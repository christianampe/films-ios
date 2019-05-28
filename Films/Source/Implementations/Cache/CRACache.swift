//
//  CRACache.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRACacheProtocol {
    associatedtype T: AnyObject
    
    func setObject(_ object: T, forKey key: NSString)
    func object(forKey key: NSString) -> T?
}

class CRACache<T: AnyObject>: CRACacheProtocol {
    
}

extension CRACache {
    func setObject(_ object: T, forKey key: NSString) {
        
    }
    
    func object(forKey key: NSString) -> T? {
        return nil
    }
}
