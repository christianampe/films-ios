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
        style()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.image = nil
    }
}

// MARK: - Public API
extension MoviesNestedCollectionViewItemCell {
    func configure(for state: MoviesNestedCollectionViewItemViewModel.LoadingState) {
        switch state {
        case .complete(let image):
            backgroundImageView.image = image
        case .failed:
            backgroundImageView.image = #imageLiteral(resourceName: "missing-image")
        default:
            break
        }
    }
}

// MARK: - MoviesNestedCollectionViewItemViewModelDelegate
extension MoviesNestedCollectionViewItemCell: MoviesNestedCollectionViewItemViewModelDelegate {
    func viewModel(_ viewModel: MoviesNestedCollectionViewItemViewModel,
                   didTransitionToState state: MoviesNestedCollectionViewItemViewModel.LoadingState) {
        
        configure(for: state)
    }
}

// MARK: - Style Methods
private extension MoviesNestedCollectionViewItemCell {
    func style() {
        layer.cornerRadius = 3
    }
}
