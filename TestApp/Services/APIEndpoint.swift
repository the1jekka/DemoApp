import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
}

enum HttpMethod: String {
    case get
    case post
    case put
    case delete
}

enum DefaultAPIEndpoint: APIEndpoint {
    case fetchHotelsList(String)
    case fetchHotelDetails(Int)
    case fetchHotelImage(String)
    
    var baseURL: URL {
        Config.shared.baseUrl
    }
    
    var path: String {
        switch self {
        case let .fetchHotelDetails(id):
            return "iMofas/ios-android-test/master/\(id).json"
        case let .fetchHotelImage(image):
            return "iMofas/ios-android-test/master/\(image)"
        case let .fetchHotelsList(id):
            return "iMofas/ios-android-test/master/\(id).json"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .fetchHotelDetails,
             .fetchHotelImage,
             .fetchHotelsList:
            return .get
        }
    }
}
