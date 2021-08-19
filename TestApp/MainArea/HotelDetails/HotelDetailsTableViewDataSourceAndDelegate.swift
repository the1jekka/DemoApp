import UIKit

final class HotelDetailsTableViewDataSourceAndDelegate: NSObject {
    
    private var items: [HotelDetailsCell] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    private weak var tableView: UITableView?
    
    init(tableView: UITableView, items: [HotelDetailsCell]) {
        self.items = items
        self.tableView = tableView
    }
    
    func update(items: [HotelDetailsCell]) {
        self.items = items
    }
    
    func add(image: UIImage) {
        if let index = self.items.firstIndex(where: {
            switch $0 {
            case .field:
                return false
            case .image:
                return true
            }
        }) {
            var mutableState = self.items
            mutableState[index] = .image(HotelDetailsCell.ImageCell(image: image))
            self.items = mutableState
        } else {
            self.items = [.image(HotelDetailsCell.ImageCell(image: image))] + self.items
        }
    }
}

// MARK: - UITableViewDataSource

extension HotelDetailsTableViewDataSourceAndDelegate: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.items.indices.contains(indexPath.row) else { return UITableViewCell() }
        
        let item = self.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: item.cellType.reuseIdentifier,
            for: indexPath
        )
        
        switch item {
        case let .field(field):
            let cell = cell as? HotelDetailsFieldTableViewCell
            cell?.fieldTitle = field.title
            cell?.fieldValue = field.value
        case let .image(image):
            let cell = cell as? HotelDetailsImageTableViewCell
            cell?.contentImage = image.image
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HotelDetailsTableViewDataSourceAndDelegate: UITableViewDelegate {
    
}
