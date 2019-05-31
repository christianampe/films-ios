//
//  CRANestedCollectionViewRowCellDataSource.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UICollectionView

protocol CRANestedCollectionViewRowCellDataSource: class {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
}
