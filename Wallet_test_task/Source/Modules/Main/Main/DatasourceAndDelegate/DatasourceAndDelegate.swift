//
//  DatasourceAndDelegate.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class MainDatasourceAndDelegate: NSObject, UITableViewDataSource {
    
    weak var controller: MainViewController?
    var breeds: [(breed: String, subBreeds: [String])] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = breeds[indexPath.row].breed
        return cell
    }
}

//MARK: - Delegate

extension MainDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let breed = breeds[indexPath.row]
        let subBreeds = breeds[indexPath.row].subBreeds
        guard !subBreeds.isEmpty else {
            controller?.presenter?.showDogs(for: breed.breed)
            return
        }
        controller?.presenter?.showSubBreeds(breed)
    }
}
