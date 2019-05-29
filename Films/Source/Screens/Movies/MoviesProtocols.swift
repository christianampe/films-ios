//
//  MoviesProtocols.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol MoviesInputProtocol {}

protocol MoviesViewModelProtocol {}

protocol MoviesOutputProtocol {}

protocol MoviesDelegateProtocol: class {}

protocol MoviesViewProtocol: class {
    var input: MoviesInputProtocol? { get set }
    var output: MoviesOutputProtocol? { get set }
    var viewModel: MoviesViewModelProtocol? { get set }
    var presenter: MoviesPresenterProtocol?  { get set }
    var delegate: MoviesDelegateProtocol? { get set }
}

protocol MoviesPresenterProtocol: class {
    var view: MoviesViewProtocol? { get set }
    var interactor: MoviesInteractorProtocol? { get set }
    var router: MoviesRouterProtocol? { get set }
}

protocol MoviesInteractorProtocol: class {
    var presenter: MoviesPresenterProtocol?  { get set }
}

protocol MoviesRouterProtocol: class {}
