//
//  NavigationRouter.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class NavigationRouter: NavigationRouterProtocol {
    weak var navigationController: UINavigationController?
}

extension NavigationRouter {
    func presentMovies(_ delegate: MoviesDelegateProtocol) {
        navigationController?.setViewControllers([MoviesBuilder.create(delegate)],
                                                 animated: true)
    }
}
