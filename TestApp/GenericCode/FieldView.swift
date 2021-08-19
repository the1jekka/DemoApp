import UIKit

class FieldView: UIView {
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String? {
        get { self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    var value: String? {
        get { self.valueLabel.text }
        set { self.valueLabel.text = newValue }
    }
    
    var titleAlignment: NSTextAlignment {
        get { self.titleLabel.textAlignment }
        set { self.titleLabel.textAlignment = newValue }
    }
    
    var valueAlignment: NSTextAlignment {
        get { self.valueLabel.textAlignment }
        set { self.valueLabel.textAlignment = newValue }
    }
}

// MARK: - Configure

private extension FieldView {
    
    func configure() {
        self.addSbuviews()
        self.setupSubviews()
    }
    
    func addSbuviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.valueLabel)
    }
    
    func setupSubviews() {
        self.setupTitleLabel()
        self.setupValueLabel()
    }
    
    func setupTitleLabel() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.topAnchor
            .constraint(equalTo: self.topAnchor)
            .isActive = true
        self.titleLabel.leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
            .isActive = true
        self.titleLabel.trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
            .isActive = true
    }
    
    func setupValueLabel() {
        self.valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.valueLabel.topAnchor
            .constraint(equalTo: self.titleLabel.bottomAnchor)
            .isActive = true
        self.valueLabel.bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
            .isActive = true
        self.valueLabel.leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
            .isActive = true
        self.valueLabel.trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
            .isActive = true
    }
}
