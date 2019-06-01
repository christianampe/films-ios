//
//  CRANestedCollectionViewRowCellDelegate.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UICollectionView

protocol MoviesNestedCollectionViewRowCellDelegate: class {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAtIndexPath index: Int)
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath)
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath)
}

extension MoviesNestedCollectionViewRowCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAtIndexPath index: Int) {}
}