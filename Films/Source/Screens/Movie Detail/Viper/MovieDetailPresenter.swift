//
//  MovieDetailPresenter.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var router: MovieDetailRouterProtocol?
    
    var input: MovieDetailInput?
}

// MARK: - MovieDetailPresenterProtocol
extension MovieDetailPresenter {
    func viewDidLoad() {
        guard let input = input else {
            return
        }
        
        view?.show(input)
    }
    
    func dismissButtonPressed() {
        router?.dismiss(true)
    }
}
