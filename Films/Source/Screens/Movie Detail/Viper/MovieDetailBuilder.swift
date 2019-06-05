//
//  MovieDetailBuilder.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MovieDetailBuilder {
    static func create(_ delegate: MovieDetailDelegateProtocol?,
                       input: MovieDetailInput) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .movieDetail)
        let view: MovieDetailTableViewController = storyboard.instantiateViewController()
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        
        view.presenter = presenter
        view.delegate = delegate
        presenter.view = view
        presenter.interactor = interactor
        presenter.input = input
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
