//
//  JSONDecoder++.swift
//  Films
//
//  Created by Christian Ampe on 5/30/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

extension JSONDecoder {
    convenience init(_ keyDecodingStrategy: KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}
