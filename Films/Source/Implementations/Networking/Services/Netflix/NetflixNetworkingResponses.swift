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

extension Netflix.Networking.Responses.Movie {
    enum Filter: String, RawRepresentable {
        case actor = "Actor"
        case director = "Director"
        case location = "Location"
        case productionCompany = "Production Company"
        case releaseYear = "Release Year"
        case writer = "Writer"
    }
}

extension Netflix.Networking.Responses.Movie.Filter {
    static let all: [Netflix.Networking.Responses.Movie.Filter] = [.actor,
                                                                   .director,
                                                                   .location,
                                                                   .productionCompany,
                                                                   .releaseYear,
                                                                   .writer]
}
