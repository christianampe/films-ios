import Foundation

// MARK: - Networking Class
class CRANetworkingProvider<T: CRANetworkingRequest> {
    
    /// Initialized provider holding reference to the innerworkings of the service layer.
    private let service = CRANetworkingService()
    
    /// Initialized in-memory cache utilized before making a network call.
    private let memoryCache = CRAMemoryCache<CRANetworkingProviderResponse>()
}

// MARK: - Internal API
extension CRANetworkingProvider {
   
    /// Request method used for requesting any service supported network calls.
    ///
    /// - Parameters:
    ///   - target: Enum holding possible network requests
    ///   - completion: Result returning either a parsed model or an error.
    /// - Returns: A session data task if a new network call is made. Nil if the cache is utilized.
    @discardableResult
    func request(_ target: T,
                 completion: @escaping (Result<CRANetworkingProviderResponse, CRANetworkingProviderError>) -> Void) -> URLSessionDataTask? {
        
        // check the cache for a previous matching query
        if let targetURLString = target.urlRequest.url?.absoluteString, let cachedResponse = memoryCache.object(forKey: targetURLString) {
            
            // successful result from the cache
            completion(.success(CRANetworkingProviderResponse(data: cachedResponse.data,
                                                              request: cachedResponse.request,
                                                              response: cachedResponse.response)))
            
            // no url session data task available due to the utilization of a cache
            return nil
            
        } else {
            
            // make request to specified target
            return service.request(target.urlRequest) { [weak memoryCache] result in
                guard let memoryCache = memoryCache else { return }
                
                // switch on result of network request
                switch result {
                    
                case .success(let response):
                    
                    let providerResponse = CRANetworkingProviderResponse(data: response.data,
                                                                         request: response.request,
                                                                         response: response.response)
                    
                    // cache the successful response
                    if let requestURL = response.request.url {
                        memoryCache.setObject(providerResponse, forKey: requestURL.absoluteString)
                    }
                    
                    // successful result
                    completion(.success(providerResponse))
                    
                case .failure(let error):
                    
                    // something went wrong with the network request
                    completion(.failure(.service(error)))
                }
            }
        }
    }
}
