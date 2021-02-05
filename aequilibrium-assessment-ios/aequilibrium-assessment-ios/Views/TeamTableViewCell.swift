//
//  TeamTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamSwitch: UISwitch!
    
    var viewModel : TeamTableViewCellViewModel! {
        didSet{
            teamSwitch.isOn = viewModel.isDecepticon
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
    @IBAction func valueChanged(_ sender: UISwitch) {
        viewModel.isDecepticon = sender.isOn
    }
    
}
