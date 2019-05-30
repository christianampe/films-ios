//
//  MoviesViewModel.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let actors: [String]
    let director: String
    let latitude: Double
    let locations: String
    let longitude: Double
    let productionCompany: String
    let releaseYear: String
    let title: String
    let writers: [String]
}

class MoviesViewModel: MoviesViewModelProtocol {
    
    
}

// MARK: - CRANestedCollectionViewDataSource
extension MoviesViewModel {
    func numberOfRows(in nestedCollectionViewController: CRANestedCollectionViewController) -> Int {
        return 0
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        numberOfItemsInRow row: Int) -> Int {
        
        return 0
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        viewModelAtIndexPath indexPath: IndexPath) -> CRANestedCollectionViewItem {
        
        
    }
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        titleForRow row: Int) -> String {
        
        return ""
    }
}
