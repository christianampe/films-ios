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
    private let omdbProvider = OMDB.Networking()
    private let imageProvider = Image.Networking()
    
    private(set) var rowTitles: [String] = []
    private(set) var cellViewModelsDictionary: [String: Set<MoviesNestedCollectionViewItemViewModel>] = [:]
    
    weak var delegate: MoviesViewModelDelegate?
}

extension MoviesViewModel {
    func analyze(_ movies: [Netflix.Networking.Responses.Movie]) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // clear out previous entries
            self.rowTitles = []
            self.cellViewModelsDictionary = [:]
            
            // loop through the fetched movies
            movies.forEach { movie in
                
                // construct a view model
                let viewModel = MoviesNestedCollectionViewItemViewModel(title: movie.title)
                
                // set providers on the view model
                viewModel.omdbProvider = self.omdbProvider
                viewModel.imageProvider = self.imageProvider
                
                if (self.cellViewModelsDictionary[movie.releaseYear]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.cellViewModelsDictionary[movie.releaseYear]?.insert(viewModel)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.cellViewModelsDictionary[movie.releaseYear] = [viewModel]
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
