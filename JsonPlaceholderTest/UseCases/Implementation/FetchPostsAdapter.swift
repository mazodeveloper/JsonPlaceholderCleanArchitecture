//
//  FetchPostsAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class FetchPostsAdapter: FetchPostsProvider {
    
    let postService: PostService
    
    init(postService: PostService = PostServiceAdapter()) {
        self.postService = postService
    }
    
    func execute(completion: @escaping (ServiceResponse<[Post]>) -> Void) {
        postService.fetchPosts(completion: completion)
    }
}
