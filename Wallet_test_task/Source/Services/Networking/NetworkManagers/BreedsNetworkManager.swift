//
//  BreedsNetworkManager.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

struct BreedsNetworkManager: NetworkManager {
    
    var router = Router<BreedsApi>()
    
    
    func getAllBreeds(completion: @escaping (Result<Breeds, String>) -> ()) {
        router.request(.allBreeds) { (data, response, error) in
            if error != nil {
                completion(.failure("Please check your network connection."))
                return
            }
            
            self.handleResponse(type: Breeds.self, answer: (data, response, error)) { (result) in
                switch result {
                case .success(let breeds):
                    completion(.success(breeds))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getDogs(by breed: String, completion: @escaping (Result<[String], String>) -> ()) {
        router.request(.byBreed(breed)) { (data, response, error) in
            if error != nil {
                completion(.failure("Please check your network connection."))
                return
            }
            
            self.handleResponse(type: Dogs.self, answer: (data, response, error)) { (result) in
                switch result {
                case .success(let dogs):
                    let imagesURLs = dogs.message
                    completion(.success(imagesURLs))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getDogs(breed: String, subBreed: String, completion: @escaping (Result<[String], String>) -> ()) {
        router.request(.bySubBreed(breed: breed, subBreed: subBreed)) { (data, response, error) in
            if error != nil {
                completion(.failure("Please check your network connection."))
                return
            }
            
            self.handleResponse(type: Dogs.self, answer: (data, response, error)) { (result) in
                switch result {
                case .success(let dogs):
                    let imagesURLs = dogs.message
                    completion(.success(imagesURLs))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
