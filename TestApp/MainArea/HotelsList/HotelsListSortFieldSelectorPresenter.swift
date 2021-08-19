import UIKit

struct HotelsListSortFieldSelectorPresenter {
    
    static func show(
        from viewController: UIViewController,
        onFinish: @escaping (HotelsListSortField) -> Void
    ) {
        let alertController = UIAlertController(
            title: "Sort by:",
            message: nil,
            preferredStyle: .actionSheet
        )
        HotelsListSortField.allCases.forEach { field in
            alertController.addAction(
                UIAlertAction(title: field.title, style: .default) { _ in
                    onFinish(field)
                }
            )
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
