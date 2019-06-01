//
//  MoviesViewController.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {
    var presenter: MoviesPresenterProtocol?
    weak var delegate: MoviesDelegateProtocol?
    
    private var nestedCollection: MoviesNestedCollectionViewController!
    private var navigationDropdown: CRANavigationDropdownViewController!
}

// MARK: - Lifecycle
extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDropdown = CRANavigationDropdownViewController(self)
        presenter?.viewDidLoad()
        navigationDropdown.set(["Ballz", "Boobz", "Booze", "Buttz"])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueCase(for: segue) {
        case .embedNestedCollection:
            nestedCollection = segue.viewController()
            nestedCollection.delegate = presenter
            nestedCollection.dataSource = presenter
        }
    }
}

// MARK: - MoviesViewProtocol
extension MoviesViewController: MoviesViewProtocol {
    func show(movies: [Netflix.Networking.Responses.Movie]) {
        nestedCollection.reloadData()
    }
    
    func show(error: Error) {
        // TODO: handle error
    }
}

// MARK: - SegueIdentifiable
extension MoviesViewController: SegueIdentifiable {
    enum Segue: String {
        case embedNestedCollection
    }
}
