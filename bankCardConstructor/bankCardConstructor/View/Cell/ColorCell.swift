//
//  ColorCell.swift
//  bankCardConstructor
//
//  Created by Yaroslav Merinov on 23.05.25.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    private let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        return imageView
    }()
    
    func setColorCell(colors: [String]) {
        let gradient = ViewManager.shared.getGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)), colors: colors)
        self.layer.addSublayer(gradient)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(selectImageView)
        
        selectImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        selectImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func selectImage() {
        selectImageView.isHidden = false
    }
    
    func deselectImage() {
        selectImageView.isHidden = true
    }
}
