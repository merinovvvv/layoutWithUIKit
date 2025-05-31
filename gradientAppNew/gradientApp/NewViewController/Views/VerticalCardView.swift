import UIKit

struct VerticalCardViewDescriptor {
    let image: UIImage
    let title: String
    let starImage: UIImage
    let rateTitle: String
    let countTitle: String
    let gradientColors: (startColor: UIColor?, endColor: UIColor?)
}

final class VerticalCardView: UIView {

    // MARK: - Private. UI Properties
    private let verticalStackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let starImageView = UIImageView()
    private let rateLabel = UILabel()
    private let horizontalRateStackView = UIStackView()
    private let countLabel = UILabel()
    private let gradientLayer = CAGradientLayer()

    private enum Constants {
        static let spacing: CGFloat = 24.0
        static let verticalSpacing: CGFloat = 12.0
        static let imageViewSize = CGSize(width: 27.0, height: 27.0)
        static let starImageViewSize = CGSize(width: 10.0, height: 10.0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = bounds
    }

    func configureWith(descriptor: VerticalCardViewDescriptor) {
        imageView.image = descriptor.image
        titleLabel.text = descriptor.title
        starImageView.image = descriptor.starImage
        rateLabel.text = descriptor.rateTitle
        countLabel.text = "\(description.count)     views"

        gradientLayer.colors = [
            descriptor.gradientColors.startColor?.cgColor ?? UIColor.white.cgColor,
            descriptor.gradientColors.endColor?.cgColor ?? UIColor.white.cgColor
        ]
    }
}

// MARK: - Private. Setup UI
private extension VerticalCardView {
    func setupUI() {
        setupGradient()
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }

    func setupViewHierarchy() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(horizontalRateStackView)
        horizontalRateStackView.addArrangedSubview(starImageView)
        horizontalRateStackView.addArrangedSubview(rateLabel)
        verticalStackView.addArrangedSubview(countLabel)
    }

    func setupConstraints() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalRateStackView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.spacing),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.spacing),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.spacing)
        ])

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize.height)
        ])

        NSLayoutConstraint.activate([
            starImageView.widthAnchor.constraint(equalToConstant: Constants.starImageViewSize.width),
            starImageView.heightAnchor.constraint(equalToConstant: Constants.starImageViewSize.height)
        ])
    }

    func configureViews() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.spacing = 16.0

        rateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        rateLabel.textColor = .white

        countLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        countLabel.textColor = .white

        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0

        backgroundColor = .clear
    }

    func setupGradient() {
        layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.masksToBounds = true
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [-0.3, 0.3]
    }
}
