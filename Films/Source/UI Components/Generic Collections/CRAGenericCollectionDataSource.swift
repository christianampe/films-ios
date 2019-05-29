//
//  CRAGenericCollectionDataSource.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRAGenericCollectionDataSourceProtocol {
    associatedtype CM
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    
    func cellModel(at indexPath: IndexPath) -> CM
    func updateCellModel(at indexPath: IndexPath, with model: CM)
}
