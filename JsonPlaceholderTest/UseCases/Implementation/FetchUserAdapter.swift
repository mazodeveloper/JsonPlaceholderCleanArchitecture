//
//  FetchUserAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class FetchUserAdapter: FetchUserProvider {
    
    let userService: UserService
    
    init(userService: UserService = UserServiceAdapter()) {
        self.userService = userService
    }
    
    func fetchUser(by id: String, completion: @escaping (ServiceResponse<User>) -> Void) {
        userService.fetchUser(by: id, completion: completion)
    }
}
