//
//  MovieDetailBuilder.swift
//  Films
//
//  Created Christian Ampe on 6/1/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MovieDetailBuilder {
    static func create(_ delegate: MovieDetailDelegateProtocol?, input: MovieDetailInputProtocol, viewModel: MovieDetailViewModelProtocol = MovieDetailViewModel(), output: MovieDetailOutputProtocol = MovieDetailOutput()) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .movieDetail)
        let view: MovieDetailViewController = storyboard.instantiateViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter()
        
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
