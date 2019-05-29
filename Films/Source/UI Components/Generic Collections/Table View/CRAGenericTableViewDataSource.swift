//
//  CRAGenericTableViewDataSource.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UITableView

class CRAGenericTableViewDataSource<DS: CRAGenericCollectionDataSourceProtocol, C: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate where C: CRAGenericCollectionCellProtocol, DS.CM == C.CM {
    
    
    // MARK: - Private Properties
    
    private let dataSource: DS
    
    
    // MARK: - Initializers
    
    init(dataSource: DS) {
        self.dataSource = dataSource
    }
    
    
    // MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as C
        cell.configure(with: dataSource.cellModel(at: indexPath))
        
        return cell
    }
}
