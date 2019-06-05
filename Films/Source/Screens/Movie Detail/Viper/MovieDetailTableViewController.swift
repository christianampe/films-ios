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

extension MovieDetailTableViewController {
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        presenter?.dismissButtonPressed()
    }
}

// MARK: - DetailViewProtocol
extension MovieDetailTableViewController {
    func show(_ input: MovieDetailInput) {
        posterImageView.image = input.poster
        titleLabel.text = input.title
        detailLabel.text = input.location
        
        let annotation = MKPointAnnotation()
        let coordinates = CLLocationCoordinate2D(latitude: input.latitude, longitude: input.longitude)
        
        annotation.coordinate = coordinates
        
        mapView.showAnnotations([annotation], animated: false)
    }
}

// MARK: - Lifecycle
extension MovieDetailTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MovieDetailTableViewController {
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0: // poster image
            return tableView.bounds.height * 0.6
        case 1: // description
            return tableView.bounds.height * 0.1
        case 2: // map view
            return tableView.bounds.height * 0.3
        default:
            assertionFailure("currently only support a header image cell and a map secondary cell")
            return 0.0
        }
    }
}
