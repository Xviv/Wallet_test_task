//
//  Breeds.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

struct Breeds: Codable {
    let message: [String: [String]]
    var resultTuple: [(breed: String, subBreeds: [String])] {
        return message.map({(breeds: $0, subBreeds: $1)})
    }
    enum CodingKeys: String, CodingKey {
        case message
    }
}
