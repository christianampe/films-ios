//
//  DetailViewController.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit
import MapKit

final class MovieDetailTableViewController: UITableViewController, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    weak var delegate: MovieDetailDelegateProtocol?
    
    
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    @IBOutlet private weak var mapView: MKMapView!
}

// MARK: - DetailViewProtocol
extension MovieDetailTableViewController {
    
}

// MARK: - Lifecycle
extension MovieDetailTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UICollectionViewDataSource
extension MovieDetailTableViewController {
    
}

// MARK: - UICollectionViewDelegate
extension MovieDetailTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        // TODO: implement
    }
}
