//
//  Netflix.swift
//  Films
//
//  Created by Christian Ampe on 5/29/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

enum Netflix {
    class Networking {
        private let provider = CRANetworkingProvider<Netflix.Networking.Target>()
        private let memoryCache = CRAMemoryCache<[Netflix.Networking.Responses.Movie]>()
        private let jsonDecoder = JSONDecoder(.convertFromSnakeCase)
    }
}

extension Netflix.Networking {
    func movies(_ completion: @escaping (Result<[Netflix.Networking.Responses.Movie], Netflix.Networking.Error>) -> Void) {
        provider.request(.films) { [weak jsonDecoder, weak memoryCache] result in
            guard let jsonDecoder = jsonDecoder, let memoryCache = memoryCache else { return }
            
            switch result {
            case .success(let response):
                do {
                    let movies = try jsonDecoder.decode([Netflix.Networking.Responses.Movie].self,
                                                        from: response.data)
                    if let requestURL = response.request.url {
                        memoryCache.setObject(movies, forKey: requestURL.absoluteString)
                    }
                    
                    completion(.success(movies))
                } catch {
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
