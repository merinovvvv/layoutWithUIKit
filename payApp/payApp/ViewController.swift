//
//  ViewController.swift
//  payApp
//
//  Created by Yaroslav Merinov on 28.05.25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var builder: ViewBuilder = .init(controller: self)
    private lazy var image = builder.createImage()
    private var labelsStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var button = builder.createButton(title: "поддержать")
    
    private var paymentsStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Main")
        setCircles()
        setImage()
        setLabels()
        setPayments()
        setButton()
    }
    
    private func setCircles() {
        let firstCircle = builder.createCircle(frame: CGRect(x: view.frame.width - 74, y: -28, width: 100, height: 100))
        let secondCircle = builder.createCircle(frame: CGRect(x: 83, y: 100, width: 67, height: 67))
        let thirdCircle = builder.createCircle(frame: CGRect(x: view.frame.width - 202, y: 216, width: 286, height: 286))
        let fourthCircle = builder.createCircle(frame: CGRect(x: 83, y: view.frame.height - 272, width: 56, height: 56))
        let fifthCircle = builder.createCircle(frame: CGRect(x: view.frame.width - 121, y: view.frame.height - 120, width: 97, height: 97))
        let sixthCircle = builder.createCircle(frame: CGRect(x: -20, y: view.frame.height - 83, width: 200, height: 200))
        
        [firstCircle, secondCircle, thirdCircle, fourthCircle, fifthCircle, sixthCircle].forEach { circle in
            view.addSubview(circle)
        }
    }
    
    private func setImage() {
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setLabels() {
        let titleLabel = builder.createLabel(title: "Приложение и все его \nфункции бесплатные", size: 30, weight: .bold)
        let subtitleLabel = builder.createLabel(title: "все средства идут на улучшение и поддержку проекта", size: 16, weight: .regular)
        
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(subtitleLabel)
        
        view.addSubview(labelsStack)
        
        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 60),
            labelsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setPayments() {
        PaymentMethod.allCases.forEach { method in
            paymentsStack.addArrangedSubview(builder.createPaymentView(method: method))
        }
        
        view.addSubview(paymentsStack)
        
        NSLayoutConstraint.activate([
            paymentsStack.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 30),
            paymentsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paymentsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setButton() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

