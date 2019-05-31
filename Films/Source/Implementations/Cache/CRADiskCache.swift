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
    func setObject(_ object: T, forKey key: String) {
        
    }
    
    func object(forKey key: String) -> T? {
        return nil
    }
}
