//
//  FavoritesRealmManager.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit
import RealmSwift

final class FavoritesRealmManager {
    
    private let realmManager = RealmManager()
    private let documentsManager = DocumentsManager()
    
    func write(url: String, breedName: (breed: String, subBreed: String?)?, image: UIImage) {
        print(url)
        if let breed = realmManager.getObject(type: RBreed.self, primaryKey: breedName?.breed ?? "") {
            let subBreed = realmManager.getObject(type: RSubBreed.self, primaryKey: breedName?.subBreed ?? "")
            let localURL = documentsManager.save(image, name: (url as NSString).lastPathComponent)
            addObject(to: breed, to: subBreed, with: url, localUrl: localURL, for: breedName)
        } else {
            let localURL = documentsManager.save(image, name: (url as NSString).lastPathComponent)
            createNewRealmObject(with: url, localUrl: localURL, breed: breedName)
        }
    }
    
    func getFavorites<T: Object>(in breedName: String, of type: T.Type) -> [String] {
        guard let dbBreed = realmManager.getObject(type: type, primaryKey: breedName) as? CommonBreedProtocol else { return [] }
        let dbURLs = dbBreed.imageURLs
        return Array(dbURLs)
    }
    
    func removeFromFavorites<T: Object>(in breedName: String, imageURL: String, of type: T.Type, emptyCompletion: (() -> Void)? = nil)  -> String? {
        guard let dbBreed = realmManager.getObject(type: type, primaryKey: breedName) as? CommonBreedProtocol else { return nil }
        guard let index = dbBreed.imageURLs.index(of: imageURL) else { return nil }
        let name = (imageURL as NSString).lastPathComponent
        let localUrl = documentsManager.delete(name: name)
        
        
        let deletedElement = dbBreed.imageURLs[index]
        realmManager.write(dbBreed) {
            dbBreed.imageURLs.remove(at: index)
            if let localUrlIndex = dbBreed.localURLs.index(of: localUrl ?? "") {
                dbBreed.localURLs.remove(at: localUrlIndex)
            }
        }
        
        if dbBreed.imageURLs.isEmpty {
            emptyCompletion?()
            if let breed = dbBreed as? RSubBreed {
                if let parent = breed.linkToParent.first {
                    if parent.subBreed.count == 1 {
                        realmManager.delete(breed)
                        realmManager.delete(parent)
                    } else {
                        realmManager.delete(breed)
                    }
                }
            } else {
                realmManager.delete(dbBreed)
            }
        }
        return deletedElement
    }
    
    private func createNewRealmObject(with url: String, localUrl: String?, breed: (breed: String, subBreed: String?)?) {
        let rBreed = RBreed()
        let rSubBreed = RSubBreed()
        
        if let subBreed = breed?.subBreed {
            realmManager.write(rBreed) {
                rBreed.name = breed?.breed ?? ""
                rSubBreed.name = subBreed
                rSubBreed.imageURLs.append(url)
                
                if let localUrl = localUrl {
                    rSubBreed.append(localUrl: localUrl)
                }
                
                rBreed.subBreed.append(rSubBreed)
            }
        } else {
            realmManager.write(rBreed) {
                rBreed.name = breed?.breed ?? ""
                
                if let localUrl = localUrl {
                    rBreed.append(localUrl: localUrl)
                }
                
                rBreed.imageURLs.append(url)
            }
        }
    }
    
    private func addObject(to breed: RBreed, with url: String) {
        realmManager.write(breed) {
            breed.append(url)
        }
    }
    
    private func addObject(to breed: RBreed, to subBreed: RSubBreed?, with url: String, localUrl: String?, for breedName: (breed: String, subBreed: String?)?) {
        realmManager.write(breed) {
            if let subBreed = subBreed {
                subBreed.append(url)
                
                if let localUrl = localUrl {
                    subBreed.append(localUrl: localUrl)
                }
                
                breed.append(subBreed)
            } else {
                if let name = breedName?.subBreed {
                    let subBreed = RSubBreed()
                    subBreed.name = name
                    subBreed.append(url)
                    
                    if let localUrl = localUrl {
                        subBreed.append(localUrl: localUrl)
                    }
                    
                    breed.append(subBreed)
                } else {
                    breed.append(url)
                    if let localUrl = localUrl {
                        breed.append(localUrl: localUrl)
                    }
                }
            }
        }
    }
}
