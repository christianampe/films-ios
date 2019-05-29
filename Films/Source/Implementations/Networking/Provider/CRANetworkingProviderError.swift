import Foundation

enum CRANetworkingProviderError: Error {
    
    /// Returned when with the associated networking service error.
    case service(CRANetworkingServiceError)
}
