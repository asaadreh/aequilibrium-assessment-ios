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
