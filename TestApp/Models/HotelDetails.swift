import Foundation

struct HotelDetails: Decodable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let image: String
    let suitesAvailability: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case stars
        case distance
        case image
        case suitesAvailability = "suites_availability"
        case latitude = "lat"
        case longitude = "lon"
    }
}

extension HotelDetails {
    
    var availableRooms: [String] {
        self.suitesAvailability.split(separator: ":").map { String($0) }
    }
}
