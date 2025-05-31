import Foundation
import UIKit

final class NewViewController: UIViewController {

    // MARK: - Private. UI Properties
    private let topStackView = UIStackView()
    private let titleLabel = UILabel()
    private let headerButton = UIButton(type: .system)
    private let headerImageView = UIImageView()

    private let cardsHorizontalStackView = UIStackView()
    private let cardsLeftVerticalStackView = UIStackView()
    private let cardsRightVerticalStackView = UIStackView()
    private let tikTokCardView = VerticalCardView()
    private let artCardView = HorizontalCardView()
    private let youtubeCardView = VerticalCardView()
    private let instagramCardView = HorizontalCardView()

    private enum Constants {
        static let backgroundColor: String = "#464C75FF"
        static let horizontalSpacing: CGFloat = 24.0
        static let cardsStackSpacing: CGFloat = 16.0
        static let cardsStackHeight: CGFloat = 320.0
        static let verticalSpacing: CGFloat = 12.0
        static let cardCornerRadius: CGFloat = 25.0
        static let searchButtonSize = CGSize(width: 32.0, height: 32.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

// MARK: - Private. Setup UI
private extension NewViewController {
    func setupUI() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }

    func setupViewHierarchy() {
        view.addSubview(topStackView)
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(headerButton)
        headerButton.addSubview(headerImageView)

        view.addSubview(cardsHorizontalStackView)
        cardsHorizontalStackView.addArrangedSubview(cardsLeftVerticalStackView)
        cardsLeftVerticalStackView.addArrangedSubview(tikTokCardView)
        cardsLeftVerticalStackView.addArrangedSubview(artCardView)
        cardsHorizontalStackView.addArrangedSubview(cardsRightVerticalStackView)
        cardsRightVerticalStackView.addArrangedSubview(instagramCardView)
        cardsRightVerticalStackView.addArrangedSubview(youtubeCardView)
    }

    func setupConstraints() {
        setupConstraintsTopStackView()
        setupConstraintsCardsHorizontalStackView()
    }

    func setupConstraintsTopStackView() {
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalSpacing),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalSpacing),
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalSpacing)
        ])

        NSLayoutConstraint.activate([
            headerButton.widthAnchor.constraint(equalToConstant: Constants.searchButtonSize.width),
            headerButton.heightAnchor.constraint(equalToConstant: Constants.searchButtonSize.height)
        ])

        NSLayoutConstraint.activate([
            headerImageView.centerXAnchor.constraint(equalTo: headerButton.centerXAnchor),
            headerImageView.centerYAnchor.constraint(equalTo: headerButton.centerYAnchor),
            headerImageView.widthAnchor.constraint(equalToConstant: Constants.searchButtonSize.width),
            headerImageView.heightAnchor.constraint(equalToConstant: Constants.searchButtonSize.height)
        ])
    }

    func setupConstraintsCardsHorizontalStackView() {
        cardsHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        cardsLeftVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        cardsRightVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        tikTokCardView.translatesAutoresizingMaskIntoConstraints = false
        artCardView.translatesAutoresizingMaskIntoConstraints = false
        instagramCardView.translatesAutoresizingMaskIntoConstraints = false
        youtubeCardView.translatesAutoresizingMaskIntoConstraints = false

        let cardsWidth = (UIScreen.main.bounds.width - (2 * Constants.horizontalSpacing) - Constants.cardsStackSpacing) / 2

        NSLayoutConstraint.activate([
            cardsHorizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalSpacing),
            cardsHorizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalSpacing),
            cardsHorizontalStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: Constants.verticalSpacing),
            cardsHorizontalStackView.heightAnchor.constraint(equalToConstant: Constants.cardsStackHeight)
        ])

        NSLayoutConstraint.activate([
            tikTokCardView.widthAnchor.constraint(equalToConstant: cardsWidth),
        ])

        NSLayoutConstraint.activate([
            artCardView.widthAnchor.constraint(equalToConstant: cardsWidth),
        ])

        NSLayoutConstraint.activate([
            instagramCardView.widthAnchor.constraint(equalToConstant: cardsWidth),
        ])

        NSLayoutConstraint.activate([
            youtubeCardView.widthAnchor.constraint(equalToConstant: cardsWidth),
        ])
    }

    func configureViews() {
        view.backgroundColor = UIColor(hex: Constants.backgroundColor)
        configureTopStackView()
        configureCards()
        configureCardsStackView()
    }

    func configureTopStackView() {
        topStackView.alignment = .top

        titleLabel.text = "Lorem ipsum \nDuis aute irure dolor"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = .zero

        headerButton.layer.addSublayer(getGradient(startColor: UIColor(hex: "#B2A1F7FF"), frame: CGRect(origin: .zero, size: Constants.searchButtonSize)))
        headerButton.layer.cornerRadius = 16
        headerButton.clipsToBounds = true

        headerImageView.image =  UIImage(systemName: "magnifyingglass")
        headerImageView.contentMode = .scaleAspectFit
    }

    func configureCards() {
        let tikTokCardViewDescriptor = VerticalCardViewDescriptor(
            image: .tikTok.withTintColor(.white),
            title: "TikTok \nads",
            starImage: UIImage(systemName: "star.fill") ?? UIImage(),
            rateTitle: "4.9",
            countTitle: "1234",
            gradientColors: (startColor: UIColor(hex: "#58D0EEFF"), endColor: UIColor(hex: "#565C87FF"))
        )
        let youtubeCardViewDescriptor = VerticalCardViewDescriptor(
            image: .youtube.withTintColor(.white),
            title: "YouTube \nads",
            starImage: UIImage(systemName: "star.fill") ?? UIImage(),
            rateTitle: "4.2",
            countTitle: "12344",
            gradientColors: (startColor: UIColor(hex: "#5BD6B9FF"), endColor: UIColor(hex: "#565C87FF"))
        )

        let arrowImage = UIImage(systemName: "arrow.right")
        arrowImage?.withTintColor(.white)

        let artCardViewDescriptor = HorizontalCardViewDescriptor(
            image: .clock.withTintColor(.white),
            arrowImage: arrowImage ?? UIImage(),
            title: "Art & Draw",
            gradientColors: (startColor: UIColor(hex: "#E79DA7FF"), endColor: UIColor(hex: "#565C87FF")),
            action: {
                print("artCardViewDescriptor tapped")
            }
        )
        let instagramCardViewDescriptor = HorizontalCardViewDescriptor(
            image: .instagram.withTintColor(.white),
            arrowImage: arrowImage ?? UIImage(),
            title: "Instagram",
            gradientColors: (startColor: UIColor(hex: "#B2A1F7FF"), endColor: UIColor(hex: "#565C87FF")),
            action: {
                print("instagramCardViewDescriptor tapped")
            }
        )

        tikTokCardView.configureWith(descriptor: tikTokCardViewDescriptor)
        youtubeCardView.configureWith(descriptor: youtubeCardViewDescriptor)
        artCardView.configureWith(descriptor: artCardViewDescriptor)
        instagramCardView.configureWith(descriptor: instagramCardViewDescriptor)

        tikTokCardView.layer.cornerRadius = Constants.cardCornerRadius
        youtubeCardView.layer.cornerRadius = Constants.cardCornerRadius
        artCardView.layer.cornerRadius = Constants.cardCornerRadius
        instagramCardView.layer.cornerRadius = Constants.cardCornerRadius
        tikTokCardView.clipsToBounds = true
        youtubeCardView.clipsToBounds = true
        artCardView.clipsToBounds = true
        instagramCardView.clipsToBounds = true
    }

    func configureCardsStackView() {
        cardsHorizontalStackView.axis = .horizontal
        cardsHorizontalStackView.distribution = .equalSpacing

        cardsRightVerticalStackView.axis = .vertical
        cardsRightVerticalStackView.spacing = Constants.cardsStackSpacing
        cardsRightVerticalStackView.alignment = .center

        cardsLeftVerticalStackView.axis = .vertical
        cardsLeftVerticalStackView.spacing = Constants.cardsStackSpacing
        cardsLeftVerticalStackView.alignment = .center
    }

    func getGradient(startColor: UIColor?, endColor: UIColor? = UIColor(hex: "#565C87FF"), frame: CGRect = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [
            startColor?.cgColor ?? UIColor.white.cgColor,
            endColor?.cgColor ?? UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [-0.3, 0.3]

        return gradientLayer
    }
}
