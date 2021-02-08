//
//  UIView+Exentions.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 07/02/2021.
//

import Foundation
import UIKit

extension UIView{
    func shadowAndCorner(cornerRadius: CGFloat, shadowRadius: CGFloat, opacity: Float, color: UIColor, width: Int, height: Int) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowColor = color.cgColor
    }
}

extension UILabel {
    func getFontSizeForLabel() -> CGFloat {
        let text: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        text.setAttributes([NSAttributedString.Key.font: self.font as Any], range: NSMakeRange(0, text.length))
        let context: NSStringDrawingContext = NSStringDrawingContext()
        context.minimumScaleFactor = self.minimumScaleFactor
        text.boundingRect(with: self.frame.size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: context)
        let adjustedFontSize: CGFloat = self.font.pointSize * context.actualScaleFactor
        return adjustedFontSize
    }
}

extension UILabel {
    var actualFontSize: CGFloat {
        guard let attributedText = attributedText else { return font.pointSize }
        let text = NSMutableAttributedString(attributedString: attributedText)
        text.setAttributes([.font: font as Any], range: NSRange(location: 0, length: text.length))
        let context = NSStringDrawingContext()
        context.minimumScaleFactor = minimumScaleFactor
        text.boundingRect(with: frame.size, options: .usesLineFragmentOrigin, context: context)
        let adjustedFontSize: CGFloat = font.pointSize * context.actualScaleFactor
        return adjustedFontSize
    }
}
