import UIKit

struct SpinnerTableBackgroundProvider {
    
    static func addSpinner(to tableView: UITableView) {
        tableView.backgroundView = Self.loadingBackgroundView
    }
    
    private static var loadingBackgroundView: UIView {
        let view = UIView()
        let activityContainerView = UIView()
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        
        view.addSubview(activityContainerView)
        activityContainerView.addSubview(activityIndicator)
        
        activityContainerView.backgroundColor = .black
        activityContainerView.alpha = 0.2
        activityContainerView.layer.cornerRadius = 8
        activityContainerView.layer.masksToBounds = true
        activityContainerView.translatesAutoresizingMaskIntoConstraints = false
        activityContainerView.centerXAnchor
            .constraint(equalTo: view.centerXAnchor)
            .isActive = true
        activityContainerView.centerYAnchor
            .constraint(equalTo: view.centerYAnchor)
            .isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.leadingAnchor
            .constraint(
                equalTo: activityContainerView.leadingAnchor,
                constant: 16
            )
            .isActive = true
        activityIndicator.trailingAnchor
            .constraint(
                equalTo: activityContainerView.trailingAnchor,
                constant: -16
            )
            .isActive = true
        activityIndicator.topAnchor
            .constraint(
                equalTo: activityContainerView.topAnchor,
                constant: 16
            )
            .isActive = true
        activityIndicator.bottomAnchor
            .constraint(
                equalTo: activityContainerView.bottomAnchor,
                constant: -16
            )
            .isActive = true
        
        activityIndicator.startAnimating()
        
        return view
    }
}
