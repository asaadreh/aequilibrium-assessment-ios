//
//  AttributeTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit

class AttributeTableViewCell: UITableViewCell {

    @IBOutlet weak var attributeName: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueStepper: UIStepper!
    
    var viewModel : AttributeTableViewCellViewModel! {
        didSet {
            attributeName.text = viewModel.attribute
            valueLabel.text = String(viewModel.value)
            valueStepper.value = Double(viewModel.value)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        valueStepper.maximumValue = 10
        valueStepper.minimumValue = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func steppedValueChanged(_ sender: UIStepper) {
        
        valueLabel.text = Int(sender.value).description
        viewModel.value = Int(sender.value)
    }
}


