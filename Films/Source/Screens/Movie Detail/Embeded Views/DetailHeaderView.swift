//
//  DetailHeaderView.swift
//  Places
//
//  Created by Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol DetailHeaderViewDelegate: class {
    func didTapDirectionsButton()
}

extension DetailHeaderViewDelegate {
    func didTapDirectionsButton() {}
}

final class DetailHeaderView: UICollectionReusableView {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var directionsButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    weak var delegate: DetailHeaderViewDelegate?
}

// MARK: - IBOutlets
extension DetailHeaderView {
    @IBAction func didSelectDirectionsButton(_ sender: UIButton) {
        delegate?.didTapDirectionsButton()
    }
}

// MARK: - Public API
extension DetailHeaderView {
    
}

// MARK: - UICollectionViewDataSource
extension DetailHeaderView {
    
}

// MARK: - UICollectionViewDelegate
extension DetailHeaderView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailHeaderView: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Static Properties
extension DetailHeaderView {
    
}
