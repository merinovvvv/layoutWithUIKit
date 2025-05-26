//
//  ViewController.swift
//  bankCardConstructor
//
//  Created by Yaroslav Merinov on 23.05.25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var builder: ViewBuilder = {
       ViewBuilder(controller: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#141414FF")
        builder.setPageTitle("Design your virtual card")
        builder.setCard()
        builder.setColorCollectionView()
        builder.setImageCollectionVeiw()
        builder.setDescriptionText()
        builder.setContinueButton()
    }
}

