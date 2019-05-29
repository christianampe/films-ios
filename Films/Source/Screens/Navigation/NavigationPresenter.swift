//
//  NavigationPresenter.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class NavigationPresenter: NavigationPresenterProtocol {
    weak var view: NavigationViewProtocol?
    var interactor: NavigationInteractorProtocol?
    var router: NavigationRouterProtocol?
}
