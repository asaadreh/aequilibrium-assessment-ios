//
//  Local Storage Manager.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation

/// LocalStorageManager uses UserDefaults to store the current state of transformers
class LocalStorageManager {
    
    /// LocalStorageManager is a singleton class
    static var shared = LocalStorageManager()
    
    /**
        saveData takes a transformer as a parameter and stores it.
    */
    public func saveData(transformers : [Transformer]) {
        let defaults = UserDefaults.standard
        
        let encoder = JSONEncoder()
        
        guard let savedData = try? encoder.encode(transformers) else {
            fatalError("Unable to encode transformers data.")
        }
        defaults.set(savedData,forKey: UserDefaultsKey.transformers)
    }
    /**
        loadData returns an optional array of Transformers.

            Nil will be returned if no Transformers are found.
    */
    func loadData() -> [Transformer]? {
        let defaults = UserDefaults.standard
        
        guard let savedData = defaults.data(forKey: UserDefaultsKey.transformers) else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let savedTransformers = try? decoder.decode([Transformer].self, from: savedData) else {
            return nil
        }
        
        return savedTransformers
    }
    
}
