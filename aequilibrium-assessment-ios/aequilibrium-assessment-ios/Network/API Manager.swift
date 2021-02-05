//
//  API Manager.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    private let sessionManager = Session()
    static let networkEnviroment: NetworkEnvironment = .dev

    public typealias defaultCompletion = (Result<Bool,Error>) -> Void
    
    func getAccessToken(completionHandler: @escaping defaultCompletion){
        let endPoint : EndpointItem = .getToken
        var request = URLRequest(url: endPoint.url)
        request.method = endPoint.httpMethod
        request.headers = endPoint.headers
        
        AF.request(request).responseJSON(completionHandler: { data in
            if data.response?.statusCode == 200 {
                
                completionHandler(.success(true))
            }
            else {
                print("Could not get Access Token")
                completionHandler(.failure(Errors.accessTokenNotRecieved))
            }
        })
    }
    
}

public enum Errors : Error {
    case accessTokenNotRecieved

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
        }
    }
    
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getToken:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getToken:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json",
                    "Authorization": UserDefaults.standard.string(forKey: UserDefaultsKey.accessToken) ?? ""]
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


