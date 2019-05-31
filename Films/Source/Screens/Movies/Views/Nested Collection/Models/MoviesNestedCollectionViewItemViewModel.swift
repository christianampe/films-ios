//
//  MoviesNestedCollectionViewItemViewModel.swift
//  Films
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UIImage

protocol MoviesNestedCollectionViewItemViewModelDelegate: class {
    func viewModel(_ viewModel: MoviesNestedCollectionViewItemViewModel,
                   didTransitionToState state: MoviesNestedCollectionViewItemViewModel.LoadingState)
}

class MoviesNestedCollectionViewItemViewModel {
    private var state: LoadingState {
        didSet(oldState) {
            guard oldState != state else {
                return
            }
            
            delegate?.viewModel(self, didTransitionToState: state)
        }
    }
    
    private var title: String
    private var imageURLString: String?
    private var image: UIImage?
    
    weak var delegate: MoviesNestedCollectionViewItemViewModelDelegate?
    weak var omdbProvider: OMDB.Networking?
    weak var imageProvider: Image.Networking?
    
    init(title: String) {
        self.title = title
        self.image = nil
        self.state = .inactive
    }
}

extension MoviesNestedCollectionViewItemViewModel {
    func load() {
        state = .active
        fetchInfo(for: title)
    }
}

private extension MoviesNestedCollectionViewItemViewModel {
    func fetchInfo(for movie: String) {
        omdbProvider?.info(movie: movie) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let info):
                    self.imageURLString = info.poster
                    self.fetchImage(with: info.poster)
                case .failure(let error):
                    self.state = .failed(error)
                }
            }
        }
    }
    
    func fetchImage(with urlString: String) {
        imageProvider?.image(urlString: urlString) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.image = image
                    self.state = .complete(image)
                case .failure(let error):
                    self.state = .failed(error)
                }
            }
        }
    }
}

extension MoviesNestedCollectionViewItemViewModel {
    enum LoadingState {
        case inactive
        case active
        case complete(UIImage)
        case failed(Error)
    }
}

extension MoviesNestedCollectionViewItemViewModel.LoadingState: Equatable {
    static func == (lhs: MoviesNestedCollectionViewItemViewModel.LoadingState,
                    rhs: MoviesNestedCollectionViewItemViewModel.LoadingState) -> Bool {
        
        switch (lhs, rhs) {
        case (.inactive ,.inactive):
            return true
        case (.active, .active):
            return true
        case (.complete, .complete):
            return true
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}
