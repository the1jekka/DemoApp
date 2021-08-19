import UIKit

enum HotelDetailsCell {
    case field(FieldCell)
    case image(ImageCell)
}

enum HotelDetailsCellType: CaseIterable {
    case field
    case image
    
    var reuseIdentifier: String {
        switch self {
        case .field:
            return HotelDetailsFieldTableViewCell.reuseIdentifier
        case .image:
            return HotelDetailsImageTableViewCell.reuseIdentifier
        }
    }
    
    var cellClass: UITableViewCell.Type {
        switch self {
        case .field:
            return HotelDetailsFieldTableViewCell.self
        case .image:
            return HotelDetailsImageTableViewCell.self
        }
    }
}

extension HotelDetailsCell {
    
    var cellType: HotelDetailsCellType {
        switch self {
        case .field:
            return .field
        case .image:
            return .image
        }
    }
}

extension HotelDetailsCell {
    
    struct FieldCell {
        let title: String
        let value: String
    }
    
    struct ImageCell {
        let image: UIImage
    }
}
