//
//  MoviesViewModel.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol MoviesViewModelDelegate: class {
    func moviesViewModel(_ moviesViewModel: MoviesViewModel,
                         didFinishAnalyzingMovies movies: [Netflix.Networking.Responses.Movie])
}

class MoviesViewModel: MoviesViewModelProtocol {
    private(set) var rowTitles: [String] = []
    private(set) var moviesDictionary: [String: [Netflix.Networking.Responses.Movie]] = [:]
    
    weak var delegate: MoviesViewModelDelegate?
    
    init(delegate: MoviesViewModelDelegate) {
        self.delegate = delegate
    }
}

extension MoviesViewModel {
    func analyze(_ movies: [Netflix.Networking.Responses.Movie]) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // loop through the fetched movies
            movies.forEach { movie in
                if (self.moviesDictionary[movie.releaseYear]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.moviesDictionary[movie.releaseYear]?.append(movie)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.moviesDictionary[movie.releaseYear] = [movie]
                    self.rowTitles.append(movie.releaseYear)
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // delegate out that the analysis has completed on the main thread
            DispatchQueue.main.async {
                self.delegate?.moviesViewModel(self,
                                               didFinishAnalyzingMovies: movies)
            }
        }
    }
}
