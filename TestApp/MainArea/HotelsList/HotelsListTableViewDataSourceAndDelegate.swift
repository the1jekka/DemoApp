import UIKit

final class HotelsListTableViewDataSourceAndDelegate: NSObject {
    
    private var items: [HotelListItem] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    private weak var tableView: UITableView?
    
    var onSelectItem: ((HotelListItem) -> Void)?
    
    init(tableView: UITableView, items: [HotelListItem]) {
        self.tableView = tableView
        self.items = items
    }
    
    func update(items: [HotelListItem]) {
        self.items = items
    }
    
    func update(sortField: HotelsListSortField) {
        switch sortField {
        case .availableRooms:
            self.items = self.items.sorted {
                $0.numberOfAvailableRooms < $1.numberOfAvailableRooms
            }
        case .distance:
            self.items = self.items.sorted { $0.distance < $1.distance }
        }
    }
}

// MARK: - UITableViewDataSource

extension HotelsListTableViewDataSourceAndDelegate: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HotelsListItemTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? HotelsListItemTableViewCell,
        self.items.indices.contains(indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(parameters: self.items[indexPath.row].cellParameters)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HotelsListTableViewDataSourceAndDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.items.indices.contains(indexPath.row) else { return }
        self.onSelectItem?(self.items[indexPath.row])
    }
}

// MARK: - CellParameters

private extension HotelListItem {
    
    var cellParameters: HotelsListItemTableViewCell.Parameters {
        HotelsListItemTableViewCell.Parameters(
            name: self.name,
            address: self.address,
            rating: String(self.stars),
            distance: String(self.distance),
            availableRooms: String(self.numberOfAvailableRooms)
        )
    }
}
