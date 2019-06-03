//
//  MoviesViewModel.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol MoviesViewModelDelegate: class {
    func moviesViewModelDidFinishAnalyzingMovies(_ moviesViewModel: MoviesViewModel,
                                                 with filter: Netflix.Networking.Responses.Movie.Filter)
}

class MoviesViewModel: MoviesViewModelProtocol {
    private let omdbProvider = OMDB.Networking()
    private let imageProvider = Image.Networking()
    
    private(set) var movieDictionary = [Int: Netflix.Networking.Responses.Movie]()
    
    private(set) var rowTitles: [String] = []
    private(set) var cellViewModelsDictionary: [String: Set<MoviesNestedCollectionViewItemViewModel>] = [:]
    
    private(set) var filterNames = Netflix.Networking.Responses.Movie.Filter.all.map { $0.rawValue }
    
    weak var delegate: MoviesViewModelDelegate?
}

extension MoviesViewModel {
    func set(movies: [Netflix.Networking.Responses.Movie]) {
        for i in 0..<movies.count {
            movieDictionary[i] = movies[i]
        }
    }
    
    func filter(by filter: Netflix.Networking.Responses.Movie.Filter) {
        
        // block to be executed once the filter operation is complete
        let completion = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.delegate?.moviesViewModelDidFinishAnalyzingMovies(self,
                                                                       with: filter)
            }
        }
        
        switch filter {
        case .actor:
            filterMoviesByActor(movieDictionary, completion)
        case .director:
            filterMoviesByDirector(movieDictionary, completion)
        case .location:
            filterMoviesByLocations(movieDictionary, completion)
        case .productionCompany:
            filterMoviesByProductionCompany(movieDictionary, completion)
        case .releaseYear:
            filterMoviesByReleaseYear(movieDictionary, completion)
        case .writer:
            filterMoviesByWriter(movieDictionary, completion)
        }
    }
}

private extension MoviesViewModel {
    func filterMoviesByActor(_ movieDictionary: [Int: Netflix.Networking.Responses.Movie],
                             _ completion: @escaping (() -> Void)) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // clear out previous entries
            self.rowTitles = []
            self.cellViewModelsDictionary = [:]
            
            // loop through the fetched movies
            movieDictionary.forEach { movie in
                
                // construct a view model
                let viewModel = MoviesNestedCollectionViewItemViewModel(id: movie.key,
                                                                        title: movie.value.title)
                
                // set providers on the view model
                viewModel.omdbProvider = self.omdbProvider
                viewModel.imageProvider = self.imageProvider
                
                // loop through each actor in a given movie
                movie.value.actors.forEach { actor in
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
    
    func filterMoviesByReleaseYear(_ movieDictionary: [Int: Netflix.Networking.Responses.Movie],
                                   _ completion: @escaping (() -> Void)) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // clear out previous entries
            self.rowTitles = []
            self.cellViewModelsDictionary = [:]
            
            // loop through the fetched movies
            movieDictionary.forEach { movie in
                
                // construct a view model
                let viewModel = MoviesNestedCollectionViewItemViewModel(id: movie.key,
                                                                        title: movie.value.title)
                
                // set providers on the view model
                viewModel.omdbProvider = self.omdbProvider
                viewModel.imageProvider = self.imageProvider
                
                if (self.cellViewModelsDictionary[movie.value.releaseYear]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.cellViewModelsDictionary[movie.value.releaseYear]?.insert(viewModel)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.cellViewModelsDictionary[movie.value.releaseYear] = [viewModel]
                    self.rowTitles.append(movie.value.releaseYear)
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
    
    func filterMoviesByLocations(_ movieDictionary: [Int: Netflix.Networking.Responses.Movie],
                                 _ completion: @escaping (() -> Void)) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // clear out previous entries
            self.rowTitles = []
            self.cellViewModelsDictionary = [:]
            
            // loop through the fetched movies
            movieDictionary.forEach { movie in
                
                // construct a view model
                let viewModel = MoviesNestedCollectionViewItemViewModel(id: movie.key,
                                                                        title: movie.value.title)
                
                // set providers on the view model
                viewModel.omdbProvider = self.omdbProvider
                viewModel.imageProvider = self.imageProvider
                
                if (self.cellViewModelsDictionary[movie.value.locations]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.cellViewModelsDictionary[movie.value.locations]?.insert(viewModel)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.cellViewModelsDictionary[movie.value.locations] = [viewModel]
                    self.rowTitles.append(movie.value.locations)
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
    
    func filterMoviesByWriter(_ movieDictionary: [Int: Netflix.Networking.Responses.Movie],
                              _ completion: @escaping (() -> Void)) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // clear out previous entries
            self.rowTitles = []
            self.cellViewModelsDictionary = [:]
            
            // loop through the fetched movies
            movieDictionary.forEach { movie in
                
                // ensure there are writers cooresponding to the given movie
                // otherwise move to the next iteration
                guard let writers = movie.value.writers else {
                    return
                }
                
                // construct a view model
                let viewModel = MoviesNestedCollectionViewItemViewModel(id: movie.key,
                                                                        title: movie.value.title)
                
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
    
    func filterMoviesByProductionCompany(_ movieDictionary: [Int: Netflix.Networking.Responses.Movie],
                                         _ completion: @escaping (() -> Void)) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // clear out previous entries
            self.rowTitles = []
            self.cellViewModelsDictionary = [:]
            
            // loop through the fetched movies
            movieDictionary.forEach { movie in
                
                // construct a view model
                let viewModel = MoviesNestedCollectionViewItemViewModel(id: movie.key,
                                                                        title: movie.value.title)
                
                // set providers on the view model
                viewModel.omdbProvider = self.omdbProvider
                viewModel.imageProvider = self.imageProvider
                
                if (self.cellViewModelsDictionary[movie.value.productionCompany]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.cellViewModelsDictionary[movie.value.productionCompany]?.insert(viewModel)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.cellViewModelsDictionary[movie.value.productionCompany] = [viewModel]
                    self.rowTitles.append(movie.value.productionCompany)
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
    
    func filterMoviesByDirector(_ movieDictionary: [Int: Netflix.Networking.Responses.Movie],
                                _ completion: @escaping (() -> Void)) {
        
        // throw the cpu intensive task on a background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            // clear out previous entries
            self.rowTitles = []
            self.cellViewModelsDictionary = [:]
            
            // loop through the fetched movies
            movieDictionary.forEach { movie in
                
                // construct a view model
                let viewModel = MoviesNestedCollectionViewItemViewModel(id: movie.key,
                                                                        title: movie.value.title)
                
                // set providers on the view model
                viewModel.omdbProvider = self.omdbProvider
                viewModel.imageProvider = self.imageProvider
                
                if (self.cellViewModelsDictionary[movie.value.director]) != nil {
                    // this movie release year has been observed previously
                    // append the new movie to the dictionary
                    self.cellViewModelsDictionary[movie.value.director]?.insert(viewModel)
                } else {
                    // this release year has not been observered previously
                    // create a new entry in the dictionary and add the release year to the array of collection titles
                    self.cellViewModelsDictionary[movie.value.director] = [viewModel]
                    self.rowTitles.append(movie.value.director)
                }
            }
            
            // sort the collection titles either alphabetically or numerically
            self.rowTitles.sort()
            
            // fire completion
            completion()
        }
    }
}
