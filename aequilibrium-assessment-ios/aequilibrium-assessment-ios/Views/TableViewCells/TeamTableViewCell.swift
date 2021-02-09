//
//  TeamTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamSwitch: UISwitch!
    @IBOutlet weak var autobotsLabel: UILabel!
    @IBOutlet weak var decepticonsLabel: UILabel!
    
    var viewModel : TeamTableViewCellViewModel! {
        didSet{
            teamSwitch.isOn = viewModel.isDecepticon
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        teamSwitch.onTintColor = AppColors.purple
        
        
        let fontSize1 = self.autobotsLabel.getFontSizeForLabel()
        let fontSize2 = self.decepticonsLabel.getFontSizeForLabel()

        self.autobotsLabel.adjustsFontSizeToFitWidth = false
        self.decepticonsLabel.adjustsFontSizeToFitWidth = false
        let smallestFontSize = min(fontSize1, fontSize2)

        self.autobotsLabel.font = self.autobotsLabel.font.withSize(smallestFontSize)
        self.decepticonsLabel.font = self.decepticonsLabel.font.withSize(smallestFontSize)


        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func valueChanged(_ sender: UISwitch) {
        viewModel.isDecepticon = sender.isOn
    }
    
}
