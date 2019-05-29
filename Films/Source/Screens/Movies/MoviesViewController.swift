//
//  MoviesViewController.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

struct Movie: CRANestedCollectionViewItem {
    let backgroundImageURLString: String
}

final class MoviesViewController: UIViewController, MoviesViewProtocol {
    var input: MoviesInputProtocol?
    var viewModel: MoviesViewModelProtocol?
    var output: MoviesOutputProtocol?
    var presenter: MoviesPresenterProtocol?
    weak var delegate: MoviesDelegateProtocol?
    
    private var nestedCollection: CRANestedCollectionViewController!
    
    
    var items: [[Movie]] = {
        let movie = Movie(backgroundImageURLString: "https://m.media-amazon.com/images/M/MV5BN2I3NzVlMTktNWZmYi00ODk1LWE1YzUtYzVlMmY5ZjYwMTk1XkEyXkFqcGdeQXVyMzU0NzkwMDg@._V1_SX300.jpg")
        let movies = [movie, movie, movie, movie]
        
        return [movies, movies.dropLast(2), movies + movies]
    }()
}

// MARK: - Lifecycle
extension MoviesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueCase(for: segue) {
        case .embedNestedCollection:
            nestedCollection = segue.viewController()
            nestedCollection.dataSource = self
        }
    }
}

extension MoviesViewController: CRANestedCollectionViewDataSource {
    func numberOfRows(in nestedCollectionViewController: CRANestedCollectionViewController) -> Int {
        return items.count
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        numberOfItemsInRow row: Int) -> Int {
        
        return items[row].count
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        viewModelAtIndexPath indexPath: IndexPath) -> CRANestedCollectionViewItem {
        
        return items[indexPath.section][indexPath.item]
    }
}

// MARK: - SegueIdentifiable
extension MoviesViewController: SegueIdentifiable {
    enum Segue: String {
        case embedNestedCollection
    }
}
