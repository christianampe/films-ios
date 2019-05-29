//
//  CRANetworkingProviderResponse.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol CRANetworkingProviderResponseProtocol {
    var data: Data { get }
    var request: URLRequest { get }
    var response: HTTPURLResponse { get }
}

struct CRANetworkingProviderResponse: CRANetworkingProviderResponseProtocol {
    
    /// Data returned from the network request.
    let data: Data
    
    /// URL request sent to server.
    let request: URLRequest
    
    /// HTTP url response returned from server.
    let response: HTTPURLResponse
    
    /// Explicit initializer.
    ///
    /// - Parameters:
    ///   - data: The data returned from the network request.
    ///   - request: The url request sent to server.
    ///   - response: The HTTP url response returned from server.
    init(data: Data,
         request: URLRequest,
         response: HTTPURLResponse) {
        
        self.data = data
        self.request = request
        self.response = response
    }
}
