import Foundation

enum CRANetworkingServiceError: Error {
    
    /// Returned when no response is returned from the server.
    case unresponsive
    
    /// Returned when the data task returns an error.
    case underlying(Error)
}
