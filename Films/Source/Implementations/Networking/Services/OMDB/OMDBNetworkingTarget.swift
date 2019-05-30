//
//  OMDBNetworkingTarget.swift
//  Films
//
//  Created by Christian Ampe on 5/30/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

extension OMDB.Networking {
    enum Target: CRANetworkingRequest {
        case info(film: String)
    }
}

extension OMDB.Networking.Target {
    var baseURL: URL {
        switch self {
        case .info:
            return URL(string: "http://www.omdbapi.com")!
        }
    }
    
    var path: String {
        switch self {
        case .info:
            return "/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .info(let film):
            return ["apikey": "6ff8ac9e",
                    "t": film]
        }
    }
    
    var method: CRANetworkingRequestHTTPMethod {
        switch self {
        case .info:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .info:
            return nil
        }
    }
}
