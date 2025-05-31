//
//  ViewController.swift
//  gradientApp
//
//  Created by Yaroslav Merinov on 24.05.25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var viewBuilder: ViewBuilder = {
        .init(controller: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#464C75FF")
        viewBuilder.createAppHeader(title: "Lorem ipsum \nDuis aute irure dolor")
        viewBuilder.createCards()
        viewBuilder.createServiceInfo()
    }
}
