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
                         didFinishAnalyzingMovies movies: [Netflix.Networking.Responses.Movie],
                         with filter: Netflix.Networking.Responses.Movie.Filter)
}

class MoviesViewModel: MoviesViewModelProtocol {
    private let omdbProvider = OMDB.Networking()
    private let imageProvider = Image.Networking()
    
    private var movies = [Netflix.Networking.Responses.Movie]()
    
    private(set) var rowTitles: [String] = []
    private(set) var cellViewModelsDictionary: [String: Set<MoviesNestedCollectionViewItemViewModel>] = [:]
    
    weak var delegate: MoviesViewModelDelegate?
}

extension MoviesViewModel {
    func set(movies: [Netflix.Networking.Responses.Movie]) {
        self.movies = movies
    }
    
    func filter(by filter: Netflix.Networking.Responses.Movie.Filter) {
        
        // block to be executed once the filter operation is complete
        let completion = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.delegate?.moviesViewModel(self,
                                               didFinishAnalyzingMovies: self.movies,
                                               with: filter)
            }
        }
        
        switch filter {
        case .actor:
            filterMoviesByActor(movies, completion)
        case .director:
            filterMoviesByDirector(movies, completion)
        case .location:
            filterMoviesByLocations(movies, completion)
        case .productionCompany:
            filterMoviesByProductionCompany(movies, completion)
        case .releaseYear:
            filterMoviesByReleaseYear(movies, completion)
        case .writer:
            filterMoviesByWriter(movies, completion)
        }
    }
}

private extension MoviesViewModel {
    func filterMoviesByActor(_ movies: [Netflix.Networking.Responses.Movie],
                             _ completion: @escaping (() -> Void)) {
        
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
                
                // loop through each actor in a given movie
                movie.actors.forEach { actor in
                    if (self.cellViewModelsDictionary[actor]) != nil {
                        // this movie release year has been observed previously
                        // append the new movie to the dictionary
                        self.cellViewModelsDictionary[actor]?.insert(viewModel)
                    } else {
                        // this release year has not been observered previously
                        // create a new entry in the dictionary and add the release year to the array of collection titles
                        self.cellViewModelsDictionary[actor] = [viewModel]
                        self.rowTitles.append(actor)
                    }
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
    
    func filterMoviesByReleaseYear(_ movies: [Netflix.Networking.Responses.Movie],
                                   _ completion: @escaping (() -> Void)) {
        
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
            
            // fire completion
            completion()
        }
    }
    
    func filterMoviesByLocations(_ movies: [Netflix.Networking.Responses.Movie],
                                 _ completion: @escaping (() -> Void)) {
        
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
                
                if (self.cellViewModelsDictionary[movie.locations]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.cellViewModelsDictionary[movie.locations]?.insert(viewModel)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.cellViewModelsDictionary[movie.locations] = [viewModel]
                    self.rowTitles.append(movie.locations)
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
    
    func filterMoviesByWriter(_ movies: [Netflix.Networking.Responses.Movie],
                              _ completion: @escaping (() -> Void)) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // clear out previous entries
            self.rowTitles = []
            self.cellViewModelsDictionary = [:]
            
            // loop through the fetched movies
            movies.forEach { movie in
                
                // ensure there are writers cooresponding to the given movie
                // otherwise move to the next iteration
                guard let writers = movie.writers else {
                    return
                }
                
                // construct a view model
                let viewModel = MoviesNestedCollectionViewItemViewModel(title: movie.title)
                
                // set providers on the view model
                viewModel.omdbProvider = self.omdbProvider
                viewModel.imageProvider = self.imageProvider
                
                // loop through each actor in a given movie
                writers.forEach { writer in
                    if (self.cellViewModelsDictionary[writer]) != nil {
                        // this movie release year has been observed previously
                        // append the new movie to the dictionary
                        self.cellViewModelsDictionary[writer]?.insert(viewModel)
                    } else {
                        // this release year has not been observered previously
                        // create a new entry in the dictionary and add the release year to the array of collection titles
                        self.cellViewModelsDictionary[writer] = [viewModel]
                        self.rowTitles.append(writer)
                    }
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
    
    func filterMoviesByProductionCompany(_ movies: [Netflix.Networking.Responses.Movie],
                                         _ completion: @escaping (() -> Void)) {
        
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
                
                if (self.cellViewModelsDictionary[movie.productionCompany]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.cellViewModelsDictionary[movie.productionCompany]?.insert(viewModel)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.cellViewModelsDictionary[movie.productionCompany] = [viewModel]
                    self.rowTitles.append(movie.productionCompany)
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
    
    func filterMoviesByDirector(_ movies: [Netflix.Networking.Responses.Movie],
                                _ completion: @escaping (() -> Void)) {
        
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
                
                if (self.cellViewModelsDictionary[movie.director]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.cellViewModelsDictionary[movie.director]?.insert(viewModel)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.cellViewModelsDictionary[movie.director] = [viewModel]
                    self.rowTitles.append(movie.director)
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
}
