//
//  NetworkManager.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum NetworkResponseResult<String>{
    case success
    case failure(String)
}

protocol NetworkManager {
    
    associatedtype EndPoint: EndPointType
    
    var router: Router<EndPoint> { get set }
    
    func handleResponse<Model: Codable>(type: Model.Type, answer: (data: Data?, response: URLResponse?, error: Error?), completion: @escaping (Result<Model, String>) -> ())
}

extension NetworkManager {
    
    static var environment: NetworkEnvironment {
        .production
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponseResult<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func handleResponse<Model: Codable>(type: Model.Type, answer: (data: Data?, response: URLResponse?, error: Error?), completion: @escaping (Result<Model, String>) -> ()) {
        if let response = answer.response as? HTTPURLResponse {
            let result = self.handleNetworkResponse(response)
            switch result {
            case .success:
                guard let responseData = answer.data else {
                    completion(.failure(NetworkResponse.noData.rawValue))
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(type, from: responseData)
                    completion(.success(apiResponse))
                }catch {
                    completion(.failure(NetworkResponse.unableToDecode.rawValue))
                }
            case .failure(let networkFailureError):
                completion(.failure(networkFailureError))
            }
        }
    }
}




