//
//  UILabel.ext.swift
//  bankCardConstructor
//
//  Created by Yaroslav Merinov on 24.05.25.
//

import UIKit

extension UILabel {
    func setLineHeight (lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributedText = NSMutableAttributedString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.count))
            self.attributedText = attributedText
        }
    }
}
