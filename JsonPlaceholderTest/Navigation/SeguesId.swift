//
//  SeguesId.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

public enum SeguesId: String {
    case fromPostsToPostDetails
}

extension UIViewController {
    func performSegue(_ identifier: SeguesId, sender: Any?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
}
