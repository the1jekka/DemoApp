import UIKit

protocol MainAreaCoordinator: RootCoordinator {
    func start() -> UIViewController
}

private struct MainAreaSubCoordinators {
    let hotelsList: HotelsList
    
    struct HotelsList {
        let coordinator: HotelsListCoordinator
        let router: HotelsListRouter
        let navigationController: UINavigationController
    }
}

final class MainAreaCoordinatorPhone: MainAreaCoordinator {
    typealias Dependencies = AllDependencies
    
    private let dependencies: Dependencies
    private let router: MainAreaRouter
    private var subcoordinators: MainAreaSubCoordinators?
    
    init(dependencies: Dependencies, router: MainAreaRouter) {
        self.dependencies = dependencies
        self.router = router
    }
    
    func start() -> UIViewController {
        let subcoordinators = self.createSubcoordinators()
        self.subcoordinators = subcoordinators
        
        return subcoordinators.hotelsList.navigationController
    }
}

// MARK: - CreateSubcoordinators

private extension MainAreaCoordinatorPhone {
    
    func createSubcoordinators() -> MainAreaSubCoordinators {
        let navigationController = UINavigationController()
        let router = self.router.hotelsListRouter(navigationController)
        let coordinator = self.dependencies.hotelsListCoordinator(router: router, onFinish: {})
        navigationController.setViewControllers([coordinator.rootViewController], animated: false)
        
        return MainAreaSubCoordinators(
            hotelsList: MainAreaSubCoordinators.HotelsList(
                coordinator: coordinator,
                router: router,
                navigationController: navigationController
            )
        )
    }
}
