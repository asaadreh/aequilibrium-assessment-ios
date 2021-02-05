//
//  Transformer.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation

struct Transformer : Codable {
    var name : String
    var strength : Int
    var intelligence : Int
    var speed : Int
    var endurance : Int
    var rank : Int
    var courage : Int
    var firepower : Int
    var skill : Int
    var team : String
    var overallRating : Int {
        return strength + intelligence + speed + endurance + firepower
    }
}
