//
//  Result.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

public enum Result<A, String> {
    case success(A)
    case failure(String)
}

extension Result {
    init(value: A?, or error: String) {
        guard let value = value else {
            self = .failure(error)
            return
        }
        
        self = .success(value)
    }
    
    var value: A? {
        guard case let .success(value) = self else { return nil }
        return value
    }
    
    var error: String? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}
