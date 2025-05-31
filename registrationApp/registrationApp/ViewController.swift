//
//  ViewController.swift
//  registrationApp
//
//  Created by Yaroslav Merinov on 28.05.25.
//

import UIKit

class ViewController: UIViewController {
    
    private let builder: ViewBuilder = ViewBuilder()
    
    private var contentView: UIView = UIView()
    private var textStackView: UIStackView = UIStackView()
    private var orLabel: UILabel = UILabel()
    private var loginButton = UIButton()
    private var buttonsStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        setImage()
        setContentView()
        setTextView()
        setForgetPasswordButton()
        setLoginButton()
        setOrLabel()
        setLoginWithButtons()
        setSignUp()
    }
    
    private func setImage() {
        let image = builder.createImage()
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            image.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setContentView() {
        contentView = builder.createContentView()
        self.view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func setTextView() {
        textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.spacing = 10
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let emailStack = builder.createTextViewStack(withTitle: "Email Adress", isPassword: false, delegate: self)
        let passwordStack = builder.createTextViewStack(withTitle: "Password", isPassword: true, delegate: self)
        
        textStackView.addArrangedSubview(emailStack)
        textStackView.addArrangedSubview(passwordStack)
        
        contentView.addSubview(textStackView)
        
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            textStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
        ])
         
    }
    
    private func setForgetPasswordButton() {
        let forgetButton = UIButton(type: .system)
        forgetButton.setTitle("Forgot Password?", for: .normal)
        forgetButton.setTitleColor(.lightGray, for: .normal)
        forgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        forgetButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(forgetButton)
        
        forgetButton.trailingAnchor.constraint(equalTo: textStackView.trailingAnchor, constant: -25).isActive = true
        forgetButton.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: 2).isActive = true
    }
    
    private func setLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.backgroundColor = .systemYellow
        loginButton.tintColor = .black
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 15
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        contentView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.leadingAnchor.constraint(equalTo: textStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: textStackView.trailingAnchor),
            loginButton.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: 60)
        ])
    }
    
    private func setOrLabel() {
        orLabel = UILabel()
        orLabel.text = "Or"
        orLabel.textColor = .black
        orLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        contentView.addSubview(orLabel)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            orLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            orLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30)
        ])
    }
    
    private func setLoginWithButtons() {
        buttonsStack = builder.createButtonsStack()
        contentView.addSubview(buttonsStack)
        
        NSLayoutConstraint.activate([
            buttonsStack.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 30),
            buttonsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
            buttonsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80)
        ])
    }
    
    private func setSignUp() {
        let signUpStack = builder.createSignUpStack()
        contentView.addSubview(signUpStack)
        
        NSLayoutConstraint.activate([
            signUpStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signUpStack.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 30),
            signUpStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
