//
//  Fight.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 07/02/2021.
//

import Foundation


class Fight {
    
    var numberOfRounds : Int {
        return autobots.count >= decepticons.count ? decepticons.count : autobots.count
    }
    var transformers : [Transformer]
    var autobots: [Transformer]
    var decepticons: [Transformer]
    var winningTeam = String()
    var destroyEverything = Bool()
    
    init(transformers: [Transformer]) {
        self.transformers = transformers
        self.autobots = transformers.filter({$0.team == "A"})
        self.decepticons = transformers.filter({$0.team == "D"})
    }
    
    func prepareForFight(transformers: [Transformer]) {
        
        var countForWinner = 0
        
        for _ in 1...numberOfRounds{
            
            if let autobotContender = autobots.max(by: {$0.rank < $1.rank}),
               let decepticonContender = decepticons.max(by: {$0.rank < $1.rank}){
                
                if let winner = fight(autobot: autobotContender, decepticon: decepticonContender) {
                    print("WINNER:", winner)
                    
                    
                    if winner.team == "A" {
                        countForWinner += 1
                    }
                    else {
                        countForWinner -= 1
                    }
                }

                if let index = autobots.firstIndex(of: autobotContender) {
                    autobots.remove(at: index)
                }
                if let index = decepticons.firstIndex(of: decepticonContender) {
                    decepticons.remove(at: index)
                }
            }
        }
        
        if countForWinner > 0 {
            winningTeam = "A"
        }
        else if countForWinner < 0 {
            winningTeam = "D"
        }
        else{
            winningTeam = "T"
        }
        
    }
    
    func fight(autobot: Transformer, decepticon: Transformer) -> Transformer?{
        
        // Special Rule 1
        if autobot.name == "Optimus Prime" || autobot.name == "Predaking" &&
            decepticon.name == "Optimus Prime" || decepticon.name == "Predaking"{
            
            destroyEverything = true
            return nil
        }
        
        if autobot.name == "Optimus Prime" || autobot.name == "Predaking"{
            return autobot
        }
        else if decepticon.name == "Optimus Prime" || decepticon.name == "Predaking"{
            return decepticon
        }
        
        // Rule 1
        if autobot.courage - decepticon.courage <= 4 && autobot.strength - decepticon.strength <= 3 {
            return autobot
        }
        else if decepticon.courage - autobot.courage <= 4 && decepticon.strength - autobot.strength <= 3 {
            return decepticon
        }
        
        // Rule 2
        
        if autobot.skill - decepticon.skill >= 3{
            return autobot
        }
        else if decepticon.skill - autobot.skill >= 3{
            return decepticon
        }
        
        // Rule 3
        
        if autobot.overallRating > decepticon.overallRating{
            return autobot
        }
        else if decepticon.overallRating > autobot.overallRating {
            return decepticon
        }
        else{
            // both are destroyed
            return nil
        }
    }
    
}
