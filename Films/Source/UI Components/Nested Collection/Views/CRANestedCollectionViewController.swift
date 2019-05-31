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
    @IBOutlet private weak var tableView: UITableView! {
        didSet  {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
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
        
        cell.delegate = self
        cell.dataSource = self
        cell.index = indexPath.row
    }
}

// MARK: - UITableViewDataSource
extension CRANestedCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return dataSource?.numberOfRows(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(for: indexPath) as CRANestedCollectionViewRowCell
    }
}

extension CRANestedCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let parentCell = collectionView.superview as? CRANestedCollectionViewRowCell else {
            assertionFailure("embedding hierarchy incorrect")
            return
        }
        
        guard let cell = cell as? CRANestedCollectionViewItemCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        delegate?.nestedCollectionViewController(self,
                                                 willDisplay: cell,
                                                 forItemAt: IndexPath(row: parentCell.index,
                                                                      section: indexPath.item))
    }
}

extension CRANestedCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataSource?.nestedCollectionViewController(self, numberOfItemsInRow: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(for: indexPath) as CRANestedCollectionViewItemCell
    }
}
