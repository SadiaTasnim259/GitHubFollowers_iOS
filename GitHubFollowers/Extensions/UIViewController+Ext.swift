//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Sadia on 26/8/23.
//

import UIKit

extension UIViewController{
    func presentGitHubAlertViewcontrollerOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GitHubAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
