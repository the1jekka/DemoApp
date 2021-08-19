import UIKit

protocol AppCoordinator {
    func start()
}

final class AppCoordinatorPhone: AppCoordinator {
    typealias Dependencies = AllDependencies
    
    private let dependencies: Dependencies
    private let window: UIWindow
    private var sceneCoordinator: SceneCoordinator?
    
    init(dependencies: Dependencies, window: UIWindow) {
        self.dependencies = dependencies
        self.window = window
    }
    
    func start() {
        self.window.makeKeyAndVisible()
        self.sceneCoordinator = self.dependencies.sceneCoordinator(
            window: self.window,
            router: .forPhone()
        )
        self.sceneCoordinator?.start()
    }
}
