//
//  NavigationBuilder.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class NavigationBuilder {
    static func create(_ delegate: NavigationDelegateProtocol?, input: NavigationInputProtocol, viewModel: NavigationViewModelProtocol = NavigationViewModel(), output: NavigationOutputProtocol = NavigationOutput()) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: )
        let view: NavigationViewController = storyboard.instantiateViewController()
        let interactor = NavigationInteractor()
        let router = NavigationRouter()
        let presenter = NavigationPresenter()
        
        view.input = input
        view.viewModel = viewModel
        view.output = output
        view.presenter = presenter
        view.delegate = delegate
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
