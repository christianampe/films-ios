//
//  OMDBNetworking.swift
//  Films
//
//  Created by Christian Ampe on 5/30/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

enum OMDB {
    class Networking {
        private let provider = CRANetworkingProvider<OMDB.Networking.Target>()
        private let memoryCache = CRAMemoryCache<OMDB.Networking.Responses.Info>()
        private let jsonDecoder = JSONDecoder()
    }
}

extension OMDB.Networking {
    func info(movie: String,
              _ completion: @escaping (Result<OMDB.Networking.Responses.Info, OMDB.Networking.Error>) -> Void) {
        
        provider.request(.info(film: movie)) { [weak jsonDecoder, weak memoryCache] result in
            guard let jsonDecoder = jsonDecoder, let memoryCache = memoryCache else { return }
            
            switch result {
            case .success(let response):
                do {
                    let filmInfo = try jsonDecoder.decode(OMDB.Networking.Responses.Info.self,
                                                          from: response.data)
                    
                    if let requestURL = response.request.url {
                        memoryCache.setObject(filmInfo, forKey: requestURL.absoluteString)
                    }
                    
                    completion(.success(filmInfo))
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
