//
//  FightTests.swift
//  FightTests
//
//  Created by Agha Saad Rehman on 08/02/2021.
//

import XCTest
@testable import aequilibrium_assessment_ios

class FightTests: XCTestCase {

    var sut: Fight!
    override func setUpWithError() throws {
        super.setUp()
        
        let transformer1 = Transformer(name: "Soundwave",
                                     strength: 8,
                                     intelligence: 9,
                                     speed: 2,
                                     endurance: 6,
                                     rank: 7,
                                     courage: 5,
                                     firepower: 6,
                                     skill: 10,
                                     team: "D")
        let transformer2 = Transformer(name: "Bluestreak",
                                     strength: 6,
                                     intelligence: 5,
                                     speed: 7,
                                     endurance: 9,
                                     rank: 5,
                                     courage: 2,
                                     firepower: 9,
                                     skill: 7,
                                     team: "A")
        let transformer3 = Transformer(name: "Hubcap",
                                     strength: 4,
                                     intelligence: 4,
                                     speed: 4,
                                     endurance: 4,
                                     rank: 4,
                                     courage: 4,
                                     firepower: 4,
                                     skill: 4,
                                     team: "A")
        
        sut = Fight(transformers: [transformer1,transformer2,transformer3])
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testFightSequence() {
        
        XCTAssertEqual(sut.numberOfRounds, 1, "Number of rounds wrongly computed")
        
        //given
        
        
        //when
        sut.prepareForFight()
        
        print(sut.numberOfRounds)
        //then
        
        
        XCTAssertEqual(sut.destroyEverything, false, "Everything destroyed result is incorrect")
        XCTAssertEqual(sut.winningTeam, .Decepticons, "Winner is incorrect")
    }
    
    func testFight() {
        //given
        
        let transformer1 = Transformer(name: "Optimus Prime",
                                     strength: 8,
                                     intelligence: 9,
                                     speed: 2,
                                     endurance: 6,
                                     rank: 7,
                                     courage: 5,
                                     firepower: 6,
                                     skill: 10,
                                     team: "D")
        let transformer2 = Transformer(name: "Predaking",
                                     strength: 6,
                                     intelligence: 5,
                                     speed: 7,
                                     endurance: 9,
                                     rank: 5,
                                     courage: 2,
                                     firepower: 9,
                                     skill: 7,
                                     team: "A")
        
        // when
        
        let winner = sut.fight(autobot: transformer2, decepticon: transformer1)
        
        XCTAssertEqual(winner, nil, "There should be no winner")
        XCTAssertEqual(sut.destroyEverything, true, "Everything should be destroyed")
    }

}
