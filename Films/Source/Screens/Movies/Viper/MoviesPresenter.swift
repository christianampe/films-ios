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
    
    private lazy var viewModel = MoviesViewModel(delegate: self)
}

// MARK: - VIEW TO INTERACTOR
extension MoviesPresenter {
    func viewDidLoad() {
        interactor?.fetchMovies()
    }
}

// MARK: - INTERACTOR TO VIEW
extension MoviesPresenter {
    func fetched(movies: [Netflix.Networking.Responses.Movie]) {
        viewModel.analyze(movies)
    }
    
    func encountered(error: Netflix.Networking.Error) {
        view?.show(error: error)
    }
    
    func fetched(info: OMDB.Networking.Responses.Info) {
        view?.show(info: info)
    }
    
    func encountered(error: OMDB.Networking.Error) {
        view?.show(error: error)
    }
}

// MARK: - MoviesViewModelDelegate
extension MoviesPresenter: MoviesViewModelDelegate {
    func moviesViewModel(_ moviesViewModel: MoviesViewModel,
                         didFinishAnalyzingMovies movies: [Netflix.Networking.Responses.Movie]) {
        
        view?.show(movies: movies)
    }
}

// MARK: - CRANestedCollectionViewDelegate
extension MoviesPresenter {
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        willDisplay cell: CRANestedCollectionViewItemCell,
                                        forItemAt indexPath: IndexPath) {
        
        
    }
}

// MARK: - CRANestedCollectionViewDataSource
extension MoviesPresenter {
    func numberOfRows(in nestedCollectionViewController: CRANestedCollectionViewController) -> Int {
        return viewModel.rowTitles.count
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        numberOfItemsInRow row: Int) -> Int {
        
        guard let rowTitle = viewModel.rowTitles[safe: row] else {
            return 0
        }
        
        guard let movies = viewModel.moviesDictionary[rowTitle] else {
            return 0
        }
        
        return movies.count
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        titleForRow row: Int) -> String {
        
        guard let rowTitle = viewModel.rowTitles[safe: row] else {
            return ""
        }
        
        return rowTitle
    }
}
