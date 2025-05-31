//
//  ViewBuilder.swift
//  gradientApp
//
//  Created by Yaroslav Merinov on 26.05.25.
//

import UIKit

class ViewBuilder {
    let manager = ViewManager.shared
    
    let controller: UIViewController
    let view: UIView
    
    lazy private var width = {
        (view.frame.width - 50 - 17) / 2
    }()
    
    private var headerStack = UIStackView()
    
    private var mainStack = UIStackView()
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    func createAppHeader(title: String) {
        
        let headerLabel = manager.createHeaderText(title: title)
        
        let headerButton = manager.createHeaderButton()
        
        let headerImageView = manager.createHeaderImageView()
        
        headerButton.addSubview(headerImageView)
        
        NSLayoutConstraint.activate([
            headerImageView.centerXAnchor.constraint(equalTo: headerButton.centerXAnchor),
            headerImageView.centerYAnchor.constraint(equalTo: headerButton.centerYAnchor)
        ])
        
        headerStack.axis = .horizontal
        headerStack.alignment = .leading
        headerStack.distribution = .equalSpacing
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        
        headerStack.addArrangedSubview(headerLabel)
        headerStack.addArrangedSubview(headerButton)
        
        view.addSubview(headerStack)
        
        NSLayoutConstraint.activate([
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func createCards() {
        
        let firstVerticalStack = UIStackView()
        firstVerticalStack.axis = .vertical
        firstVerticalStack.spacing = 17
        firstVerticalStack.alignment = .center
        
        let tiktokCard = createBigCardContent(for: manager.createCardView(gradientColor: "#58D0EEFF", width: width), with: .tikTok.withTintColor(.white), title: "TikTok \nads", rate: 4.9, views: 1234)
        
        let clockCard = createSmallCardContent(for: manager.createCardView(gradientColor: "#5BD6B9FF", width: width), with: .clock.withTintColor(.white), title: "Art & Draw")

        firstVerticalStack.addArrangedSubview(tiktokCard)
        firstVerticalStack.addArrangedSubview(clockCard)
        
        let secondVerticalStack = UIStackView()
        secondVerticalStack.axis = .vertical
        secondVerticalStack.spacing = 17
        secondVerticalStack.alignment = .center
        
        let instCard = createSmallCardContent(for: manager.createCardView(gradientColor: "#E79DA7FF", width: width), with: .instagram.withTintColor(.white), title: "Instagram")
        
        let youtubeCard = createBigCardContent(for: manager.createCardView(gradientColor: "#B2A1F7FF", width: width), with: .youtube.withTintColor(.white), title: "YouTube \nads", rate: 4.9, views: 124)
        
        secondVerticalStack.addArrangedSubview(instCard)
        secondVerticalStack.addArrangedSubview(youtubeCard)
        
        
        mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .equalSpacing
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainStack.addArrangedSubview(firstVerticalStack)
        mainStack.addArrangedSubview(secondVerticalStack)
        
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 33),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
    }
    
    func createBigCardContent(for cardView: UIView, with image: UIImage, title: String, rate: Float, views: Int) -> UIView {
        
        let imageView = manager.createCardImage(image: image)
        let titleLabel = manager.createCardTitle(title: title)
        
        let topStack = UIStackView()
        topStack.axis = .vertical
        topStack.alignment = .leading
        topStack.spacing = 12
        topStack.addArrangedSubview(imageView)
        topStack.addArrangedSubview(titleLabel)
        
        let rateStack = manager.createRateStack(rate: rate)
        let viewsLabel = manager.createViewsLabel(views: views)
        
        let bottomStack = UIStackView()
        bottomStack.axis = .vertical
        bottomStack.spacing = 2
        bottomStack.alignment = .leading
        bottomStack.addArrangedSubview(rateStack)
        bottomStack.addArrangedSubview(viewsLabel)
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.alignment = .leading
        mainStack.spacing = 21
        
        mainStack.addArrangedSubview(topStack)
        mainStack.addArrangedSubview(bottomStack)
        
        cardView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 25),
            mainStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -25),
            mainStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25),
            mainStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -27)
        ])
        
        return cardView
    }
    
    func createSmallCardContent(for cardView: UIView, with image: UIImage, title: String) -> UIView {
        let imageView = manager.createCardImage(image: image)
        let titleLabel = manager.createCardTitle(title: title)
        
        let arrowButton = UIButton(type: .system)
        arrowButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.contentMode = .scaleAspectFit
        arrowButton.tintColor = .white
        
        let topStack = UIStackView()
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        topStack.alignment = .center
        topStack.addArrangedSubview(imageView)
        topStack.addArrangedSubview(arrowButton)
        
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.spacing = 13
        
        mainStack.addArrangedSubview(topStack)
        mainStack.addArrangedSubview(titleLabel)
        
        cardView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 25),
            mainStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -25),
            mainStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25),
            mainStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30)
        ])
        
        return cardView
    }
    
    func createServiceInfo() {
        
        let serviceLabel = manager.createServiceTitle(title: "The best services")
        
        let serviceCard = manager.createCardView(gradientColor: "#949AC5FF", width: 343, frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 200)))
        let serviceCardTitle = manager.createCardTitle(title: "Design & \nDevelopment")
        let rateStack = manager.createRateStack(rate: 4.9)
        let serviceInfoStack = manager.createServiceInfoStack()
        let serviceInfoPrice = manager.createServicePriceLabel(price: 1234)
        
        let rightStack = UIStackView()
        rightStack.axis = .vertical
        rightStack.alignment = .leading
        rightStack.spacing = 5
        
        rightStack.addArrangedSubview(serviceCardTitle)
        rightStack.addArrangedSubview(rateStack)
        rightStack.addArrangedSubview(serviceInfoStack)
        rightStack.addArrangedSubview(UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 5))))
        rightStack.addArrangedSubview(serviceInfoPrice)
        
        let serviceImage = UIImageView(image: .coder)
        serviceImage.translatesAutoresizingMaskIntoConstraints = false
        serviceImage.contentMode = .scaleAspectFit
        serviceImage.widthAnchor.constraint(equalToConstant: 152).isActive = true
        serviceImage.heightAnchor.constraint(equalToConstant: 112).isActive = true
        
        
        let serviceCardStack = UIStackView()
        serviceCardStack.axis = .horizontal
        serviceCardStack.distribution = .equalSpacing
        serviceCardStack.alignment = .center
        serviceCardStack.translatesAutoresizingMaskIntoConstraints = false
        
        serviceCardStack.addArrangedSubview(serviceImage)
        serviceCardStack.addArrangedSubview(rightStack)
        
        serviceCard.addSubview(serviceCardStack)
        
        NSLayoutConstraint.activate([
            serviceCardStack.topAnchor.constraint(equalTo: serviceCard.topAnchor, constant: 25),
            serviceCardStack.leadingAnchor.constraint(equalTo: serviceCard.leadingAnchor, constant: 25),
            serviceCardStack.bottomAnchor.constraint(equalTo: serviceCard.bottomAnchor, constant: -25),
            serviceCardStack.trailingAnchor.constraint(equalTo: serviceCard.trailingAnchor, constant: -25)
        ])
        
        let mainServiceStack = UIStackView()
        mainServiceStack.axis = .vertical
        mainServiceStack.alignment = .leading
        mainServiceStack.spacing = 21
        mainServiceStack.addArrangedSubview(serviceLabel)
        mainServiceStack.addArrangedSubview(serviceCard)
        mainServiceStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainServiceStack)
        
        NSLayoutConstraint.activate([
            mainServiceStack.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 41),
            mainServiceStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainServiceStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            mainServiceStack.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
