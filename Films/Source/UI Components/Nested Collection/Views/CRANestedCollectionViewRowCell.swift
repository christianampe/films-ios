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
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = delegate
            collectionView.dataSource = dataSource
        }
    }
    
    var index: Int!
    
    weak var delegate: UICollectionViewDelegate?
    weak var dataSource: UICollectionViewDataSource?
}

// MARK: - External API
extension CRANestedCollectionViewRowCell {
    func reloadData() {
        collectionView.reloadData()
    }
}
