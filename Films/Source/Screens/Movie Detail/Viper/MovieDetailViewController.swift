//
//  DetailViewController.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    weak var delegate: MovieDetailDelegateProtocol?
    
    @IBOutlet private weak var collectionView: UICollectionView!
}

// MARK: - DetailViewProtocol
extension MovieDetailViewController {
    
}

// MARK: - Lifecycle
extension MovieDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UICollectionViewDataSource
extension MovieDetailViewController {
    
}

// MARK: - UICollectionViewDelegate
extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        // TODO: implement
    }
}
