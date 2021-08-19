import UIKit

final class HotelDetailsViewController: UIViewController {
    typealias Dependencies = HotelDetailsProviderFactory & HasHotelImageProvider
    
    private let dependencies: Dependencies
    private let hotelDetailsProvider: HotelDetailsDataProvider
    private let actions: HotelDetailsActions
    
    private let observerId = UUID().uuidString
    private lazy var providerObserver = AnyObserver(observer: self)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        
        HotelDetailsCellType.allCases.forEach {
            tableView.register($0.cellClass, forCellReuseIdentifier: $0.reuseIdentifier)
        }
        
        return tableView
    }()
    
    private lazy var tableViewDelegateAndDataSource = HotelDetailsTableViewDataSourceAndDelegate(
        tableView: self.tableView,
        items: self.hotelDetailsProvider.hotel.value?.cells ?? []
    )
    
    init(dependencies: Dependencies, input: Input) {
        self.dependencies = dependencies
        self.hotelDetailsProvider = dependencies.hotelDetailsProvider(id: input.hotelId)
        self.actions = input.actions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.isMovingFromParent ||
            self.isBeingDismissed ||
            self.navigationController?.isBeingDismissed == true {
            self.hotelDetailsProvider.hotel.removeObserver(self.providerObserver)
            self.actions.finish()
        }
    }
}

// MARK: - Input

extension HotelDetailsViewController {
    
    struct Input {
        let hotelId: Int
        let actions: HotelDetailsActions
    }
}

// MARK: - Configure

private extension HotelDetailsViewController {
    
    func configure() {
        self.addSubviews()
        self.setupTableView()
        self.startObserving()
        self.refreshData()
        
        self.tableView.dataSource = self.tableViewDelegateAndDataSource
        self.tableView.delegate = self.tableViewDelegateAndDataSource
    }
    
    func addSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    func setupSubviews() {
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func startObserving() {
        self.hotelDetailsProvider.hotel.addObserver(self.providerObserver)
    }
    
    func refreshData() {
        SpinnerTableBackgroundProvider.addSpinner(to: self.tableView)
        self.hotelDetailsProvider.refresh { [weak self] in
            self?.tableView.backgroundView = nil
        }
    }
    
    func loadImage(for hotelDetails: HotelDetails?) {
        guard let name = hotelDetails?.image else { return }
        self.dependencies.hotelImageProvider.image(
            with: name,
            targetWidth: tableView.bounds.width,
            scale: UIScreen.main.scale
        ) { [weak self] in
            guard let image = $0 else { return }
            self?.tableViewDelegateAndDataSource.add(image: image)
        }
    }
}

extension HotelDetailsViewController: ObserverProtocol {
    typealias T = HotelDetails?
    
    var id: String {
        self.observerId
    }
    
    func onValueChanged(_ value: HotelDetails??) {
        guard let value = value else { return }
        self.tableViewDelegateAndDataSource.update(items: value?.cells ?? [])
        self.loadImage(for: value)
    }
}

private extension HotelDetails {
    
    var cells: [HotelDetailsCell] {
        [
            .field(HotelDetailsCell.FieldCell(title: "Name", value: self.name)),
            .field(HotelDetailsCell.FieldCell(title: "Address", value: self.address)),
            .field(HotelDetailsCell.FieldCell(title: "Rating", value: String(self.stars))),
            .field(HotelDetailsCell.FieldCell(title: "Distance", value: String(self.distance))),
            .field(
                HotelDetailsCell.FieldCell(
                    title: "Available Rooms",
                    value: self.availableRooms.joined(separator: ", ")
                )
            )
        ]
    }
}
