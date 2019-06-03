//
//  CRANavigationDropdownDataSource.swift
//  Films
//
//  Created by Christian Ampe on 6/2/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UITableView

protocol CRANavigationDropdownDataSource: class {
    func numberOfRows(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, titleForFilterAtRow row: Int) -> String?
}
