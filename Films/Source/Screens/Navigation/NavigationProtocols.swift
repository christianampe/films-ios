//
//  NavigationProtocols.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol NavigationInputProtocol {}

protocol NavigationViewModelProtocol {}

protocol NavigationOutputProtocol {}

protocol NavigationDelegateProtocol: class {}

protocol NavigationViewProtocol: class {
    var input: NavigationInputProtocol? { get set }
    var output: NavigationOutputProtocol? { get set }
    var viewModel: NavigationViewModelProtocol? { get set }
    var presenter: NavigationPresenterProtocol?  { get set }
    var delegate: NavigationDelegateProtocol? { get set }
}

protocol NavigationPresenterProtocol: class {
    var view: NavigationViewProtocol? { get set }
    var interactor: NavigationInteractorProtocol? { get set }
    var router: NavigationRouterProtocol? { get set }
}

protocol NavigationInteractorProtocol: class {
    var presenter: NavigationPresenterProtocol?  { get set }
}

protocol NavigationRouterProtocol: class {}
