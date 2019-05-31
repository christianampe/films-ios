//
//  MoviesBuilder.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MoviesBuilder {
    static func create(_ delegate: MoviesDelegateProtocol?) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .movies)
        let view: MoviesViewController = storyboard.instantiateViewController()
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        let presenter = MoviesPresenter()
        
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
