//
//  MoviesNestedCollectionViewRowCell.swift
//  Films
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class MoviesNestedCollectionViewRowCell: UITableViewCell {
    
    /// A `UICollectionView` which contains the individual objects to display.
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var index: Int!
    
    weak var delegate: MoviesNestedCollectionViewRowCellDelegate?
    weak var dataSource: MoviesNestedCollectionViewRowCellDataSource?
}

// MARK: - External API
extension MoviesNestedCollectionViewRowCell {
    func reloadData() {
        collectionView.reloadData()
    }
}

extension MoviesNestedCollectionViewRowCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? MoviesNestedCollectionViewItemCell else {
            assertionFailure("incorrect cell type used")
            return
        }

        delegate?.collectionView(collectionView,
                                 willDisplay: cell,
                                 forItemAt: IndexPath(row: indexPath.item,
                                                      section: index))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? MoviesNestedCollectionViewItemCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        delegate?.collectionView(collectionView,
                                 didEndDisplaying: cell,
                                 forItemAt: IndexPath(row: indexPath.item,
                                                      section: index))
    }
}

extension MoviesNestedCollectionViewRowCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataSource?.collectionView(collectionView,
                                          numberOfItemsInSection: index) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(for: indexPath) as MoviesNestedCollectionViewItemCell
    }
}
