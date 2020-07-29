//
//  SubBreedsDatasourceAndDelegate.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class SubBreedsDatasourceAndDelegate: NSObject, UITableViewDataSource {
    
    weak var controller: SubBreedsViewController?
    var breeds: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = breeds[indexPath.row]
        return cell
    }
}

//MARK: - Delegate

extension SubBreedsDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let breed = breeds[indexPath.row]
        controller?.presenter?.showDogs(for: breed)
    }
}
