//
//  UINestedCollectionViewItemCell.swift
//  Films
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol UINestedCollectionViewItemCellDelegate: class {
    func collectionView(_ collectionView: UICollectionView,
                        didDisplayCellAt index: Int)
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt index: Int)
}

extension UINestedCollectionViewItemCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didDisplayCellAt index: Int) {}
}

class UINestedCollectionViewItemCell: UITableViewCell {
    
    /// A `UICollectionView` which contains the individual objects to display.
    @IBOutlet private weak var collectionView: UICollectionView!
    
    /// The view models used to populate the `UICollectionView`.
    private var viewModels = [UINestedCollectionViewRowCellViewModelProtocol]()
    
    /// Collection view delegation.
    weak var delegate: UINestedCollectionViewItemCellDelegate?
}

// MARK: - External API
extension UINestedCollectionViewItemCell {
    
    /// Method used to populate the collection view with given properties.
    ///
    /// - Parameter newViewModels: The view models used to populate the `UICollectionView`.
    func set(properties newViewModels: [UINestedCollectionViewRowCellViewModelProtocol]) {
        viewModels = newViewModels
        collectionView.reloadData()
    }
    
    /// Method used to scroll to the given item in the collection.
    ///
    /// - Parameters:
    ///   - index: Position of the item requested.
    ///   - animated: Bool indicating whether the scroll should be animated or not.
    func focus(index: Int,
               animated: Bool = true) {
        
        guard index < viewModels.count else {
            return
        }
        
        collectionView.scrollToItem(at: IndexPath(row: index,
                                                  section: 0),
                                    at: .left,
                                    animated: animated)
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewItemCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.decelerationRate = .fast
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        focus(index: 0, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension UINestedCollectionViewItemCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewRowCell
        
        guard let viewModel = viewModels[safe: indexPath.row] else {
            return cell
        }
        
        cell.set(properties: viewModel)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UINestedCollectionViewItemCell: UICollectionViewDelegateFlowLayout {
    
}
