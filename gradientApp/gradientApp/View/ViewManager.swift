//
//  ViewManager.swift
//  gradientApp
//
//  Created by Yaroslav Merinov on 26.05.25.
//

import UIKit

class ViewManager {
    static let shared = ViewManager()
    
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
    
    func createHeaderText(title: String) -> UILabel {
        let headerText = UILabel()
        headerText.text = title
        headerText.font = .systemFont(ofSize: 20, weight: .bold)
        headerText.textColor = .white
        headerText.numberOfLines = 0
        
        return headerText
    }
    
    func createHeaderButton() -> UIButton {
        let headerButton = UIButton(type: .system)
        headerButton.layer.addSublayer(getGradient(startColor: UIColor(hex: "#B2A1F7FF"), frame: CGRect(origin: .zero, size: CGSize(width: 31, height: 31))))
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        headerButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        headerButton.heightAnchor.constraint(equalToConstant: 31).isActive = true
        headerButton.layer.cornerRadius = 16
        headerButton.clipsToBounds = true
        
        return headerButton
    }
    
    func createHeaderImageView() -> UIImageView {
        let headerImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        headerImageView.tintColor = .white
        headerImageView.contentMode = .scaleAspectFit
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerImageView
    }
    
    func createCardView(gradientColor: String, width: CGFloat, frame: CGRect = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))) -> UIView {
        let gradient = getGradient(startColor: UIColor(hex: gradientColor), frame: frame)
        let cardView = UIView()
        
        cardView.layer.addSublayer(gradient)
        cardView.layer.cornerCurve = .continuous
        cardView.layer.cornerRadius = 25
        cardView.clipsToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.widthAnchor.constraint(equalToConstant: width).isActive = true
        return cardView
    }
    
    func createCardImage(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 27).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        return imageView
    }
    
    func createCardTitle(title: String) -> UILabel {
        let cardTitle = UILabel()
        cardTitle.text = title
        cardTitle.textColor = .white
        cardTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        cardTitle.numberOfLines = 0
        
        return cardTitle
    }
    
    func createRateStack(rate: Float) -> UIStackView {
        let rateStack = UIStackView()
        rateStack.axis = .horizontal
        rateStack.spacing = 5
        rateStack.alignment = .center
        
        let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.contentMode = .scaleAspectFit
        starImageView.tintColor = .white
        starImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        let rateLabel = UILabel()
        rateLabel.text = "\(rate)"
        rateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        rateLabel.textColor = .white
        
        rateStack.addArrangedSubview(starImageView)
        rateStack.addArrangedSubview(rateLabel)
        
        return rateStack
    }
    
    func createViewsLabel(views: Int) -> UILabel {
        let viewsLabel = UILabel()
        viewsLabel.text = "\(views) views"
        viewsLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        viewsLabel.textColor = .white
    
        return viewsLabel
    }
    
    func createServiceTitle(title: String) -> UILabel {
        let serviceLabel = UILabel()
        serviceLabel.text = title
        serviceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        serviceLabel.textColor = .white
        serviceLabel.numberOfLines = 0
        
        return serviceLabel
    }
    
    func createServiceInfoStack() -> UIStackView {
        let serviceInfoStack = UIStackView()
        serviceInfoStack.axis = .horizontal
        serviceInfoStack.spacing = 5
        serviceInfoStack.alignment = .center
        serviceInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        let infoImage = UIImageView(image: .computer.withTintColor(.white))
        infoImage.contentMode = .scaleAspectFit
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        infoImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        infoImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        let infoLabel = UILabel()
        infoLabel.text = "Complete Design"
        infoLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        infoLabel.textColor = .white
        
        serviceInfoStack.addArrangedSubview(infoImage)
        serviceInfoStack.addArrangedSubview(infoLabel)
        
        return serviceInfoStack
    }
    
    func createServicePriceLabel(price: Int) -> UILabel {
        let priceLabel = UILabel()
        priceLabel.text = "$\(price)"
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        priceLabel.textColor = UIColor(hex: "#58CFEFFF")
        
        return priceLabel
    }
}
