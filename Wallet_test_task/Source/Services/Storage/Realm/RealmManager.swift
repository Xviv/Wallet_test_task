//
//  RealmManager.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    private var notificationToken: NotificationToken? = nil
    
    let realm = try! Realm()
    
    typealias Updates<T: Object> = ((Results<T>, [Int]) -> Void)?
    
    func write<T: Object>(_ object: T, writeBlock: (() -> Void)?) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        do {
            try realm.write {
                writeBlock?()
                realm.add(object, update: .modified)
                
            }
        } catch {
            print(error)
        }
    }
    
    func getObject<T: Object>(type: T.Type, primaryKey: String) -> T? {
        return realm.object(ofType: type, forPrimaryKey: primaryKey)
    }
    
    func getObjects<T: Object>(type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    func observe<T: Object>(type: T.Type, primaryKey: String, _changes: @escaping (RealmCollectionChange<Results<T>>) -> Void) {
        let objects = getObjects(type: type).filter("name == %@", primaryKey)
        notificationToken = objects.observe({ (changes) in
            _changes(changes)
        })
    }
    
    func observe<T: Object>(type: T.Type, _changes: @escaping (RealmCollectionChange<Results<T>>) -> Void) {
        let result =  getObjects(type: type)
        
        notificationToken = result.observe { (changes: RealmCollectionChange) in
            _changes(changes)
        }
    }
    
    func removeToken() {
        notificationToken = nil
    }
}
