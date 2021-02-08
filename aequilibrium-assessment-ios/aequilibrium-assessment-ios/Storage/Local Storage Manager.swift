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
    
    
//    public func saveTransformer(trans: Transformer) {
//
//
//        guard let data = UserDefaults.standard.data(forKey: "transformer") else {
//            // Create an array of transformers
//            let transformers = [trans]
//
//            do {
//                let encoder = JSONEncoder()
//                let data = try encoder.encode(transformers)
//                UserDefaults.standard.setValue(data, forKey: "transformer")
//            } catch{
//                print(error.localizedDescription)
//            }
//            return
//        }
//
//        do {
//            // Create JSON Decoder
//            let decoder = JSONDecoder()
//
//            // Decode Note
//            var transformers = try decoder.decode([Transformer].self, from: data)
//            transformers.append(trans)
//            print("List:", transformers)
//            do {
//                let encoder = JSONEncoder()
//                let data = try encoder.encode(transformers)
//                UserDefaults.standard.setValue(data, forKey: "transformer")
//            } catch{
//                print(error.localizedDescription)
//            }
//
//        } catch {
//            print("Unable to Decode transformers array (\(error))")
//        }
//    }
//
//    public func getAllTransformers() -> [Transformer]? {
//        guard let data = UserDefaults.standard.data(forKey: "transformer") else {
//            return nil
//        }
//
//        do {
//            // Create JSON Decoder
//            let decoder = JSONDecoder()
//
//            // Decode Transformer
//            let transformers = try decoder.decode([Transformer].self, from: data)
//            return transformers
//
//        } catch {
//            print("Unable to Decode Note (\(error))")
//        }
//        return nil
//    }
//
    
}
