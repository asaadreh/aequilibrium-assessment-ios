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
    @IBOutlet weak var decepticonsLabel: UILabel!
    @IBOutlet weak var autobotsLabel: UILabel!
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
        
        for autobot in fight.autobots{
            let label = UILabel()
            label.text = autobot.name
            autobotsList.addArrangedSubview(label)
        }
        
        for decepticon in fight.decepticons{
            let label = UILabel()
            label.text = decepticon.name
            label.textAlignment = .right
            decepticonsList.addArrangedSubview(label)
        }
    }
    
    
//    func prepareForFight(transformers: [Transformer]) {
//
//        var autobots = transformers.filter({$0.team == "A"})
//        var decepticons = transformers.filter({$0.team == "D"})
//
//        let numberOfRounds = autobots.count >= decepticons.count ? decepticons.count : autobots.count
//
//        for _ in 1...numberOfRounds{
//
//            if let autobotContender = autobots.max(by: {$0.rank < $1.rank}),
//               let decepticonContender = decepticons.max(by: {$0.rank < $1.rank}){
//
//                let winner = fight(autobot: autobotContender, decepticon: decepticonContender)
//                print("WINNER:", winner)
//
//                if let index = autobots.firstIndex(of: autobotContender) {
//                    autobots.remove(at: index)
//                }
//                if let index = decepticons.firstIndex(of: decepticonContender) {
//                    decepticons.remove(at: index)
//                }
//            }
//        }
//
//
//
//    }
//
//    func destroyEverything() {
//        // handle Special Rule 2
//
//    }
//
//    func fight(autobot: Transformer, decepticon: Transformer) -> Transformer?{
//
//        // Special Rule 1
//        if autobot.name == "Optimus Prime" || autobot.name == "Predaking" &&
//            decepticon.name == "Optimus Prime" || decepticon.name == "Predaking"{
//
//            destroyEverything()
//            return nil
//        }
//
//        if autobot.name == "Optimus Prime" || autobot.name == "Predaking"{
//            return autobot
//        }
//        else if decepticon.name == "Optimus Prime" || decepticon.name == "Predaking"{
//            return decepticon
//        }
//
//        // Rule 1
//        if autobot.courage - decepticon.courage <= 4 && autobot.strength - decepticon.strength <= 3 {
//            return autobot
//        }
//        else if decepticon.courage - autobot.courage <= 4 && decepticon.strength - autobot.strength <= 3 {
//            return decepticon
//        }
//
//        // Rule 2
//
//        if autobot.skill - decepticon.skill >= 3{
//            return autobot
//        }
//        else if decepticon.skill - autobot.skill >= 3{
//            return decepticon
//        }
//
//        // Rule 3
//
//        if autobot.rank > decepticon.rank{
//            return autobot
//        }
//        else if decepticon.rank > autobot.rank {
//            return decepticon
//        }
//        else{
//            // both are destroyed
//            return nil
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
