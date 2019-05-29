//
//  UINestedCollectionViewRowCell.swift
//  Films
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class CRANestedCollectionViewRowCell: UITableViewCell {
    
    /// A `UICollectionView` which contains the individual objects to display.
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var rowIndex: Int!
    
    /// Collection view delegation.
    weak var dataSource: CRANestedCollectionViewRowCellDataSource!
    weak var delegate: CRANestedCollectionViewRowCellDelegate!
}

// MARK: - External API
extension CRANestedCollectionViewRowCell {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension CRANestedCollectionViewRowCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.numberOfItems(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CRANestedCollectionViewItemCell
        
        if let viewModel = dataSource.nestedCollectionViewRowCell(self, viewModelAtIndex: indexPath.row) {
            cell.configure(with: viewModel)
        }
        
        return cell
    }
}
