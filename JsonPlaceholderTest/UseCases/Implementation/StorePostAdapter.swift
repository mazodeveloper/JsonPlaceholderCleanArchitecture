//
//  StorePostAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class StorePostAdapter: StorePostProvider {
    
    let postCache: PostRepository
    
    init(postCache: PostRepository = PostCache()) {
        self.postCache = postCache
    }
    
    func store(posts: [PostViewModel]) throws {
        try postCache.save(posts: posts)
    }
    
    func update(post: PostViewModel) throws {
        try postCache.update(post: post)
    }
}
