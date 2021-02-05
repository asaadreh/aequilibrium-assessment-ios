//
//  Local Storage Manager.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation

class LocalStorageManager {
     
    public func saveUser(transformer: Transformer) {
        do {
             
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(transformer)
            let json = String(data: jsonData, encoding: .utf8) ?? "{}"
             
            let defaults: UserDefaults = UserDefaults.standard
            defaults.set(json, forKey: "transformers")
            defaults.synchronize()
             
        } catch {
            print(error.localizedDescription)
        }
    }
     
    public func getUser() -> Transformer? {
        do {
            if (UserDefaults.standard.object(forKey: "transformer") == nil) {
                return nil
            } else {
                let json = UserDefaults.standard.string(forKey: "user") ?? "{}"
                 
                let jsonDecoder = JSONDecoder()
                guard let jsonData = json.data(using: .utf8) else {
                    return nil
                }
                 
                let transformer: Transformer = try jsonDecoder.decode(Transformer.self, from: jsonData)
                return transformer
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
     
    public func removeUser() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
        defaults.synchronize()
    }
}
