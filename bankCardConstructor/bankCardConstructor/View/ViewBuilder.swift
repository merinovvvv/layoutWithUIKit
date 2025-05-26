//
//  ViewBuilder.swift
//  bankCardConstructor
//
//  Created by Yaroslav Merinov on 23.05.25.
//

import UIKit

final class ViewBuilder: NSObject {
    
    private let manager: ViewManager = .shared
    
    private var card: UIView!
    
    private var cardColor: [String] = ["#16A085FF", "#003F32FF"] {
        willSet {
            if let card = view.viewWithTag(52) {
                card.layer.sublayers?.remove(at: 0)
                let gradient = manager.getGradient(colors: newValue)
                card.layer.insertSublayer(gradient, at: 0)
            }
        }
    }
    private var cardImage: UIImage = .icon1 {
        willSet {
            if let imageView = card.viewWithTag(11) as? UIImageView {
                imageView.image = newValue.withTintColor(.white)
            }
        }
    }
    
    private var colorCollectionView: UICollectionView!
    private var imageCollectionView: UICollectionView!
    
    private let initialBalance: Float = 9.999
    private let initialCardNumber: String = "0000"
    
    var controller: UIViewController
    var view: UIView
    
    private lazy var pageTitle: UILabel = {
        var title: UILabel = UILabel()
        title.textColor = .white
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.numberOfLines = 0
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setPageTitle(_ text: String) {
        pageTitle.text = text
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func setCard() {
        card = manager.getCard(colors: cardColor, balance: initialBalance, number: initialCardNumber, image: cardImage.withTintColor(.white))
        
        view.addSubview(card)
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.topAnchor.constraint(equalTo: pageTitle.topAnchor, constant: 50)
        ])
    }
    
    func setColorCollectionView() {
        
        let colorCollectionViewTitle = manager.slideTitle(titleText: "Select color")
        colorCollectionView = manager.getCollection(id: CollectionViewType.colors.rawValue, dataSource: self, delegate: self)
        colorCollectionView.register(ColorCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(colorCollectionViewTitle)
        view.addSubview(colorCollectionView)
        
        
        NSLayoutConstraint.activate([
            colorCollectionViewTitle.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 40),
            colorCollectionViewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorCollectionViewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            colorCollectionView.topAnchor.constraint(equalTo: colorCollectionViewTitle.bottomAnchor, constant: 20),
            colorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        colorCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    func setImageCollectionVeiw() {
        let imageCollectionViewTitle = manager.slideTitle(titleText: "Add shapes")
        imageCollectionView = manager.getCollection(id: CollectionViewType.images.rawValue, dataSource: self, delegate: self)
        imageCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(imageCollectionViewTitle)
        view.addSubview(imageCollectionView)
        
        NSLayoutConstraint.activate([
            imageCollectionViewTitle.topAnchor.constraint(equalTo: colorCollectionView.bottomAnchor, constant: 40),
            imageCollectionViewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageCollectionViewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageCollectionView.topAnchor.constraint(equalTo: imageCollectionViewTitle.bottomAnchor, constant: 20),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        imageCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    func setDescriptionText() {
        let descriptionText: UILabel = UILabel()
        descriptionText.text = "Don't worry. You can always change the design of your virtual card later. Just enter the settings."
        descriptionText.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        descriptionText.textColor = UIColor(hex: "#6F6F6FFF")
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.numberOfLines = 0
        descriptionText.setLineHeight(lineHeight: 10)
        view.addSubview(descriptionText)
        
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 40),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
    }
    
    func setContinueButton() {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
}

extension ViewBuilder: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case CollectionViewType.colors.rawValue:
            return manager.colors.count
        case CollectionViewType.images.rawValue:
            return manager.images.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier {
        case CollectionViewType.colors.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorCell {
                let color = manager.colors[indexPath.item]
                cell.setColorCell(colors: color)
                
                if collectionView.indexPathsForSelectedItems?.contains(indexPath) == true {
                    cell.selectImage()
                }
                
                return cell
            }
        case CollectionViewType.images.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ImageCell {
                let image = manager.images[indexPath.item]
                cell.setImage(image: image)
                
                if collectionView.indexPathsForSelectedItems?.contains(indexPath) == true {
                    cell.selectImage()
                }
                
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case CollectionViewType.colors.rawValue:
            let colors = manager.colors[indexPath.item]
            cardColor = colors
            if let cell = collectionView.cellForItem(at: indexPath) as? ColorCell {
                cell.selectImage()
            }
        case CollectionViewType.images.rawValue:
            let image = manager.images[indexPath.item]
            cardImage = image
            if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell {
                cell.selectImage()
            }
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case CollectionViewType.colors.rawValue:
            if let cell = collectionView.cellForItem(at: indexPath) as? ColorCell {
                cell.deselectImage()
            }
        case CollectionViewType.images.rawValue:
            if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell {
                cell.deselectImage()
            }
        default:
            return
        }
    }
}

enum CollectionViewType: String {
    case colors, images
}
