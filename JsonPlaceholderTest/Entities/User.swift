//
//  User.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var email: String
    var phone: String
    var website: String
}
