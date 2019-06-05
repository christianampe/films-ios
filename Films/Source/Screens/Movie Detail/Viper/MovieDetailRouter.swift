//
//  MovieDetailRouter.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MovieDetailRouter: MovieDetailRouterProtocol {
    weak var viewController: UIViewController?
}

extension MovieDetailRouter {
    func dismiss(_ animated: Bool) {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
