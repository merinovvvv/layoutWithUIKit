//
//  ViewBuilder.swift
//  registrationApp
//
//  Created by Yaroslav Merinov on 29.05.25.
//

import UIKit

class ViewBuilder {
    
    func createImage() -> UIImageView {
        let imageView = UIImageView(image: .reg)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    func createContentView() -> UIView {
        let contentView = UIView()
        
        contentView.layer.cornerRadius = 50
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }
    
    func createTextViewStack(withTitle title: String, isPassword: Bool, delegate: UITextFieldDelegate) -> UIStackView {
        let textViewStack = UIStackView()
        textViewStack.axis = .vertical
        textViewStack.alignment = .fill
        textViewStack.spacing = 7
        textViewStack.translatesAutoresizingMaskIntoConstraints = false
        
        let titleView = createTitleTextView(with: title)
        let textFieldView = createTextFieldView(isPassword: isPassword, delegate: delegate)
        
        textViewStack.addArrangedSubview(titleView)
        textViewStack.addArrangedSubview(textFieldView)
        
        return textViewStack
    }
    
    private func createTextFieldView(isPassword: Bool, delegate: UITextFieldDelegate) -> UIView {
        let textField = UITextField()
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = delegate
        textField.backgroundColor = .clear
        
        textField.textContentType = .none
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        textField.textContentType = .oneTimeCode
            
        textField.inlinePredictionType = .no
        
        lazy var showPasswordButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "eye"), for: .normal)
            button.tintColor = .black
            return button
        }()
        
        showPasswordButton.addAction(UIAction { _ in
            textField.isSecureTextEntry.toggle()
            if !textField.isSecureTextEntry {
                showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            } else {
                showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            }
        }, for: .touchUpInside)
        
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.addSubview(textField)
        view.backgroundColor = .grayLight
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 52).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        if isPassword {
            textField.isSecureTextEntry = true
            view.addSubview(showPasswordButton)
            
            NSLayoutConstraint.activate([
                showPasswordButton.widthAnchor.constraint(equalToConstant: 40),
                showPasswordButton.heightAnchor.constraint(equalToConstant: 40),
                showPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                showPasswordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                textField.trailingAnchor.constraint(equalTo: showPasswordButton.leadingAnchor, constant: -5),
            ])
            
        } else {
            NSLayoutConstraint.activate([
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ])
        }
        return view
    }
    
    private func createTitleTextView(with title: String) -> UIView {
        let label = UILabel()
        label.text = title
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let textView = UIView()
        textView.addSubview(label)
        textView.backgroundColor = .clear
        textView.addSubview(label)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: textView.topAnchor),
            label.bottomAnchor.constraint(equalTo: textView.bottomAnchor)
        ])
        
        return textView
    }
    
    func createButtonsStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        LoginWith.allCases.forEach { item in
            stackView.addArrangedSubview(createLoginButton(with: item))
        }
        
        return stackView
    }
    
    private func createLoginButton(with: LoginWith) -> UIButton {
        let loginWithButton = UIButton(type: .system)
        let imageView = UIImageView(image: UIImage(named: with.rawValue))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        loginWithButton.translatesAutoresizingMaskIntoConstraints = false
        loginWithButton.layer.cornerRadius = 15
        loginWithButton.backgroundColor = .grayLight
        
        loginWithButton.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            loginWithButton.widthAnchor.constraint(equalToConstant: 60),
            loginWithButton.heightAnchor.constraint(equalToConstant: 60),
            imageView.centerYAnchor.constraint(equalTo: loginWithButton.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: loginWithButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: loginWithButton.widthAnchor, multiplier: 0.7),
            imageView.heightAnchor.constraint(equalTo: loginWithButton.heightAnchor, multiplier: 0.7),
        ])
        
        loginWithButton.addAction(UIAction { [weak loginWithButton] _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                loginWithButton?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                loginWithButton?.alpha = 0.8
            })
        }, for: .touchDown)
        
        
        let releaseAction = UIAction { [weak loginWithButton] _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                loginWithButton?.transform = .identity
                loginWithButton?.alpha = 1.0
            })
        }
        
        loginWithButton.addAction(releaseAction, for: .touchUpInside)
        loginWithButton.addAction(releaseAction, for: .touchUpOutside)
        loginWithButton.addAction(releaseAction, for: .touchCancel)
        
        return loginWithButton
    }
    
    func createSignUpStack() -> UIStackView {
        let signUpStack = UIStackView()
        signUpStack.axis = .horizontal
        signUpStack.translatesAutoresizingMaskIntoConstraints = false
        signUpStack.spacing = 2
        signUpStack.alignment = .center
        
        let signUpLabel = UILabel()
        signUpLabel.text = "Don't have an account?"
        signUpLabel.textColor = .black
        signUpLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.systemYellow, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        signUpStack.addArrangedSubview(signUpLabel)
        signUpStack.addArrangedSubview(signUpButton)
        
        return signUpStack
    }
}
