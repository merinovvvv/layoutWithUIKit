//
//  ViewBuilder.swift
//  payApp
//
//  Created by Yaroslav Merinov on 28.05.25.
//

import UIKit

class ViewBuilder {
    
    private let controller: UIViewController
    private let view: UIView
    
    private var selectedPrice: Int = 0
    private var button = UIButton()
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    func createCircle(frame: CGRect) -> UIView {
        let circle = UIView()
        circle.backgroundColor = UIColor(named: "Circle")
        circle.frame = frame
        circle.layer.cornerRadius = frame.width / 2
        circle.clipsToBounds = true
        return circle
    }

    func createImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "meeting"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        return imageView
    }
    
    func createLabel(title: String, size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = .systemFont(ofSize: size, weight: weight)
        label.numberOfLines = 0
        return label
    }
    
    @objc func handlePaymentMethodTap(sender: UITapGestureRecognizer) {
        
        PaymentMethod.allCases.forEach { method in
            if let view = self.view.viewWithTag(method.rawValue) {
                view.layer.borderColor = UIColor.clear.cgColor
                view.layer.borderWidth = 0
            }
        }
        
        if let view = sender.view {
            if let paymentView = self.view.viewWithTag(view.tag) {
                paymentView.layer.borderWidth = 2
                paymentView.layer.borderColor = UIColor.white.cgColor
                button.isUserInteractionEnabled = true
                button.layer.opacity = 1
                selectedPrice = paymentView.tag
            }
        }
    }
    
    func createPaymentView(method: PaymentMethod) -> UIView {
        let paymentView = UIView()
        paymentView.layer.cornerRadius = 20
        paymentView.clipsToBounds = true
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        paymentView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        paymentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        paymentView.tag = method.rawValue
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePaymentMethodTap))
        
        paymentView.addGestureRecognizer(tapGesture)
        
        
        switch method {
        case .cheap:
            paymentView.backgroundColor = UIColor(named: "MyOrange")
        case .medium:
            paymentView.backgroundColor = UIColor(named: "MyPink")
        case .expensive:
            paymentView.backgroundColor = UIColor(named: "DarkGreen")
        }
        
        let priceStack = createPaymentTextStack(method: method)
        paymentView.addSubview(priceStack)
        
        NSLayoutConstraint.activate([
            priceStack.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 10),
            priceStack.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -10),
            priceStack.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 23),
            priceStack.bottomAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: -23)
        ])
        
        return paymentView
    }
    
    private func createPaymentTextStack(method: PaymentMethod) -> UIStackView {
        
        let priceStack = UIStackView()
        priceStack.axis = .vertical
        priceStack.spacing = 0
        priceStack.alignment = .center
        priceStack.translatesAutoresizingMaskIntoConstraints = false
        
        let priceLabel = createLabel(title: "\(method.rawValue)" , size: 31, weight: .bold)
        let rublesLabel = createLabel(title: "рублей", size: 16, weight: .light)
        
        priceStack.addArrangedSubview(priceLabel)
        priceStack.addArrangedSubview(rublesLabel)
        
        return priceStack
    }
    
    func createButton(title: String) -> UIButton {
        let action: UIAction = UIAction { _ in
            print("\(self.selectedPrice)")
        }
        
        button = UIButton(primaryAction: action)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "DarkGreen")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 51).isActive = true
        button.layer.opacity = 0.6
        button.isUserInteractionEnabled = false
        
        return button
    }
}
