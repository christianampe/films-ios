//
//  CRANestedCollectionViewController.swift
//  Films
//
//  Created by Christian Ampe on 5/13/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class CRANestedCollectionViewController: UIViewController {
    
    /// A `UITableView` which contains the rows of items to be displayed.
    @IBOutlet private weak var tableView: UITableView!
    
    weak var delegate: CRANestedCollectionViewDelegate?
    weak var dataSource: CRANestedCollectionViewDataSource?
}

// MARK: - Public API
extension CRANestedCollectionViewController {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension CRANestedCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? CRANestedCollectionViewRowCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        cell.index = indexPath.section
        cell.delegate = self
        cell.dataSource = self
        cell.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CRANestedCollectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfRows(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(for: indexPath) as CRANestedCollectionViewRowCell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        return dataSource?.nestedCollectionViewController(self,
                                                          titleForRow: section)
    }
}

extension CRANestedCollectionViewController: CRANestedCollectionViewRowCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? CRANestedCollectionViewItemCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        delegate?.nestedCollectionViewController(self,
                                                 willDisplay: cell,
                                                 forItemAt: indexPath)
    }
}

extension CRANestedCollectionViewController: CRANestedCollectionViewRowCellDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataSource?.nestedCollectionViewController(self,
                                                          numberOfItemsInRow: section) ?? 0
    }
}
