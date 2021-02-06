//
//  TransformerTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 06/02/2021.
//

import UIKit

class TransformerTableViewCell: UITableViewCell {

    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
