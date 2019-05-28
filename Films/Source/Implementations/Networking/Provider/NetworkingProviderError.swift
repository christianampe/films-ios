//
//  NetworkingError.swift
//  WeedmapsChallenge
//
//  Created by Christian Ampe on 5/25/19.
//  Copyright © 2019 Weedmaps, LLC. All rights reserved.
//

import Foundation

extension NetworkingProvider {
    enum Error: Swift.Error {
        
        /// Returned when with the associated networking service error.
        case service(NetworkingService.Error)
    }
}
