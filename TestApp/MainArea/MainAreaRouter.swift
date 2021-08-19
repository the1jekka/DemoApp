import UIKit

struct MainAreaRouter {
    let hotelsListRouter: (UINavigationController) -> HotelsListRouter
}

extension MainAreaRouter {
    
    static func forPhone() -> MainAreaRouter {
        MainAreaRouter {
            HotelsListRouter.forPhone($0)
        }
    }
}
