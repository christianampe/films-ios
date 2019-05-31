//
//  ImageNetworking.swift
//  Films
//
//  Created by Christian Ampe on 5/31/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UIImage

enum Image {
    class Networking {
        private let provider = CRANetworkingProvider<Image.Networking.Target>()
    }
}

extension Image.Networking {
    func image(urlString: String,
               _ completion: @escaping (Result<UIImage, Image.Networking.Error>) -> Void) {
        
        provider.request(.image(urlString: urlString)) { result in
            switch result {
            case .success(let response):
                if let image = UIImage(data: response.data) {
                    completion(.success(image))
                } else {
                    completion(.failure(.mapping))
                }
            case .failure(let error):
                switch error {
                case .service(let error):
                    completion(.failure(.service(error)))
                }
            }
        }
    }
}
