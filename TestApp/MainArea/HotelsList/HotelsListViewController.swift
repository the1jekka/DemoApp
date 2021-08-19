import UIKit

enum HotelsListSortField: CaseIterable {
    case distance
    case availableRooms
    
    var title: String {
        switch self {
        case .distance:
            return "Distance"
        case .availableRooms:
            return "Available Rooms"
        }
    }
}

final class HotelsListViewController: UIViewController {
    typealias Dependencies = HasHotelsListProvider
    
    private let dependencies: Dependencies
    private let actions: HotelsListActions
    private let tableView = UITableView()
    private let observerId = UUID().uuidString
    
    private lazy var itemsObserver = AnyObserver(observer: self)
    
    private lazy var tableViewDelegateAndDataSource =
        HotelsListTableViewDataSourceAndDelegate(
            tableView: self.tableView,
            items: self.dependencies.hotelsListProvider.hotels.value
        )
    
    init(dependencies: Dependencies, input: Input) {
        self.dependencies = dependencies
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
            self.dependencies.hotelsListProvider.hotels.removeObserver(self.itemsObserver)
            self.actions.finish()
        }
    }
}

// MARK: - Input

extension HotelsListViewController {
    
    struct Input {
        let actions: HotelsListActions
    }
}

// MARK: - Configure

private extension HotelsListViewController {
    
    func configure() {
        self.addSubviews()
        self.setupSubviews()
        self.setupNavigationBar()
        self.startObserving()
        self.refreshData()
        
        self.tableViewDelegateAndDataSource.onSelectItem = { [weak self] in
            self?.actions.showHotelDetails($0.id)
        }
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
        self.tableView.tableFooterView = UIView()
        self.tableView.register(
            HotelsListItemTableViewCell.self,
            forCellReuseIdentifier: HotelsListItemTableViewCell.reuseIdentifier
        )
        self.tableView.separatorStyle = .none
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sort",
            style: .plain,
            target: self,
            action: #selector(showSortFieldSelector)
        )
    }
    
    func refreshData() {
        SpinnerTableBackgroundProvider.addSpinner(to: self.tableView)
        self.dependencies.hotelsListProvider.refresh { [weak self] in
            self?.tableView.backgroundView = nil
        }
    }
    
    func startObserving() {
        self.dependencies.hotelsListProvider.hotels.addObserver(
            self.itemsObserver
        )
    }
}

// MARK: - ButtonAction

private extension HotelsListViewController {
    
    @objc func showSortFieldSelector() {
        HotelsListSortFieldSelectorPresenter.show(from: self) { [weak self] in
            self?.tableViewDelegateAndDataSource.update(sortField: $0)
        }
    }
}

// MARK: - ObserverProtocol

extension HotelsListViewController: ObserverProtocol {
    typealias T = [HotelListItem]
    
    var id: String {
        self.observerId
    }
    
    func onValueChanged(_ value: [HotelListItem]?) {
        self.tableViewDelegateAndDataSource.update(items: value ?? [])
    }
}
