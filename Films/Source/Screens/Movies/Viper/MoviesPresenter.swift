//
//  MoviesPresenter.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MoviesPresenter: MoviesPresenterProtocol {
    weak var view: MoviesViewProtocol?
    var interactor: MoviesInteractorProtocol?
    var router: MoviesRouterProtocol?
    
    private lazy var viewModel = MoviesViewModel()
}

// MARK: - VIEW TO INTERACTOR
extension MoviesPresenter {
    func viewDidLoad() {
        viewModel.delegate = self
        interactor?.fetchMovies()
    }
}

// MARK: - INTERACTOR TO VIEW
extension MoviesPresenter {
    func fetched(movies: [Netflix.Networking.Responses.Movie]) {
        viewModel.set(movies: movies)
        viewModel.filter(by: .releaseYear)
    }
    
    func encountered(error: Netflix.Networking.Error) {
        view?.show(error: error)
    }
}

// MARK: - MoviesViewModelDelegate
extension MoviesPresenter: MoviesViewModelDelegate {
    func moviesViewModel(_ moviesViewModel: MoviesViewModel,
                         didFinishAnalyzingMovies movies: [Netflix.Networking.Responses.Movie],
                         with filter: Netflix.Networking.Responses.Movie.Filter) {
        
        view?.show(movies: movies,
                   with: filter.rawValue)
    }
}

// MARK: - MoviesNestedCollectionViewDelegate
extension MoviesPresenter {
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        willDisplay cell: MoviesNestedCollectionViewItemCell,
                                        forItemAt indexPath: IndexPath) {
        
        guard let rowTitle = viewModel.rowTitles[safe: indexPath.section] else {
            return
        }
        
        guard let viewModels = viewModel.cellViewModelsDictionary[rowTitle] else {
            return
        }
        
        guard let viewModel = Array(viewModels)[safe: indexPath.item] else {
            return
        }
        
        viewModel.load(cell)
        cell.configure(for: viewModel.state)
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        didEndDisplaying cell: MoviesNestedCollectionViewItemCell,
                                        forItemAt indexPath: IndexPath) {
        
        guard let rowTitle = viewModel.rowTitles[safe: indexPath.section] else {
            return
        }
        
        guard let viewModels = viewModel.cellViewModelsDictionary[rowTitle] else {
            return
        }
        
        guard let viewModel = Array(viewModels)[safe: indexPath.item] else {
            return
        }
        
        viewModel.stop()
    }
}

// MARK: - MoviesNestedCollectionViewDataSource
extension MoviesPresenter {
    func numberOfRows(in nestedCollectionViewController: MoviesNestedCollectionViewController) -> Int {
        return viewModel.rowTitles.count
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        numberOfItemsInRow row: Int) -> Int {
        
        guard let rowTitle = viewModel.rowTitles[safe: row] else {
            return 0
        }
        
        guard let viewModels = viewModel.cellViewModelsDictionary[rowTitle] else {
            return 0
        }
        
        return viewModels.count
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        titleForRow row: Int) -> String {
        
        guard let rowTitle = viewModel.rowTitles[safe: row] else {
            return ""
        }
        
        return rowTitle
    }
}

// MARK: - CRANavigationDropdownDelegate
extension MoviesPresenter {
    func tableView(_ tableView: UITableView,
                   didSelectFilter filter: String) {
        
        guard let filter = Netflix.Networking.Responses.Movie.Filter(rawValue: filter) else {
            assertionFailure("inconsistency in filter vs dropdown titles")
            return
        }
        
        viewModel.filter(by: filter)
    }
}
