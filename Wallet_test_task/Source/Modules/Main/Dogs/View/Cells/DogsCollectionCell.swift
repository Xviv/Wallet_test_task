//
//  DogsCollectionCell.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit
import SDWebImage

class DogsCollectionCell: UICollectionViewCell {
    
    //MARK: - Properties
    var urlString: String? {
        didSet {
            guard let urlString = urlString else { return }
            guard let url = URL(string: urlString) else { return }
            imageView.sd_setImage(with: url)
        }
    }
    
    var favorites: [String] = [] {
        didSet {
            guard let urlString = urlString else { return }
            if favorites.contains(urlString) {
                likeButton.isSelected = true
            }
        }
    }
    
    var imageTapAction: ((_ url: String, _ image: UIImage) -> ())?
    var buttonTapAction: ((_ url: String) -> ())?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Reuse
    override func prepareForReuse() {
        imageView.sd_cancelCurrentImageLoad()
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
        button.setImage(UIImage(named: "heart_empty"), for: .normal)
        button.setImage(UIImage(named: "heart_filled"), for: .selected)
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
    
    //MARK: - Gestures
    
    private func setupGestures() {
        let doubleTapGesture = UITapGestureRecognizer()
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.addTarget(self, action: #selector(tapAction))
        
        imageView.addGestureRecognizer(doubleTapGesture)
    }
    
    //MARK: - Actions
    
    @objc func tapAction() {
        guard let urlString = urlString else { return }
        guard let image = imageView.image else { return }
        imageTapAction?(urlString, image)
    }
    
    @objc func likeButtonAction(_ button: UIButton) {
        guard let urlString = urlString else { return }
        if button.isSelected {
            buttonTapAction?(urlString)
        } else {
            guard let image = imageView.image else { return }
            imageTapAction?(urlString, image)
        }
    }
    
}
