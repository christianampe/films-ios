//
//  UINestedCollectionViewRowCell.swift
//  Films
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class UINestedCollectionViewRowCell: UICollectionViewCell {
    
    /// The `UILabel` controlling the main text of this cell.
    @IBOutlet private weak var title: UILabel!
    
    /// The `UImageView` filling the entire background of this cell.
    @IBOutlet private weak var background: UIImageView!
    
    // MARK: Constraints
    @IBOutlet weak var contentLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var contentBottomSpace: NSLayoutConstraint!
}

// MARK: - External API
extension UINestedCollectionViewRowCell {
    
    /// Method used to populate the cell with given properties.
    ///
    /// - Parameter viewModel: The view model used to populate the UI elements.
    func set(properties viewModel: UINestedCollectionViewRowCellViewModelProtocol) {
        title.text = viewModel.name
        
        guard let url = URL(string: viewModel.backgroundURLString) else {
            return
        }
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewRowCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCell()
        setContentConstraints()
    }
}

// MARK: - Set Up Methods
private extension UINestedCollectionViewRowCell {
    func styleCell() {
        layer.cornerRadius = 5
    }
    
    func setContentConstraints() {
        let cellHeight = layer.bounds.size.height
        
        contentLeadingSpace.constant = cellHeight * 0.1
        contentBottomSpace.constant = cellHeight * 0.1
    }
}
