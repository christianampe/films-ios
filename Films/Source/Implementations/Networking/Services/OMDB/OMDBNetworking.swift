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
        private let jsonDecoder = JSONDecoder(.convertFromSnakeCase)
    }
}

extension OMDB.Networking {
    func films(_ completion: @escaping (Result<[Netflix.Networking.Responses.Movie], Netflix.Networking.Error>) -> Void) {
        provider.request(.films) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let movies = try self.jsonDecoder.decode([Netflix.Networking.Responses.Movie].self,
                                                             from: response.data)
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
