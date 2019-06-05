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
    let id: Int
    
    private let title: String
    
    private var imageURLString: String?
    
    private(set) var image: UIImage?
    
    private(set) var state: LoadingState {
        didSet {
            delegate?.viewModel(self, didTransitionToState: state)
        }
    }
    
    private weak var delegate: MoviesNestedCollectionViewItemViewModelDelegate?
    
    weak var omdbProvider: OMDB.Networking?
    weak var imageProvider: Image.Networking?
    
    init(id: Int,
         title: String) {
        
        self.id = id
        self.title = title
        self.image = nil
        self.state = .inactive
    }
}

extension MoviesNestedCollectionViewItemViewModel {
    func load(_ delegate: MoviesNestedCollectionViewItemViewModelDelegate) {
        self.delegate = delegate
        
        switch state {
        case .inactive:
            fetchInfo(for: title)
        case .active:
            break
        case .complete(let image):
            state = .complete(image)
        case .failed:
            break
        }
    }
    
    func stop() {
        delegate = nil
    }
}

private extension MoviesNestedCollectionViewItemViewModel {
    func fetchInfo(for movie: String) {
        state = .active
        
        omdbProvider?.info(movie: movie) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let info):
                    self.imageURLString = info.poster
                    self.fetchImage(with: info.poster)
                case .failure(let error):
                    print("Failed to fetch the movie \(movie).")
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
                    print("Failed to download the image at \(urlString).")
                    self.state = .failed(error)
                }
            }
        }
    }
}

extension MoviesNestedCollectionViewItemViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    static func == (lhs: MoviesNestedCollectionViewItemViewModel,
                    rhs: MoviesNestedCollectionViewItemViewModel) -> Bool {
        
        return lhs.title == rhs.title
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
