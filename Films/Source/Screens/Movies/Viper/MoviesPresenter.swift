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
        viewModel.filter(by: .writer)
    }
    
    func encountered(error: Netflix.Networking.Error) {
        view?.show(error: error)
    }
}

// MARK: - MoviesViewModelDelegate
extension MoviesPresenter: MoviesViewModelDelegate {
    func moviesViewModelDidFinishAnalyzingMovies(_ moviesViewModel: MoviesViewModel,
                                                 with filter: Netflix.Networking.Responses.Movie.Filter) {
        
        view?.show(filter.rawValue)
    }
}

// MARK: - MoviesNestedCollectionViewDelegate
extension MoviesPresenter {
    func nestedCollectionView(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                              didSelectItemAtIndexPath indexPath: IndexPath) {
        
        guard let rowTitle = viewModel.rowTitles[safe: indexPath.section] else {
            return
        }
        
        guard let cellViewModels = viewModel.cellViewModelsDictionary[rowTitle] else {
            return
        }
        
        guard let cellViewModel = Array(cellViewModels)[safe: indexPath.item] else {
            return
        }
        
        guard let movie = viewModel.movieDictionary[cellViewModel.id] else {
            return
        }
        
        router?.presentMovieDetail(self, input: MovieDetailInput(poster: cellViewModel.image ?? #imageLiteral(resourceName: "missing-image"),
                                                                 title: movie.title,
                                                                 location: movie.locations,
                                                                 latitude: movie.latitude,
                                                                 longitude: movie.longitude))
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        willDisplay cell: MoviesNestedCollectionViewItemCell,
                                        forItemAt indexPath: IndexPath) {
        
        guard let rowTitle = viewModel.rowTitles[safe: indexPath.section] else {
            return
        }
        
        guard let cellViewModels = viewModel.cellViewModelsDictionary[rowTitle] else {
            return
        }
        
        guard let cellViewModel = Array(cellViewModels)[safe: indexPath.item] else {
            return
        }
        
        cellViewModel.load(cell)
        cell.configure(for: cellViewModel.state)
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        didEndDisplaying cell: MoviesNestedCollectionViewItemCell,
                                        forItemAt indexPath: IndexPath) {
        
        guard let rowTitle = viewModel.rowTitles[safe: indexPath.section] else {
            return
        }
        
        guard let cellViewModels = viewModel.cellViewModelsDictionary[rowTitle] else {
            return
        }
        
        guard let cellViewModel = Array(cellViewModels)[safe: indexPath.item] else {
            return
        }
        
        cellViewModel.stop()
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
        
        guard let cellViewModels = viewModel.cellViewModelsDictionary[rowTitle] else {
            return 0
        }
        
        return cellViewModels.count
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        titleForRow row: Int) -> String? {
        
        guard let rowTitle = viewModel.rowTitles[safe: row] else {
            return "Unknown"
        }
        
        guard !rowTitle.isEmpty else {
            return "Unknown"
        }
        
        return rowTitle
    }
}

// MARK: - CRANavigationDropdownDelegate
extension MoviesPresenter {
    func tableView(_ tableView: UITableView,
                   didSelectFilterAtRow row: Int) {
        
        guard let filterName = viewModel.filterNames[safe: row] else {
            assertionFailure("inconsistency in provided filters")
            return
        }
        
        guard let filter = Netflix.Networking.Responses.Movie.Filter(rawValue: filterName) else {
            assertionFailure("inconsistency in filter vs dropdown titles")
            return
        }
        
        viewModel.filter(by: filter)
    }
}

// MARK: - CRANavigationDropdownDataSource
extension MoviesPresenter {
    func numberOfRows(in tableView: UITableView) -> Int {
        return viewModel.filterNames.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForFilterAtRow row: Int) -> String? {
        
        return viewModel.filterNames[safe: row]
    }
}

extension MoviesPresenter: MovieDetailDelegateProtocol {
    
}
