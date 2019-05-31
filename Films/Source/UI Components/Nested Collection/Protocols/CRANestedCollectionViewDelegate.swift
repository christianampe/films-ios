//
//  CRANestedCollectionViewDelegate.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRANestedCollectionViewDelegate: class {
    func nestedCollectionView(_ nestedCollectionViewController: CRANestedCollectionViewController,
                              didSelectItemAtIndexPath indexPath: IndexPath)
    
    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        willDisplay cell: CRANestedCollectionViewItemCell,
                                        forItemAt indexPath: IndexPath)
}

extension CRANestedCollectionViewDelegate {
    func nestedCollectionView(_ nestedCollectionViewController: CRANestedCollectionViewController,
                              didSelectItemAtIndexPath indexPath: IndexPath) {}
}
