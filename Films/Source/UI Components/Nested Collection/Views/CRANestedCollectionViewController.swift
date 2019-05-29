//
//  CRANestedCollectionViewController.swift
//  Films
//
//  Created by Christian Ampe on 5/13/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class CRANestedCollectionViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    weak var dataSource: CRANestedCollectionViewDataSource?
    weak var delegate: CRANestedCollectionViewDelegate?
}

// MARK: - Public API
extension CRANestedCollectionViewController {
    func reloadData() {
        tableView.reloadData()
    }
}

extension CRANestedCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return dataSource?.numberOfRows(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as CRANestedCollectionViewRowCell
        
        cell.rowIndex = indexPath.section
        cell.dataSource = self
        cell.delegate = self
        
        return cell
    }
}

extension CRANestedCollectionViewController: UITableViewDelegate {
    
}

extension CRANestedCollectionViewController: CRANestedCollectionViewRowCellDataSource {
    func numberOfItems(in nestedCollectionViewRowCell: CRANestedCollectionViewRowCell) -> Int {
        return dataSource?.nestedCollectionViewController(self,
                                                          numberOfItemsInRow: nestedCollectionViewRowCell.rowIndex) ?? 0
    }
    
    func nestedCollectionViewRowCell(_ nestedCollectionViewRowCell: CRANestedCollectionViewRowCell,
                                     viewModelAtIndex index: Int) -> CRANestedCollectionViewRowCellViewModelProtocol? {
        
        return dataSource?.nestedCollectionViewController(self, viewModelAtIndexPath: IndexPath(item: index,
                                                                                               section: nestedCollectionViewRowCell.rowIndex))
    }
}

extension CRANestedCollectionViewController: CRANestedCollectionViewRowCellDelegate {
    
}
