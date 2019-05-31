//
//  MoviesProtocols.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol MoviesViewModelProtocol: class {
    func analyze(_ movies: [Netflix.Networking.Responses.Movie])
}

protocol MoviesDelegateProtocol: class {}

protocol MoviesViewProtocol: class {
    var presenter: MoviesPresenterProtocol?  { get set }
    var delegate: MoviesDelegateProtocol? { get set }
    
    func show(movies: [Netflix.Networking.Responses.Movie])
    
    func show(error: Error)
}

protocol MoviesPresenterProtocol: CRANestedCollectionViewDataSource, MoviesNestedCollectionViewDelegate {
    var view: MoviesViewProtocol? { get set }
    var interactor: MoviesInteractorProtocol? { get set }
    var router: MoviesRouterProtocol? { get set }
    
    func viewDidLoad()
    
    func fetched(movies: [Netflix.Networking.Responses.Movie])
    func encountered(error: Netflix.Networking.Error)
}

protocol MoviesInteractorProtocol: class {
    var presenter: MoviesPresenterProtocol?  { get set }
    
    func fetchMovies()
}

protocol MoviesRouterProtocol: class {}
