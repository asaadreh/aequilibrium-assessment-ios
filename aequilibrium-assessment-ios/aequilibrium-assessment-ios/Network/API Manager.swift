//
//  API Manager.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation
import Alamofire


/// API Manager is a manager for making API calls
class APIManager {
    
    /// Singleton for accessing member functions
    static let shared = APIManager()
    private let sessionManager = Session()
    static let networkEnviroment: NetworkEnvironment = .dev

    public typealias defaultCompletion = (Result<Bool,Error>) -> Void
    public typealias createTransformerCompletion = (Result<Transformer,Error>) -> Void
    
    /// API call to get access token which is saved in User Defaults with key which can be accessed through UserDefaultsKey.accessToken
    func getAccessToken(completionHandler: @escaping defaultCompletion){
        let endPoint : EndpointItem = .getToken
        var request = URLRequest(url: endPoint.url)
        request.method = endPoint.httpMethod
        request.headers = endPoint.headers
        
        AF.request(request).response{ data in
            if data.response?.statusCode == 200 ||  data.response?.statusCode == 201 {
                if let responseJSON = data.data {
                    let accessToken = String(data: responseJSON, encoding: String.Encoding.utf8)
//                    print(accessToken)
                    let defaults = UserDefaults.standard
                    defaults.setValue(accessToken, forKey: UserDefaultsKey.accessToken)
                    completionHandler(.success(true))
                }
            }
            else {
                print("Could not get Access Token")
                completionHandler(.failure(Errors.accessTokenNotRecieved))
            }
        }
    }
    
    
    /// API call to create transformer. Completion Handler returns a Transfromer object when successful
    func createTransformer(transformer : Transformer, completionHandler: @escaping createTransformerCompletion) {
        let endPoint : EndpointItem = .createTransformer
        var request = URLRequest(url: endPoint.url)
        request.method = endPoint.httpMethod
        request.headers = endPoint.headers
        
        let jsonData = try? JSONEncoder().encode(transformer)
//        let jsonString = String(data: jsonData!, encoding: .utf8)!
        request.httpBody = jsonData
        print(request.headers)
        
        AF.request(request).response{ data in
            if data.response?.statusCode == 200 ||  data.response?.statusCode == 201  {
                if let responseJSON = data.data {
                    do {
                        let decoder = JSONDecoder()
                        let recievedtransformer = try decoder.decode(Transformer.self, from: responseJSON)
                        completionHandler(.success(recievedtransformer))
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
            }
            else {
                if let responseJSON = data.data {
                    let errorMsg = String(data: responseJSON, encoding: String.Encoding.utf8)
                    completionHandler(.failure(Errors.serverGenerated(errorMsg ?? "Unknown Error")))
                }
                completionHandler(.failure(Errors.failedToCreateTransformer))
            }
        }
    }
    
    
    /// API call to update transformer. Completion Handler returns an updated Transformer with same id
    func updateTransformer( transformer : Transformer, completionHandler: @escaping createTransformerCompletion) {
        
        let endPoint : EndpointItem = .updateTransformer
        var request = URLRequest(url: endPoint.url)
        request.method = endPoint.httpMethod
        request.headers = endPoint.headers
        
        let jsonData = try? JSONEncoder().encode(transformer)
//        let jsonString = String(data: jsonData!, encoding: .utf8)!
        request.httpBody = jsonData

        
        AF.request(request).response{ data in
            if data.response?.statusCode == 200 ||  data.response?.statusCode == 201  {
                if let responseJSON = data.data {
                    do {
                        
                        let decoder = JSONDecoder()
                        let recievedtransformer = try decoder.decode(Transformer.self, from: responseJSON)
                        completionHandler(.success(recievedtransformer))
                    }
                    catch{
                        completionHandler(.failure(error))
                        print(error.localizedDescription)
                    }
                }
            }
            else {
                if let responseJSON = data.data {
                    let errorMsg = String(data: responseJSON, encoding: String.Encoding.utf8)
                    
                    completionHandler(.failure(Errors.serverGenerated(errorMsg ?? "Unknown Error")))
                }
                completionHandler(.failure(Errors.failedToUpdateTransformer))
            }
        }
    }
    
    
    /// API call to delete transformer.
    func deleteTransformer(transformerId : String, completionHandler: @escaping defaultCompletion) {
        
        let endPoint : EndpointItem = .deleteTransformer(transformerId)
        var request = URLRequest(url: endPoint.url)
        request.method = endPoint.httpMethod
        request.headers = endPoint.headers

        AF.request(request).response{ data in
            if data.response?.statusCode == 204 {
                completionHandler(.success(true))
            }
            else {
                print("Could not get Access Token")
                completionHandler(.failure(Errors.accessTokenNotRecieved))
            }
        }
    }
}

public enum Errors : Error {
    case accessTokenNotRecieved
    case serverGenerated(String)
    case failedToCreateTransformer
    case failedToUpdateTransformer
}

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    
}

// MARK: User actions
enum EndpointItem {
    case getToken
    case createTransformer
    case deleteTransformer(String)
    case updateTransformer
}

enum NetworkEnvironment {
    case dev
}

extension EndpointItem: EndPointType {
    
    // MARK: - Vars & Lets

    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .dev: return "https://transformers-api.firebaseapp.com/"
        }
    }
    
    var path: String {
        switch self {
        
        case .getToken:
            return "allspark"
        case .createTransformer:
            return "transformers"
        case .deleteTransformer(let id):
            return "transformers/\(id)"
        case .updateTransformer:
            return "transformers"
        }
    }
    
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getToken:
            return .get
        case .createTransformer:
            return .post
        case .deleteTransformer:
            return .delete
        case .updateTransformer:
            return .put
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getToken:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(String(describing: UserDefaults.standard.string(forKey: UserDefaultsKey.accessToken)!))" ]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
}


