//
//  HeaderTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit
import Kingfisher

class HeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var headerText: UILabel!
    
    var viewModel : HeaderTableViewCellViewModel! {
        didSet {
            headerText.text = viewModel.headerText
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

}
