//
//  MoviesViewController.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController, MoviesViewProtocol {
    var input: MoviesInputProtocol?
    var viewModel: MoviesViewModelProtocol?
    var output: MoviesOutputProtocol?
    
    var presenter: MoviesPresenterProtocol?
    weak var delegate: MoviesDelegateProtocol?
    
    private var nestedCollection: CRANestedCollectionViewController!
    private lazy var navigationDropdown = CRANavigationDropdownViewController(self)
}

// MARK: - Viper
extension MoviesViewController {
    func show(movies: [Netflix.Networking.Responses.Movie]) {
        viewModel?.movies = movies
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
            nestedCollection.dataSource = viewModel
        }
    }
}

// MARK: - SegueIdentifiable
extension MoviesViewController: SegueIdentifiable {
    enum Segue: String {
        case embedNestedCollection
    }
}
