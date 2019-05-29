//
//  NavigationProtocols.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol NavigationPresenterProtocol: MoviesDelegateProtocol {
    var interactor: NavigationInteractorProtocol? { get set }
    var router: NavigationRouterProtocol? { get set }
    
    func start()
}

protocol NavigationInteractorProtocol: class {
    var presenter: NavigationPresenterProtocol?  { get set }
}

protocol NavigationRouterProtocol: class {
    func presentMovies(_ delegate: MoviesDelegateProtocol, input: MoviesInput)
}
