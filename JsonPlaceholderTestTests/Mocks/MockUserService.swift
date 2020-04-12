//
//  MockUserService.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
@testable import JsonPlaceholderTest

final class MockUserService: UserService {
    
    var result: ServiceResponse<User>
    
    init(result: ServiceResponse<User>) {
        self.result = result
    }
    
    func fetchUser(by id: String, completion: @escaping (ServiceResponse<User>) -> Void) {
        switch result {
        case .success(let user):
            if "\(user.id)" == id {
                completion(.success(response: user))
            } else {
                completion(.failure(error: AppError.server))
            }
        case .failure(let error):
            completion(.failure(error: error))
        }
    }
}
