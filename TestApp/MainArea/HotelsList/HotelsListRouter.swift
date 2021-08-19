import UIKit

struct HotelsListRouter {
    let hotelDetailsRouter: () -> HotelDetailsRouter?
    let push: (PushController) -> Void
}

extension HotelsListRouter {
    
    static func forPhone(_ navigationController: UINavigationController) -> HotelsListRouter {
        HotelsListRouter { [weak navigationController] in
            guard let navigationController = navigationController else { return nil }
            return HotelDetailsRouter.forPhone(navigationController)
        } push: { [weak navigationController] in
            navigationController?.pushViewController($0.viewController, animated: $0.animated)
        }
    }
}
