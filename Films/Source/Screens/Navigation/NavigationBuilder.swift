//
//  NavigationBuilder.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class NavigationBuilder {
    static func create(navigationController: UINavigationController?) {
        let presenter = NavigationPresenter()
        let interactor = NavigationInteractor()
        let router = NavigationRouter()
        
        interactor.presenter = presenter
        router.navigationController = navigationController
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.start()
    }
}
