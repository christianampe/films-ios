//
//  CRAGenericCollectionViewDataSource.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UICollectionView

class CRAGenericCollectionViewDataSource<DS: CRAGenericCollectionDataSourceProtocol, C: UICollectionViewCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate where C: CRAGenericCollectionCellProtocol, DS.CM == C.CM {
    
    
    // MARK: - Private Properties
    
    private let dataSource: DS
    
    
    // MARK: - Initializers
    
    init(dataSource: DS) {
        self.dataSource = dataSource
    }
    
    
    // MARK: - UICollectionViewDataSource Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as C
        cell.configure(with: dataSource.cellModel(at: indexPath))
        
        return cell
    }
}
