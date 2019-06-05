//
//  MoviesRouter.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MoviesRouter: MoviesRouterProtocol {
    weak var viewController: UIViewController?
}

extension MoviesRouter {
    func presentMovieDetail(_ delegate: MovieDetailDelegateProtocol?,
                            input: MovieDetailInput) {
        
        viewController?.show(MovieDetailBuilder.create(delegate, input: input), sender: nil)
    }
}
