//
//  FavoritesDogsCell.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class FavoritesDogsCell: UICollectionViewCell {
    
    //MARK: - Properties
    var localUrlString: String? {
        didSet {
            guard let urlString = localUrlString else { return }
            do {
                let data = try Data(contentsOf: URL(string: urlString)!)
                imageView.image = UIImage(data: data)
            } catch {
                print(error)
            }
        }
    }
    
    var webUrlString: String?
    
    var buttonTapAction: ((_ url: String) -> ())?
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Reuse
    override func prepareForReuse() {
        imageView.image = nil
        likeButton.isSelected = false
    }
    
    //MARK: - Views
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart_filled"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.addTarget(self, action: #selector(likeButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - UI Setup
    private func setupUI() {
        addSubview(imageView)
        addSubview(likeButton)
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            likeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            likeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            likeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    //MARK: - Actions
    
    @objc func likeButtonAction(_ button: UIButton) {
        guard let webUrl = webUrlString else { return }
        buttonTapAction?(webUrl)
    }
}
