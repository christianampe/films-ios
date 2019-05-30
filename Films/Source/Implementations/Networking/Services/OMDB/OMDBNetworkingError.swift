//
//  OMDBNetworkingError.swift
//  Films
//
//  Created by Christian Ampe on 5/30/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

extension OMDB.Networking {
    enum Error: Swift.Error {
        case mapping
        case service(CRANetworkingServiceError)
    }
}
