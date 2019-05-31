//
//  NetflixNetworkingResponses.swift
//  Films
//
//  Created by Christian Ampe on 5/29/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

extension Netflix.Networking {
    enum Responses {
        struct Movie: Decodable {
            let actors: [String]
            let director: String
            let funFacts: String?
            let latitude: Double
            let locations: String
            let longitude: Double
            let productionCompany: String
            let releaseYear: String
            let title: String
            let writers: [String]?
        }
    }
}
