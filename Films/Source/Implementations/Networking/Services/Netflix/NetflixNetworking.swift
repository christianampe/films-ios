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
    
    func films(_ completion: @escaping (Result<Netflix.Networking.Responses, E>) -> Void)
}

enum Netflix {
    class Networking: NetflixNetworkingService {
        private let provider = CRANetworkingProvider<Netflix.Networking.Target>()
        private var jsonDecoder: JSONDecoder = {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return jsonDecoder
        }()
        
        private var autocompleteRequest: URLSessionDataTask?
    }
}

extension Netflix.Networking {
    func films(_ completion: @escaping (Result<Netflix.Networking.Responses, Netflix.Networking.Error>) -> Void) {
        
    }
}
