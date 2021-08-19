import UIKit

class HotelDetailsFieldTableViewCell: UITableViewCell {
    
    private let fieldView = FieldView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fieldTitle: String? {
        get { self.fieldView.title }
        set { self.fieldView.title = newValue }
    }
    
    var fieldValue: String? {
        get { self.fieldView.value }
        set { self.fieldView.value = newValue }
    }
}

// MARK: - Configure

private extension HotelDetailsFieldTableViewCell {
    
    func configure() {
        self.selectionStyle = .none
        self.addSubviews()
        self.setupSubviews()
    }
    
    func addSubviews() {
        self.contentView.addSubview(self.fieldView)
    }
    
    func setupSubviews() {
        self.setupFieldView()
    }
    
    func setupFieldView() {
        self.fieldView.translatesAutoresizingMaskIntoConstraints = false
        
        self.fieldView.leadingAnchor
            .constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: Constants.defaultHSpacing
            )
            .isActive = true
        self.fieldView.trailingAnchor
            .constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -Constants.defaultHSpacing
            )
            .isActive = true
        self.fieldView.topAnchor
            .constraint(
                equalTo: self.contentView.topAnchor,
                constant: Constants.defaultVSpacing
            )
            .isActive = true
        self.fieldView.bottomAnchor
            .constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -Constants.defaultHSpacing
            )
            .isActive = true
    }
}

// MARK: - Constants

private extension HotelDetailsFieldTableViewCell {
    enum Constants {
        static var defaultHSpacing: CGFloat { 8 }
        static var defaultVSpacing: CGFloat { 8 }
    }
}
