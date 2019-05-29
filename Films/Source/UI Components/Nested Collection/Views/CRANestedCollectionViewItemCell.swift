//
//  UINestedCollectionViewItemCell.swift
//  Films
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class CRANestedCollectionViewItemCell: UICollectionViewCell {
    
    /// The `UILabel` controlling the main text of this cell.
    @IBOutlet private weak var title: UILabel!
    
    /// The `UImageView` filling the entire background of this cell.
    @IBOutlet private weak var background: UIImageView!
    
    // MARK: Constraints
    @IBOutlet weak var contentLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var contentBottomSpace: NSLayoutConstraint!
}

// MARK: - External API
extension CRANestedCollectionViewItemCell {
    
    /// Method used to populate the cell with given properties.
    ///
    /// - Parameter viewModel: The view model used to populate the UI elements.
    func configure(with viewModel: CRANestedCollectionViewRowCellViewModelProtocol) {
        
    }
}
