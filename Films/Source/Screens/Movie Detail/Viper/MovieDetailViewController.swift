//
//  MovieDetailViewController.swift
//  Films
//
//  Created Christian Ampe on 6/1/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    var input: MovieDetailInputProtocol?
    var viewModel: MovieDetailViewModelProtocol?
    var output: MovieDetailOutputProtocol?
    var presenter: MovieDetailPresenterProtocol?
    weak var delegate: MovieDetailDelegateProtocol?
}
