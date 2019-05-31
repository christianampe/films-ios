//
//  ImageNetworkingTarget.swift
//  Films
//
//  Created by Christian Ampe on 5/31/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

extension Image.Networking {
    enum Target: CRANetworkingRequest {
        case image(urlString: String)
    }
}

extension Image.Networking.Target {
    var baseURL: URL {
        switch self {
        case .image(let urlString):
            return URL(string: urlString)!
        }
    }
    
    var path: String {
        switch self {
        case .image:
            return "/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .image:
            return nil
        }
    }
    
    var method: CRANetworkingRequestHTTPMethod {
        switch self {
        case .image:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .image:
            return nil
        }
    }
}
