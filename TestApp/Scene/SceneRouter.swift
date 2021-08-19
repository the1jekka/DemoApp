import UIKit

struct SceneRouter {
    let mainAreaRouter: () -> MainAreaRouter
}

extension SceneRouter {
    
    static func forPhone() -> SceneRouter {
        SceneRouter {
            MainAreaRouter.forPhone()
        }
    }
}
