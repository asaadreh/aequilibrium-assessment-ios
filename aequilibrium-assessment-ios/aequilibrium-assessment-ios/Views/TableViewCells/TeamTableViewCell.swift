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
        
//        autobotsLabel.text = "AUTOBOTS"
//        decepticonsLabel.text = secondText
//        view.setNeedsLayout()
//        view.layoutIfNeeded()
//        let smallestSize = min(a.actualFontSize, secondLabel.actualFontSize)
//        firstLabel.font = firstLabel.font.withSize(smallestSize)
//        secondLabel.font = secondLabel.font.withSize(smallestSize)
        
        
        let fontSize1 = self.autobotsLabel.getFontSizeForLabel()
        let fontSize2 = self.decepticonsLabel.getFontSizeForLabel()


        print(fontSize1, fontSize2)
        let smallestFontSize = min(fontSize1, fontSize2)

        self.autobotsLabel.font = self.autobotsLabel.font.withSize(smallestFontSize)
        self.decepticonsLabel.font = self.decepticonsLabel.font.withSize(smallestFontSize)


        self.autobotsLabel.adjustsFontSizeToFitWidth = false
        self.decepticonsLabel.adjustsFontSizeToFitWidth = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func valueChanged(_ sender: UISwitch) {
        viewModel.isDecepticon = sender.isOn
    }
    
}
