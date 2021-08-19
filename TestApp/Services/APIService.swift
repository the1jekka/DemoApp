import Foundation

protocol APIService {
    func fetchHotelsList(id: String, completion: @escaping (Result<[HotelListItem], APIError>) -> Void)
    func fetchHotelDetails(id: Int, completion: @escaping (Result<HotelDetails, APIError>) -> Void)
    func fetchHotelImage(imageName: String, completion: @escaping (Result<Data, APIError>) -> Void)
}

final class DefaultAPIService: APIService {
    private let networkService: NetworkService = DefaultNetworkService()
    
    func fetchHotelsList(id: String, completion: @escaping (Result<[HotelListItem], APIError>) -> Void) {
        self.networkService.request(DefaultAPIEndpoint.fetchHotelsList(id)) {
            switch $0 {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                do {
                    let values = try JSONDecoder().decode(
                        [HotelListItem].self,
                        from: data
                    )
                    completion(.success(values))
                } catch {
                    completion(.failure(.decoding))
                }
            }
        }
    }
    
    func fetchHotelDetails(id: Int, completion: @escaping (Result<HotelDetails, APIError>) -> Void) {
        self.networkService.request(DefaultAPIEndpoint.fetchHotelDetails(id)) {
            switch $0 {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                do {
                    let value = try JSONDecoder().decode(
                        HotelDetails.self,
                        from: data
                    )
                    completion(.success(value))
                } catch {
                    completion(.failure(.decoding))
                }
            }
        }
    }
    
    func fetchHotelImage(imageName: String, completion: @escaping (Result<Data, APIError>) -> Void) {
        self.networkService.request(DefaultAPIEndpoint.fetchHotelImage(imageName)) {
            switch $0 {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                completion(.success(data))
            }
        }
    }
}
