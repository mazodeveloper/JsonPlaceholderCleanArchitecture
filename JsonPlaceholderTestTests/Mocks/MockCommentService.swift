//
//  MockCommentService.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
@testable import JsonPlaceholderTest

final class MockCommentService: CommentService {
    var result: ServiceResponse<[Comment]>
    
    init(result: ServiceResponse<[Comment]>) {
        self.result = result
    }
    
    func fetchComments(by postId: String, completion: @escaping (ServiceResponse<[Comment]>) -> Void) {
        completion(result)
    }
}
