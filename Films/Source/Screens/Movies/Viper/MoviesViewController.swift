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
    
    private var nestedCollection: CRANestedCollectionViewController!
    private lazy var navigationDropdown = CRANavigationDropdownViewController(self)
}

extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

// MARK: - MoviesViewProtocol
extension MoviesViewController: MoviesViewProtocol {
    func show(movies: [Netflix.Networking.Responses.Movie]) {
        nestedCollection.reloadData()
    }
    
    func show(info: OMDB.Networking.Responses.Info) {
        
    }
    
    func show(error: Error) {
        // TODO: handle error
    }
}

// MARK: - Lifecycle
extension MoviesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueCase(for: segue) {
        case .embedNestedCollection:
            nestedCollection = segue.viewController()
            nestedCollection.delegate = presenter
            nestedCollection.dataSource = presenter
        }
    }
}

// MARK: - SegueIdentifiable
extension MoviesViewController: SegueIdentifiable {
    enum Segue: String {
        case embedNestedCollection
    }
}
