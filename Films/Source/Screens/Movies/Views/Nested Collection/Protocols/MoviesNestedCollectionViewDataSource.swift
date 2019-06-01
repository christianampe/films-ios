//
//  MoviesNestedCollectionViewDataSource.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol MoviesNestedCollectionViewDataSource: class {
    func numberOfRows(in nestedCollectionViewController: MoviesNestedCollectionViewController) -> Int
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        numberOfItemsInRow row: Int) -> Int
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        titleForRow row: Int) -> String
}
