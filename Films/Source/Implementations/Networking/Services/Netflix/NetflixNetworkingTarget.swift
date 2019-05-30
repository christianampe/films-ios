//
//  NetflixNetworkingTarget.swift
//  Films
//
//  Created by Christian Ampe on 5/29/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

extension Netflix.Networking {
    enum Target: CRANetworkingRequest {
        case films
    }
}

extension Netflix.Networking.Target {
    var baseURL: URL {
        switch self {
        case .films:
            return URL(string: "http://assets.nflxext.com")!
        }
    }
    
    var path: String {
        switch self {
        case .films:
            return "/ffe/siteui/iosui/filmData.json"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .films:
            return nil
        }
    }
    
    var method: CRANetworkingRequestHTTPMethod {
        switch self {
        case .films:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .films:
            return nil
        }
    }
}
