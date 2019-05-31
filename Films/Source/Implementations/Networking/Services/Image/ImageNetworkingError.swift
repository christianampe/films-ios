//
//  ImageNetworkingError.swift
//  Films
//
//  Created by Christian Ampe on 5/31/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

extension Image.Networking {
    enum Error: Swift.Error {
        case mapping
        case service(CRANetworkingServiceError)
    }
}
