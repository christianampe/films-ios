//
//  CRAGenericCollectionCellProtocol.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRAGenericCollectionCellProtocol {
    associatedtype CM
    
    func configure(with item: CM)
}
