//
//  MovieDetailProtocols.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol MovieDetailDelegateProtocol: class {
}

protocol MovieDetailViewProtocol: class {
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
