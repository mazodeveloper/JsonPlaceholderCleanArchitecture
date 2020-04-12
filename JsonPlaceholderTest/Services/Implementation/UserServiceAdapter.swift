//
//  UserServiceAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class UserServiceAdapter: UserService {
    
    let baseService: BaseService
    let urlGenerator: URLGenerable
    
    init(baseService: BaseService = WebService(),
         urlGenerator: URLGenerable = PlaceHolderEndpoint()) {
        self.baseService = baseService
        self.urlGenerator = urlGenerator
    }
    
    func fetchUser(by id: String, completion: @escaping (ServiceResponse<User>) -> Void) {
        let url = urlGenerator.getUrl(for: .user(id: id))
        baseService.callEndpoint(responseType: User.self, url: url, completion: completion)
    }
}
