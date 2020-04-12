//
//  FetchUserProvider.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

protocol FetchUserProvider {
    func fetchUser(by id: String, completion: @escaping (ServiceResponse<User>) -> Void)
}
