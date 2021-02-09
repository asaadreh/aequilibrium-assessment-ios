//
//  BaseViewController.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 09/02/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func makeLabelsFontSizeEqual(label1: UILabel, label2: UILabel) {
        let fontSize1 = label1.getFontSizeForLabel()
        let fontSize2 = label2.getFontSizeForLabel()

        label1.adjustsFontSizeToFitWidth = false
        label2.adjustsFontSizeToFitWidth = false

        let smallestFontSize = min(fontSize1, fontSize2)

        label1.font = label1.font.withSize(smallestFontSize)
        label2.font = label2.font.withSize(smallestFontSize)
    }

}
