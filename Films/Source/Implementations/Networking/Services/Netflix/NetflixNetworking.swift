//
//  Netflix.swift
//  Films
//
//  Created by Christian Ampe on 5/29/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol NetflixNetworkingService: class {
    associatedtype E: Swift.Error
    
    func films(_ completion: @escaping (Result<[Netflix.Networking.Responses.Movie], E>) -> Void)
}

enum Netflix {
    class Networking: NetflixNetworkingService {
        private let provider = CRANetworkingProvider<Netflix.Networking.Target>()
        private let jsonDecoder = JSONDecoder(.convertFromSnakeCase)
    }
}

extension Netflix.Networking {
    func films(_ completion: @escaping (Result<[Netflix.Networking.Responses.Movie], Netflix.Networking.Error>) -> Void) {
        provider.request(.films) { [weak self] result in
            DispatchQueue.main.async {
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
}
