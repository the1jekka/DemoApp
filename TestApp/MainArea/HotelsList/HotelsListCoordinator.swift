import UIKit

protocol HotelsListCoordinator: Coordinator {}

final class HotelsListCoordinatorPhone: HotelsListCoordinator {
    typealias Dependencies = HasHotelsListProvider & HotelDetailsCoordinatorFactory
    
    private let dependencies: Dependencies
    private let router: HotelsListRouter
    private let onFinish: () -> Void
    
    private var subCoordinator: Coordinator?
    
    init(
        dependencies: Dependencies,
        router: HotelsListRouter,
        onFinish: @escaping () -> Void
    ) {
        self.dependencies = dependencies
        self.router = router
        self.onFinish = onFinish
    }
    
    private(set) lazy var rootViewController: UIViewController = {
        let actions = HotelsListActions { [weak self] in
            self?.showHotelDetails(id: $0)
        } finish: {
        }
        
        return HotelsListViewController(
            dependencies: self.dependencies,
            input: HotelsListViewController.Input(actions: actions)
        )
    }()
}

// MARK: - Transitions

private extension HotelsListCoordinatorPhone {
    
    func showHotelDetails(id: Int) {
        guard let router = self.router.hotelDetailsRouter() else { return }
        let coordinator = self.dependencies.hotelDetailsCoordinator(
            hotelId: id,
            router: router
        ) { [weak self] in
            self?.subCoordinator = nil
        }
        self.subCoordinator = coordinator
        self.router.push(
            PushController(
                viewController: coordinator.rootViewController,
                animated: true
            )
        )
    }
}
