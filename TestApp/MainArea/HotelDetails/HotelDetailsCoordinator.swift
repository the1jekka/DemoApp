import UIKit

protocol HotelDetailsCoordinator: Coordinator {}

struct HotelDetailsCoordinatorPhone: HotelDetailsCoordinator {
    typealias Dependencies = HotelDetailsProviderFactory & HasHotelImageProvider
    
    let router: HotelDetailsRouter
    let rootViewController: UIViewController
    
    init(
        dependencies: Dependencies,
        hotelId: Int,
        router: HotelDetailsRouter,
        onFinish: @escaping () -> Void
    ) {
        let actions = HotelDetailsActions {
            onFinish()
        }
        self.rootViewController = HotelDetailsViewController(
            dependencies: dependencies,
            input: HotelDetailsViewController.Input(
                hotelId: hotelId,
                actions: actions
            )
        )
        self.router = router
    }
}
