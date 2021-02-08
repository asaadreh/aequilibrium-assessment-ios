//
//  FightViewController.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 06/02/2021.
//

import UIKit
import Kingfisher

class FightViewController: UIViewController {

    var transformers : [Transformer]?
    @IBOutlet weak var autobotsImageView: UIImageView!
    @IBOutlet weak var decepticonsImageView: UIImageView!
    @IBOutlet weak var autobotsList: UIStackView!
    @IBOutlet weak var decepticonsList: UIStackView!
    @IBOutlet weak var fightButton: UIButton!
    var blurEffectView : UIView!
    
    var fight : Fight!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let transformers = transformers else {
            print("Transformers is nil")
            return
        }
        
        fight = Fight(transformers: transformers)
        autobotsImageView.kf.setImage(with: URL(string: fight.autobots.first?.team_icon ?? ""))
        decepticonsImageView.kf.setImage(with: URL(string: fight.decepticons.first?.team_icon ?? ""))
        
        setupUI()
//        prepareForFight(transformers: transformers)
    }
    
    
    func setupUI(){
        
        fightButton.shadowAndCorner(cornerRadius: 5.0,
                                    shadowRadius: 3.0,
                                    opacity: 0.5,
                                    color: .gray,
                                    width: 3,
                                    height: 3)
        
        for autobot in fight.autobots{
            let label = UILabel()
            label.text = autobot.name
            label.font = UIFont.systemFont(ofSize: 20)
            label.adjustsFontSizeToFitWidth = true
            autobotsList.addArrangedSubview(label)
        }
        
        for decepticon in fight.decepticons{
            let label = UILabel()
            label.text = decepticon.name
            label.font = UIFont.systemFont(ofSize: 20)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .right
            decepticonsList.addArrangedSubview(label)
        }
    }
    
    @IBAction func fightButtonTapped(_ sender: UIButton) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        
        fight.prepareForFight()
        
        if fight.destroyEverything {
            let alert = UIAlertController(title: "Everything was destroyed!", message: "This is what happens when an unstoppable force meets an immovable object!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
        }
        
        if fight.winningTeam == .Tie {
            let alert = UIAlertController(title: "No winner", message: "It's a tie!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
        }
        else if fight.winningTeam == .Decepticons {
            let alert = UIAlertController(title: "The winner is...", message: "DECEPTICONS!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
        }
        else if fight.winningTeam == .Autobots {
            let alert = UIAlertController(title: "The winner is...", message: "AUTOBOTS!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
        }
    }
}
