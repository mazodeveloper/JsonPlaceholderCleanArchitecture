//
//  FetchCommentsAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class FetchCommentsAdapter: FetchCommentsProvider {
    
    let commentService: CommentService
    
    init(commentService: CommentService = CommentServiceAdapter()) {
        self.commentService = commentService
    }
    
    func fetchComments(by postId: String, completion: @escaping (ServiceResponse<[Comment]>) -> Void) {
        commentService.fetchComments(by: postId, completion: completion)
    }
}
