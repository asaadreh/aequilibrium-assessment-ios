//
//  NameTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTF: UITextField!
    
    var viewModel : NameTableViewCellViewModel! {
        didSet {
            nameTF.placeholder = viewModel.placeHolder
            nameTF.text = viewModel.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func NameTFEditingEnded(_ sender: UITextField) {
        guard let name = sender.text else {
            print("Name TF is nil")
            return
        }
        print(sender.text)
        viewModel.name = name
    }
    
}
