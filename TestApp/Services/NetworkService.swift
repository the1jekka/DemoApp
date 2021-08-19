import Foundation

protocol NetworkService {
    func request(
        _ endpoint: APIEndpoint,
        completion: @escaping (Result<Data, APIError>) -> Void
    )
}

struct DefaultNetworkService: NetworkService {
    private let session = URLSession(configuration: .default)
    
    func request(
        _ endpoint: APIEndpoint,
        completion: @escaping (Result<Data, APIError>) -> Void
    ) {
        session.dataTask(with: endpoint.request) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(.wrapped(error)))
            } else {
                completion(.failure(.unknown))
            }
        }
        .resume()
    }
}

extension APIEndpoint {
    
    var request: URLRequest {
        var request = URLRequest(url: self.baseURL.appendingPathComponent(self.path))
        request.httpMethod = self.method.rawValue
        
        return request
    }
}
