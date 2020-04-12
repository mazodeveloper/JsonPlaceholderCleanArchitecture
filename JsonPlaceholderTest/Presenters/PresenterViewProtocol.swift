//
//  PresenterViewProtocol.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

protocol PresenterViewProtocol: class {
    func updateUI()
    func display(error: Error)
}

extension UIViewController {
    func presentAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(button)
        
        present(alert, animated: true, completion: nil)
    }
}
