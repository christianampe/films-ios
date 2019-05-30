//
//  MoviesProtocols.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol MoviesInputProtocol {}

protocol MoviesViewModelProtocol: CRANestedCollectionViewDataSource {
    var filters: [String] { get set }
    var movies: [Netflix.Networking.Responses.Movie] { get set }
}

protocol MoviesOutputProtocol {}

protocol MoviesDelegateProtocol: class {}

protocol MoviesViewProtocol: class {
    var input: MoviesInputProtocol? { get set }
    var output: MoviesOutputProtocol? { get set }
    var viewModel: MoviesViewModelProtocol? { get set }
    var presenter: MoviesPresenterProtocol?  { get set }
    var delegate: MoviesDelegateProtocol? { get set }
    
    func show(movies: [Netflix.Networking.Responses.Movie])
    func show(error: Error)
}

protocol MoviesPresenterProtocol: class {
    var view: MoviesViewProtocol? { get set }
    var interactor: MoviesInteractorProtocol? { get set }
    var router: MoviesRouterProtocol? { get set }
    
    func fetched(movies: [Netflix.Networking.Responses.Movie])
    func encountered(error: Error)
}

protocol MoviesInteractorProtocol: class {
    var presenter: MoviesPresenterProtocol?  { get set }
    
    func fetchMovies()
}

protocol MoviesRouterProtocol: class {}
