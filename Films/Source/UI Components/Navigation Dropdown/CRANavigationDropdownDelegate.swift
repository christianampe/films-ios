//
//  CRANavigationDropdownDelegate.swift
//  Films
//
//  Created by Christian Ampe on 6/1/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UITableView

protocol CRANavigationDropdownDelegate: class {
    func tableView(_ tableView: UITableView,
                   didSelectFilterAtRow row: Int)
}

extension CRANavigationDropdownDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectFilterAtRow row: Int) {}
}
