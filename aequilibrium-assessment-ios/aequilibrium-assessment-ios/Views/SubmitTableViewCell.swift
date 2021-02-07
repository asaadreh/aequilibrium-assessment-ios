//
//  SubmitTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit

class SubmitTableViewCell: UITableViewCell {

    @IBOutlet weak var submitButton: UIButton!
    var delegate : TransformerDetailViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        submitButton.shadowAndCorner(cornerRadius: 5.0,
                                     shadowRadius: 3.0,
                                     opacity: 0.5,
                                     color: .gray,
                                     width: 3,
                                     height: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        delegate?.view.endEditing(true)
        delegate?.createTransformer()
    }
}
