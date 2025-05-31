import UIKit

struct HorizontalCardViewDescriptor {
    let image: UIImage
    let arrowImage: UIImage
    let title: String
    let gradientColors: (startColor: UIColor?, endColor: UIColor?)
    let action: () -> Void
}

final class HorizontalCardView: UIView {

    // MARK: - Private. UI Properties
    private let horizontalStackView = UIStackView()
    private let imageView = UIImageView()
    private let arrowButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let verticalStackView = UIStackView()
    private let gradientLayer = CAGradientLayer()

    private enum Constants {
        static let spacing: CGFloat = 24.0
        static let verticalSpacing: CGFloat = 12.0
        static let imageViewSize = CGSize(width: 27.0, height: 27.0)
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

    func configureWith(descriptor: HorizontalCardViewDescriptor) {
        imageView.image = descriptor.image
        arrowButton.setImage(descriptor.arrowImage, for: .normal)
        titleLabel.text = descriptor.title
        arrowButton.addAction(
            UIAction { _ in descriptor.action() },
            for: .touchUpInside
        )

        gradientLayer.colors = [
            descriptor.gradientColors.startColor?.cgColor ?? UIColor.white.cgColor,
            descriptor.gradientColors.endColor?.cgColor ?? UIColor.white.cgColor
        ]
    }
}

// MARK: - Private. Setup UI
private extension HorizontalCardView {
    func setupUI() {
        setupGradient()
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }

    func setupViewHierarchy() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(imageView)
        horizontalStackView.addArrangedSubview(arrowButton)
        verticalStackView.addArrangedSubview(titleLabel)
    }

    func setupConstraints() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

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
            arrowButton.widthAnchor.constraint(equalToConstant: Constants.imageViewSize.width),
            arrowButton.heightAnchor.constraint(equalToConstant: Constants.imageViewSize.height)
        ])
    }

    func configureViews() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16.0

        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.spacing = 0.0

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
