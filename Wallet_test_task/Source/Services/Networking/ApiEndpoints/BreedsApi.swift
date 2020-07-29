//
//  BreedsApi.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

enum BreedsApi {
    case allBreeds
    case byBreed(_ breed: String)
    case bySubBreed(breed: String, subBreed: String)
}

extension BreedsApi: EndPointType {
    
    var environmentBaseURL : String {
        switch BreedsNetworkManager.environment {
        case .production: return "https://dog.ceo/api"
        case .qa: return "https://dog.ceo/api"
        case .staging: return "https://dog.ceo/api"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .allBreeds:
            return "/breeds/list/all"
        case .byBreed(let breed):
            return "/breed/\(breed)/images"
        case .bySubBreed(let breed, let subBreed):
            return "/breed/\(breed)/\(subBreed)/images"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
