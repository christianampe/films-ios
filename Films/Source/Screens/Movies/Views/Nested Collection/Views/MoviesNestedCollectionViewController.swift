//
//  MoviesNestedCollectionViewController.swift
//  Films
//
//  Created by Christian Ampe on 5/13/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class MoviesNestedCollectionViewController: UIViewController {
    
    /// A `UITableView` which contains the rows of items to be displayed.
    @IBOutlet private weak var tableView: UITableView!
    
    weak var delegate: MoviesNestedCollectionViewDelegate?
    weak var dataSource: CRANestedCollectionViewDataSource?
}

// MARK: - Public API
extension MoviesNestedCollectionViewController {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension MoviesNestedCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? MoviesNestedCollectionViewRowCell else {
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
extension MoviesNestedCollectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfRows(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(for: indexPath) as MoviesNestedCollectionViewRowCell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        return dataSource?.nestedCollectionViewController(self,
                                                          titleForRow: section)
    }
}

extension MoviesNestedCollectionViewController: MoviesNestedCollectionViewRowCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? MoviesNestedCollectionViewItemCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        delegate?.nestedCollectionViewController(self,
                                                 willDisplay: cell,
                                                 forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? MoviesNestedCollectionViewItemCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        delegate?.nestedCollectionViewController(self,
                                                 didEndDisplaying: cell,
                                                 forItemAt: indexPath)
    }
}

extension MoviesNestedCollectionViewController: MoviesNestedCollectionViewRowCellDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataSource?.nestedCollectionViewController(self,
                                                          numberOfItemsInRow: section) ?? 0
    }
}
