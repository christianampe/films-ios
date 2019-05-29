//
//  NavigationViewController.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class NavigationViewController: UIViewController, NavigationViewProtocol {
    var input: NavigationInputProtocol?
    var viewModel: NavigationViewModelProtocol?
    var output: NavigationOutputProtocol?
    var presenter: NavigationPresenterProtocol?
    weak var delegate: NavigationDelegateProtocol?
}
