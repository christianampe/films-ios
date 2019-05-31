//
//  MoviesNestedCollectionViewDelegate.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol MoviesNestedCollectionViewDelegate: class {
    func nestedCollectionView(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                              didSelectItemAtIndexPath indexPath: IndexPath)
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        willDisplay cell: MoviesNestedCollectionViewItemCell,
                                        forItemAt indexPath: IndexPath)
    
    func nestedCollectionViewController(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                                        didEndDisplaying cell: MoviesNestedCollectionViewItemCell,
                                        forItemAt indexPath: IndexPath)
}

extension MoviesNestedCollectionViewDelegate {
    func nestedCollectionView(_ nestedCollectionViewController: MoviesNestedCollectionViewController,
                              didSelectItemAtIndexPath indexPath: IndexPath) {}
}
