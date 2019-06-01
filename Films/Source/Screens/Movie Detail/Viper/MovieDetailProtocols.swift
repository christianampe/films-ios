//
//  MovieDetailProtocols.swift
//  Films
//
//  Created Christian Ampe on 6/1/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol MovieDetailInputProtocol {
    var latitude: Double { get }
    var longitude: Double { get }
}

protocol MovieDetailViewModelProtocol {}

protocol MovieDetailOutputProtocol {}

protocol MovieDetailDelegateProtocol: class {}

protocol MovieDetailViewProtocol: class {
    var input: MovieDetailInputProtocol? { get set }
    var output: MovieDetailOutputProtocol? { get set }
    var viewModel: MovieDetailViewModelProtocol? { get set }
    var presenter: MovieDetailPresenterProtocol?  { get set }
    var delegate: MovieDetailDelegateProtocol? { get set }
}

protocol MovieDetailPresenterProtocol: class {
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
}

protocol MovieDetailInteractorProtocol: class {
    var presenter: MovieDetailPresenterProtocol?  { get set }
}

protocol MovieDetailRouterProtocol: class {}
