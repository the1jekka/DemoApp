import Foundation

struct HotelListItem: Decodable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let suitesAvailability: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case stars
        case distance
        case suitesAvailability = "suites_availability"
    }
}

extension HotelListItem {
    
    var numberOfAvailableRooms: Int {
        self.suitesAvailability.split(separator: ":").count
    }
}
