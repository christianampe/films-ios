//
//  NetflixNetworkingError.swift
//  Films
//
//  Created by Christian Ampe on 5/29/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

extension Netflix.Networking {
    enum Error: Swift.Error {
        case mapping
        case service(CRANetworkingServiceError)
    }
}
