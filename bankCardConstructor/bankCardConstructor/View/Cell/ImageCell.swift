//
//  ImageCell.swift
//  bankCardConstructor
//
//  Created by Yaroslav Merinov on 23.05.25.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    private let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        return imageView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.opacity = 0.3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return imageView
    }()
    
    func setImage(image: UIImage) {
        imageView.image = image.withTintColor(.white)
        self.addSubview(imageView)
        
        self.backgroundColor = UIColor(hex: "#1F1F1FFF")
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(selectImageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            
            selectImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            selectImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func selectImage() {
        selectImageView.isHidden = false
    }
    
    func deselectImage() {
        selectImageView.isHidden = true
    }
}
