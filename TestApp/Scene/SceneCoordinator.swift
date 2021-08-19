import UIKit

protocol SceneCoordinator {
    func start()
}

enum SceneCoordinatorState {
    case initial
    case authenticated
}

final class SceneCoordinatorPhone: SceneCoordinator {
    typealias Dependencies = MainAreaCoordinatorFactory
    
    private let dependencies: Dependencies
    private let window: UIWindow
    private let router: SceneRouter
    private var subcoordinator: RootCoordinator?
    
    private var state = SceneCoordinatorState.initial {
        didSet {
            guard self.state != oldValue else { return }
            self.updateWindow()
        }
    }
    
    init(dependencies: Dependencies, window: UIWindow, router: SceneRouter) {
        self.dependencies = dependencies
        self.window = window
        self.router = router
        
        window.rootViewController = SplashScreenViewController()
    }
    
    func start() {
        self.state = .authenticated
    }
}

// MARK: - UpdateWindow

private extension SceneCoordinatorPhone {
    
    func updateWindow() {
        switch self.state {
        case .authenticated:
            self.showMainArea()
        case .initial:
            break
        }
    }
    
    func showMainArea() {
        let coordinator = self.dependencies.mainAreaCoordinator(router: self.router.mainAreaRouter())
        self.window.rootViewController = coordinator.start()
        self.subcoordinator = coordinator
    }
}
