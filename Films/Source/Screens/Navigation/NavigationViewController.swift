//
//  NavigationViewController.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class NavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBuilder.create(navigationController: self)
    }
}
