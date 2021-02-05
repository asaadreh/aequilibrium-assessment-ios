//
//  SubmitTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit

class SubmitTableViewCell: UITableViewCell {

    var delegate : TransformerDetailViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        delegate?.view.endEditing(true)
        print(delegate?.createTransformerObject())
    }
}
