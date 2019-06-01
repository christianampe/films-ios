//
//  MoviesNestedCollectionViewItemCell.swift
//  Films
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class MoviesNestedCollectionViewItemCell: UICollectionViewCell {
    
    /// The `UImageView` filling the entire background of this cell.
    @IBOutlet private weak var backgroundImageView: UIImageView!
}

// MARK: - Lifecycle
extension MoviesNestedCollectionViewItemCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 3
        clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.image = nil
    }
}

// MARK: - MoviesNestedCollectionViewItemViewModelDelegate
extension MoviesNestedCollectionViewItemCell: MoviesNestedCollectionViewItemViewModelDelegate {
    func viewModel(_ viewModel: MoviesNestedCollectionViewItemViewModel,
                   didTransitionToState state: MoviesNestedCollectionViewItemViewModel.LoadingState) {
        
        switch state {
        case .complete(let image):
            backgroundImageView.image = image
        default:
            break
        }
    }
}
