//
//  DogsDatasourceAndDelegate.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class DogsDatasourceAndDelegate: NSObject, UICollectionViewDataSource {
    
    weak var controller: DogsViewController?
    var urls: [String] = []
    var favorites: [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DogsCollectionCell
        cell.urlString = urls[indexPath.row]
        cell.favorites = favorites
        
        cell.imageTapAction = { url, image in
            self.controller?.presenter?.addImageToFavorites(imageUrl: url, image: image)
        }
        
        cell.buttonTapAction = { url in
            self.controller?.presenter?.removeImageFromFavorites(imageUrl: url)
        }
        
        return cell
    }
}

//MARK: - Delegate

extension DogsDatasourceAndDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
