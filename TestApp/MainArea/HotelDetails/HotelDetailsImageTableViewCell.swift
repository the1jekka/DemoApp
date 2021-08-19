import UIKit

class HotelDetailsImageTableViewCell: UITableViewCell {
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var contentImage: UIImage? {
        get { self.contentImageView.image }
        set { self.contentImageView.image = newValue }
    }
}

// MARK: - Configure

private extension HotelDetailsImageTableViewCell {
    
    func configure() {
        self.addSubviews()
        self.setupSubviews()
    }
    
    func addSubviews() {
        self.contentView.addSubview(self.contentImageView)
    }
    
    func setupSubviews() {
        self.setupContentImageView()
    }
    
    func setupContentImageView() {
        self.contentImageView.leadingAnchor
            .constraint(equalTo: self.contentView.leadingAnchor)
            .isActive = true
        self.contentImageView.trailingAnchor
            .constraint(equalTo: self.contentView.trailingAnchor)
            .isActive = true
        self.contentImageView.topAnchor
            .constraint(equalTo: self.contentView.topAnchor)
            .isActive = true
        self.contentImageView.bottomAnchor
            .constraint(equalTo: self.contentView.bottomAnchor)
            .isActive = true
    }
}
