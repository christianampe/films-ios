//
//  MoviesInteractor.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MoviesInteractor: MoviesInteractorProtocol {
    private let netflixProvider = Netflix.Networking()
    private let omdbProvider = OMDB.Networking()
    
    weak var presenter: MoviesPresenterProtocol?
}

extension MoviesInteractor {
    func fetchMovies() {
        netflixProvider.movies { [weak presenter] result in
            DispatchQueue.main.async {
                guard let presenter = presenter else { return }
                
                switch result {
                case .success(let movies):
                    presenter.fetched(movies: movies)
                case .failure(let error):
                    presenter.encountered(error: error)
                }
            }
        }
    }
    
    func fetchInfo(for movie: String) {
        omdbProvider.info(movie: movie) { [weak presenter] result in
            DispatchQueue.main.async {
                guard let presenter = presenter else { return }
                
                switch result {
                case .success(let info):
                    presenter.fetched(info: info)
                case .failure(let error):
                    presenter.encountered(error: error)
                }
            }
        }
    }
}
