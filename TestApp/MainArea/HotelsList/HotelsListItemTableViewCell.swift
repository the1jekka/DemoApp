import UIKit

final class HotelsListItemTableViewCell: UITableViewCell {
    
    private lazy var contentBackroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = self.contentCornerRadius
//        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let fieldsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let ratingFieldView = HotelsListItemTableViewCell.fieldView(
        with: "Rating"
    )
    private let distanceFieldView = HotelsListItemTableViewCell.fieldView(
        with: "Distance"
    )
    private let availableRoomsFieldView = HotelsListItemTableViewCell.fieldView(
        with: "Available Rooms"
    )
    
    private var contentCornerRadius: CGFloat {
        2 * Constants.defaultVSpacing
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(parameters: Parameters) {
        self.nameLabel.text = parameters.name
        self.addressLabel.text = parameters.address
        self.ratingFieldView.value = parameters.rating
        self.distanceFieldView.value = parameters.distance
        self.availableRoomsFieldView.value = parameters.availableRooms
    }
}

// MARK: - Parameters

extension HotelsListItemTableViewCell {
    
    struct Parameters {
        let name: String
        let address: String
        let rating: String
        let distance: String
        let availableRooms: String
    }
}

// MARK: - Configure

private extension HotelsListItemTableViewCell {
    
    func configure() {
        self.selectionStyle = .none
        self.addSubviews()
        self.setupSubviews()
    }
    
    func addSubviews() {
        self.contentView.addSubview(self.shadowView)
        self.shadowView.addSubview(self.contentBackroundView)
        self.contentBackroundView.addSubview(self.nameLabel)
        self.contentBackroundView.addSubview(self.addressLabel)
        self.contentBackroundView.addSubview(self.fieldsStackView)
        
        self.fieldsStackView.addArrangedSubview(self.ratingFieldView)
        self.fieldsStackView.addArrangedSubview(self.availableRoomsFieldView)
        self.fieldsStackView.addArrangedSubview(self.distanceFieldView)
    }
    
    func setupSubviews() {
        self.setupShadowView()
        self.setupContentBackgroundView()
        self.setupNameLabel()
        self.setupAddressLabel()
        self.setupFieldsStackView()
    }
    
    func setupShadowView() {
        self.shadowView.leadingAnchor
            .constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: 2 * Constants.defaultHSpacing
            )
            .isActive = true
        self.shadowView.trailingAnchor
            .constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -2 * Constants.defaultHSpacing
            )
            .isActive = true
        self.shadowView.topAnchor
            .constraint(
                equalTo: self.contentView.topAnchor,
                constant: Constants.defaultVSpacing
            )
            .isActive = true
        self.shadowView.bottomAnchor
            .constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -Constants.defaultVSpacing
            )
            .isActive = true
    }
    
    func setupContentBackgroundView() {
        self.contentBackroundView.leadingAnchor
            .constraint(equalTo: self.shadowView.leadingAnchor)
            .isActive = true
        self.contentBackroundView.trailingAnchor
            .constraint(equalTo: self.shadowView.trailingAnchor)
            .isActive = true
        self.contentBackroundView.topAnchor
            .constraint(equalTo: self.shadowView.topAnchor)
            .isActive = true
        self.contentBackroundView.bottomAnchor
            .constraint(equalTo: self.shadowView.bottomAnchor)
            .isActive = true
    }
    
    func setupNameLabel() {
        self.nameLabel.leadingAnchor
            .constraint(
                equalTo: self.contentBackroundView.leadingAnchor,
                constant: 2 * Constants.defaultHSpacing
            )
            .isActive = true
        self.nameLabel.trailingAnchor
            .constraint(
                equalTo: self.contentBackroundView.trailingAnchor,
                constant: -2 * Constants.defaultHSpacing
            )
            .isActive = true
        self.nameLabel.topAnchor
            .constraint(
                equalTo: self.contentBackroundView.topAnchor,
                constant: 2 * Constants.defaultVSpacing
            )
            .isActive = true
    }
    
    func setupAddressLabel() {
        self.addressLabel.leadingAnchor
            .constraint(
                equalTo: self.contentBackroundView.leadingAnchor,
                constant: 2 * Constants.defaultHSpacing
            )
            .isActive = true
        self.addressLabel.trailingAnchor
            .constraint(
                equalTo: self.contentBackroundView.trailingAnchor,
                constant: -2 * Constants.defaultHSpacing
            )
            .isActive = true
        self.addressLabel.topAnchor
            .constraint(
                equalTo: self.nameLabel.bottomAnchor,
                constant: 0.5 * Constants.defaultVSpacing
            )
            .isActive = true
    }
    
    func setupFieldsStackView() {
        self.fieldsStackView.leadingAnchor
            .constraint(
                equalTo: self.contentBackroundView.leadingAnchor,
                constant: 2 * Constants.defaultHSpacing
            )
            .isActive = true
        self.fieldsStackView.trailingAnchor
            .constraint(
                equalTo: self.contentBackroundView.trailingAnchor,
                constant: -2 * Constants.defaultHSpacing
            )
            .isActive = true
        self.fieldsStackView.topAnchor
            .constraint(
                equalTo: self.addressLabel.bottomAnchor,
                constant: 0.5 * Constants.defaultVSpacing
            )
            .isActive = true
        self.fieldsStackView.bottomAnchor
            .constraint(
                equalTo: self.contentBackroundView.bottomAnchor,
                constant: -2 * Constants.defaultVSpacing
            )
            .isActive = true
    }
}

// MARK: - FieldView

private extension HotelsListItemTableViewCell {
    
    static func fieldView(with title: String) -> FieldView {
        let view = FieldView()
        view.title = title
        view.titleAlignment = .center
        view.valueAlignment = .center
        
        return view
    }
}

// MARK: - Constants

private extension HotelsListItemTableViewCell {
    enum Constants {
        static var defaultVSpacing: CGFloat { 8 }
        static var defaultHSpacing: CGFloat { 8 }
    }
}
