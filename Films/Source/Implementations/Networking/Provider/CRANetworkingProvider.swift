import Foundation

protocol CRANetworkingProviderProtocol {
    associatedtype T: CRANetworkingRequest
    
    func request(_ target: T, completion: @escaping (Result<CRANetworkingProviderResponse, CRANetworkingProviderError>) -> Void) -> URLSessionDataTask
}

// MARK: - Networking Class
class CRANetworkingProvider<T: CRANetworkingRequest> {
    
    /// Initialized provider holding reference
    /// to the innerworkings of the service layer.
    private let service = CRANetworkingService()
}

// MARK: - Internal API
extension CRANetworkingProvider: CRANetworkingProviderProtocol {
    
    /// Request method used for requesting any service supported network calls.
    ///
    /// - Parameters:
    ///     - target: Enum holding possible network requests.
    ///     - completion: Result returning either a parsed model or an error.
    @discardableResult
    func request(_ target: T,
                 completion: @escaping (Result<CRANetworkingProviderResponse, CRANetworkingProviderError>) -> Void) -> URLSessionDataTask {
        
        // make request to specified target
        return service.request(target.urlRequest) { result in
            
            // switch on result of network request
            switch result {
                
            case .success(let response):
                
                // successful result
                completion(.success(CRANetworkingProviderResponse(data: response.data,
                                                                  request: response.request,
                                                                  response: response.response)))
                
            case .failure(let error):
                
                // something went wrong with the network request
                completion(.failure(.service(error)))
            }
        }
    }
}
