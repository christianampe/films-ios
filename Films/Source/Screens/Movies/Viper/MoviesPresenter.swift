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
}

extension MoviesPresenter {
    func fetched(movies: [Netflix.Networking.Responses.Movie]) {
        view?.show(movies: movies)
    }
    
    func encountered(error: Error) {
        view?.show(error: error)
    }
}
