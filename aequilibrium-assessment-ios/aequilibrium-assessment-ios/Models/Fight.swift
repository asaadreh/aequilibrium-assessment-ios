//
//  Fight.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 07/02/2021.
//

import Foundation



/// Winner is an enum which can be either
/// Autobots, Deceptors or Tie (no winner)
enum Winner {
    case Autobots
    case Decepticons
    case Tie
}

class Fight {
    
    internal var numberOfRounds : Int
    var transformers : [Transformer]
    var autobots: [Transformer]
    var decepticons: [Transformer]
    var winningTeam : Winner
    var destroyEverything = Bool()
    
    init(transformers: [Transformer]) {
        self.transformers = transformers
        self.autobots = transformers.filter({$0.team == .Autobots}).sorted(by: {$0.rank > $1.rank})
        self.decepticons = transformers.filter({$0.team == .Decepticons}).sorted(by: {$0.rank > $1.rank})
        self.winningTeam = .Tie
        self.numberOfRounds = autobots.count >= decepticons.count ? decepticons.count : autobots.count
    }
    
    func prepareForFight() {
        
        var countForWinner = 0
        
        for i in 0..<numberOfRounds{
            
            if !destroyEverything {
                let winner = fight(autobot: autobots[i], decepticon: decepticons[i])
                if winner ==  .Autobots{
                    countForWinner += 1
                }
                if winner == .Decepticons {
                    countForWinner -= 1
                }
            }
            else {
                break
            }
        }
        
        if countForWinner > 0 {
            winningTeam = .Autobots
        }
        else if countForWinner < 0 {
            winningTeam = .Decepticons
        }
        else{
            winningTeam = .Tie
        }
        
    }
    
    internal func fight(autobot: Transformer, decepticon: Transformer) -> Winner{
        
        // Special Rule 1
        if autobot.name == "Optimus Prime" || autobot.name == "Predaking" &&
            decepticon.name == "Optimus Prime" || decepticon.name == "Predaking"{
            
            destroyEverything = true
            return .Tie
        }
        
        if autobot.name == "Optimus Prime" || autobot.name == "Predaking"{
            return .Autobots
        }
        else if decepticon.name == "Optimus Prime" || decepticon.name == "Predaking"{
            return .Decepticons
        }
        
        // Rule 1
        if autobot.courage - decepticon.courage >= 4 && autobot.strength - decepticon.strength >= 3 {
            return .Autobots
        }
        else if decepticon.courage - autobot.courage >= 4 && decepticon.strength - autobot.strength >= 3 {
            return .Decepticons
        }
        
        // Rule 2
        
        if autobot.skill - decepticon.skill >= 3{
            return .Autobots
        }
        else if decepticon.skill - autobot.skill >= 3{
            return .Decepticons
        }
        
        // Rule 3
        
        if autobot.overallRating > decepticon.overallRating{
            return .Autobots
        }
        else if decepticon.overallRating > autobot.overallRating {
            return .Decepticons
        }
        else{
            // both are destroyed
            return .Tie
        }
    }
    
}
