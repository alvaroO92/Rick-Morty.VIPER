//
//  BaseViewController.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import UIKit

class BaseViewController : UIViewController, AlertView {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func showAlertError() {
        let alert = UIAlertController(
            title: "errorTitle".localized,
            message: "errorMessage".localized,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "errorButton".localized, style: .default))
        self.present(alert, animated: true)
    }
}
