//
//  MockPostService.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
@testable import JsonPlaceholderTest

final class MockPostService: PostService {
    
    var result: ServiceResponse<[Post]>
    
    init(result: ServiceResponse<[Post]>) {
        self.result = result
    }
    
    func fetchPosts(completion: @escaping (ServiceResponse<[Post]>) -> Void) {
        completion(result)
    }
}
