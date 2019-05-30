//
//  CRANestedCollectionViewRowCellDelegate.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UICollectionView

protocol CRANestedCollectionViewRowCellDelegate: class {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAtIndexPath index: Int)
}

extension CRANestedCollectionViewRowCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAtIndexPath index: Int) {}
}
