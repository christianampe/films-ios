//
//  CRANestedCollectionViewDataSource.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRANestedCollectionViewDataSource: class {
    func numberOfRows(in nestedCollectionViewController: CRANestedCollectionViewController) -> Int
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        numberOfItemsInRow row: Int) -> Int
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        titleForRow row: Int) -> String
}
