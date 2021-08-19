import UIKit

typealias AllDependencies = HasAppCoordinator & SceneCoordinatorFactory & MainAreaCoordinatorFactory &
    HotelsListCoordinatorFactory & HasAPIService & HasHotelsListProvider & HotelDetailsProviderFactory &
    HasHotelImageProvider & HotelDetailsCoordinatorFactory

final class DependencyContainerPhone: AllDependencies {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    lazy var appCoordinator: AppCoordinator = AppCoordinatorPhone(
        dependencies: self,
        window: self.window
    )
    lazy var apiService: APIService = DefaultAPIService()
    lazy var hotelsListProvider: HotelsListDataProvider = DefaultHotelsListDataProvider(dependencies: self)
    lazy var hotelImageProvider: HotelImageDataProvider = DefaultHotelImageDataProvider(dependencies: self)
    
    func sceneCoordinator(window: UIWindow, router: SceneRouter) -> SceneCoordinator {
        SceneCoordinatorPhone(dependencies: self, window: window, router: router)
    }
    
    func mainAreaCoordinator(router: MainAreaRouter) -> MainAreaCoordinator {
        MainAreaCoordinatorPhone(dependencies: self, router: router)
    }
    
    func hotelsListCoordinator(
        router: HotelsListRouter,
        onFinish: @escaping () -> Void
    ) -> HotelsListCoordinator {
        HotelsListCoordinatorPhone(dependencies: self, router: router, onFinish: onFinish)
    }
    
    func hotelDetailsProvider(id: Int) -> HotelDetailsDataProvider {
        DefaultHotelDetailsDataProvider(dependencies: self, hotelId: id)
    }
    
    func hotelDetailsCoordinator(
        hotelId: Int,
        router: HotelDetailsRouter,
        onFinish: @escaping () -> Void
    ) -> HotelDetailsCoordinator {
        HotelDetailsCoordinatorPhone(
            dependencies: self,
            hotelId: hotelId,
            router: router,
            onFinish: onFinish
        )
    }
}
