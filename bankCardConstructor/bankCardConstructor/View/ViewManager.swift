//
//  ViewManager.swift
//  bankCardConstructor
//
//  Created by Yaroslav Merinov on 23.05.25.
//

import UIKit

final class ViewManager {
    
    static let shared = ViewManager()
    
    let colors: [ [String] ] = [
        ["#16A085FF", "#003F32FF"],
        ["#9A00D1FF", "#45005DFF"],
        ["#FA6000FF", "#FAC6A6FF"],
        ["#DE0007FF", "#8A0004FF"],
        ["#2980B9FF", "#2771A1FF"],
        ["#E74C3CFF", "#93261BFF"]
    ]
    
    let images: [UIImage] = [.icon1, .icon2, .icon3, .icon4, .icon5, .icon6]
    
    func getGradient(frame: CGRect = CGRect(origin: .zero, size: CGSize(width: 306, height: 175)), colors: [String]) -> CAGradientLayer {
        
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { UIColor(hex: $0)?.cgColor ?? UIColor.white.cgColor }
        gradient.startPoint = .init(x: 0, y: 0.5)
        gradient.endPoint = .init(x: 1, y: 0.5)
        gradient.locations = [0, 1]
        gradient.frame = frame
        
        return gradient
    }
    
    func getCard(colors: [String], balance: Float, number: String, image: UIImage) -> UIView {
        let card = {
            let card = UIView()
            let gradient = getGradient(colors: colors)
            card.layer.insertSublayer(gradient, at: 0)
            card.translatesAutoresizingMaskIntoConstraints = false
            card.clipsToBounds = true
            card.layer.cornerRadius = 30
            card.widthAnchor.constraint(equalToConstant: 306).isActive = true
            card.heightAnchor.constraint(equalToConstant: 175).isActive = true
            card.tag = 52
            
            return card
            
        }()
        
        let cardImageView = {
            let imageView = UIImageView(image: image)
            imageView.layer.opacity = 0.3
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.tag = 11
            
            return imageView
            
        }()
        
        let balanceLabel = {
           let balanceLabel = UILabel()
            balanceLabel.textColor = .white
            balanceLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            balanceLabel.text = "$\(balance)"
            balanceLabel.translatesAutoresizingMaskIntoConstraints = false
            
            return balanceLabel
        }()
        
        let numberLabel = {
            let numberLabel = UILabel()
            numberLabel.textColor = .white
            numberLabel.text = "****\(number)"
            numberLabel.translatesAutoresizingMaskIntoConstraints = false
            numberLabel.layer.opacity = 0.3
            
            return numberLabel
        }()
        
        let hStack = {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.distribution = .equalSpacing
            hStack.alignment = .center
            hStack.addArrangedSubview(balanceLabel)
            hStack.addArrangedSubview(numberLabel)
            hStack.translatesAutoresizingMaskIntoConstraints = false
            
            return hStack
        }()
        
        
        card.addSubview(cardImageView)
        card.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            cardImageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: -10),
            cardImageView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: 30),
            
            hStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            hStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            hStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -30)
        ])
        
        return card
    }
    
    func getCollection(id: String, dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 62, height: 62)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = .clear
        collectionView.delegate = delegate
        collectionView.restorationIdentifier = id
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return collectionView
    }
    
    func slideTitle(titleText: String) -> UILabel {
        let title = UILabel()
        title.text = titleText
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }
    
    private init() {}
}
