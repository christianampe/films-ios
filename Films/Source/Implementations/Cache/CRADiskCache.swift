//
//  CRADiskCache.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

class CRADiskCache<T: AnyObject>: CRACacheProtocol {
    private let queue = DispatchQueue(label: "io.cra.diskcache")
}

extension CRADiskCache {
    func setObject(_ object: T, forKey key: NSString) {
        
    }
    
    func object(forKey key: NSString) -> T? {
        return nil
    }
}
