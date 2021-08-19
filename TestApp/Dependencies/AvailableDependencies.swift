import UIKit

protocol HasAppCoordinator {
    var appCoordinator: AppCoordinator { get }
}

protocol SceneCoordinatorFactory {
    func sceneCoordinator(window: UIWindow, router: SceneRouter) -> SceneCoordinator
}

protocol MainAreaCoordinatorFactory {
    func mainAreaCoordinator(router: MainAreaRouter) -> MainAreaCoordinator
}

protocol HotelsListCoordinatorFactory {
    func hotelsListCoordinator(
        router: HotelsListRouter,
        onFinish: @escaping () -> Void
    ) -> HotelsListCoordinator
}

protocol HasAPIService {
    var apiService: APIService { get }
}

protocol HasHotelsListProvider {
    var hotelsListProvider: HotelsListDataProvider { get }
}

protocol HotelDetailsProviderFactory {
    func hotelDetailsProvider(id: Int) -> HotelDetailsDataProvider
}

protocol HasHotelImageProvider {
    var hotelImageProvider: HotelImageDataProvider { get }
}

protocol HotelDetailsCoordinatorFactory {
    func hotelDetailsCoordinator(
        hotelId: Int,
        router: HotelDetailsRouter,
        onFinish: @escaping () -> Void
    ) -> HotelDetailsCoordinator
}
