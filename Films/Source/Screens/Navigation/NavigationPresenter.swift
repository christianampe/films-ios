//
//  NavigationPresenter.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class NavigationPresenter: NavigationPresenterProtocol {
    var interactor: NavigationInteractorProtocol?
    var router: NavigationRouterProtocol?
}

extension NavigationPresenter {
    func start() {
        router?.presentMovies(self, input: MoviesInput())
    }
}
