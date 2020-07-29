//
//  FavoriteBreedsDatasourceAndDelegate.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteBreedsDatasourceAndDelegate: NSObject, UITableViewDataSource {
    
    weak var controller: FavoriteBreedsController?
    var breeds: [RBreed]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = breeds?[indexPath.row].name
        return cell
    }
}

//MARK: - Delegate

extension FavoriteBreedsDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let breed = breeds?[indexPath.row]
        if let subBreeds = breeds?[indexPath.row].subBreed {
            guard !subBreeds.isEmpty else {
                controller?.presenter?.showDogs(breed: breed?.name ?? "")
                return
            }
            controller?.presenter?.showSubBreeds(breed: breed?.name ?? "")
        }
    }
}
