//
//  Favorites.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation
import RealmSwift

protocol CommonBreedProtocol: Object {
    var imageURLs: RealmSwift.List<String> { get }
    var localURLs: RealmSwift.List<String> { get }
    var name: String { get }
}

class RBreed: Object, CommonBreedProtocol {
    
    @objc dynamic var name: String = ""
    let subBreed = RealmSwift.List<RSubBreed>()
    var imageURLs = RealmSwift.List<String>()
    var localURLs = RealmSwift.List<String>()
    
    func append(_ subBreed: RSubBreed) {
        guard !self.subBreed.contains(subBreed) else { return }
        self.subBreed.append(subBreed)
    }
    
    func append(_ string: String) {
        guard !imageURLs.contains(string) else { return }
        imageURLs.append(string)
    }
    
    func append(localUrl: String) {
        guard !localURLs.contains(localUrl) else { return }
        localURLs.append(localUrl)
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
}

class RSubBreed: Object, CommonBreedProtocol {
    
    @objc dynamic var name: String = ""
    var imageURLs = RealmSwift.List<String>()
    var localURLs = RealmSwift.List<String>()
    var linkToParent = LinkingObjects(fromType: RBreed.self, property: "subBreed")
    
    func append(_ string: String) {
        guard !imageURLs.contains(string) else { return }
        imageURLs.append(string)
    }
    
    func append(localUrl: String) {
        guard !localURLs.contains(localUrl) else { return }
        localURLs.append(localUrl)
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
}
