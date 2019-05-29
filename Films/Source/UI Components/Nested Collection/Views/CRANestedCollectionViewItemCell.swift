//
//  UINestedCollectionViewItemCell.swift
//  Films
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class CRANestedCollectionViewItemCell: UICollectionViewCell {
    
    /// The `UImageView` filling the entire background of this cell.
    @IBOutlet private weak var backgroundImageView: UIImageView!
}

// MARK: - External API
extension CRANestedCollectionViewItemCell {
    
    /// Method used to populate the cell with given properties.
    ///
    /// - Parameter viewModel: The view model used to populate the UI elements.
    func configure(with viewModel: CRANestedCollectionViewItem) {
        guard let url = URL(string: viewModel.backgroundImageURLString) else {
            return
        }
        
        backgroundImageView.setImage(with: url)
    }
}
