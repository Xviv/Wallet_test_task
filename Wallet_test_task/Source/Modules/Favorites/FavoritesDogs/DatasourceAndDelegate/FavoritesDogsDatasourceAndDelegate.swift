//
//  FavoritesDogsDatasourceAndDelegate.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class FavoritesDogsDatasourceAndDelegate: NSObject, UICollectionViewDataSource {
    weak var controller: FavoritesDogsController?
    var breed: CommonBreedProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breed?.localURLs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoritesDogsCell
        cell.localUrlString = breed?.localURLs[indexPath.row]
        cell.webUrlString = breed?.imageURLs[indexPath.row]

        cell.buttonTapAction = { url in
            self.controller?.presenter?.removeImageFromFavorites(imageUrl: url)
        }
        
        return cell
    }
}

extension FavoritesDogsDatasourceAndDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = scrollView.contentOffset.x / pageWidth
        let page = Int(ceil(currentPage))
        guard let url = breed?.localURLs[page] else { return }
        controller?.presenter?.getCurrentImageUrl(url: url)
    }
}
