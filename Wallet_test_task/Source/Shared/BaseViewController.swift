//
//  BaseViewController.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol BaseViewControllerOutput: class {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlert(message: String, actionHandler: ((UIAlertAction) -> Void)?)
}

extension BaseViewControllerOutput {
    func showAlert(message: String, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        showAlert(message: message, actionHandler: actionHandler)
    }
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        activityIndicator.layer.zPosition = 999
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.center = self.view.center
        ai.style = .gray
        ai.hidesWhenStopped = true
        
        return ai
    }()
    
    func showAlert(message: String, actionHandler: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                self.dismiss(animated: true) {
                    actionHandler?(action)
                }
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
