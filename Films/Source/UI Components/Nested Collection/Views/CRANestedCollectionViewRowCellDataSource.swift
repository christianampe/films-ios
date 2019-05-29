//
//  CRANestedCollectionViewRowCellDataSource.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRANestedCollectionViewRowCellDataSource: class {
    func numberOfItems(in nestedCollectionViewRowCell: CRANestedCollectionViewRowCell) -> Int
    
    func nestedCollectionViewRowCell(_ nestedCollectionViewRowCell: CRANestedCollectionViewRowCell,
                                     viewModelAtIndex index: Int) -> CRANestedCollectionViewRowCellViewModelProtocol
}
