//
//  LoadPostsAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class LoadPostsAdapter: LoadPostsProvider {
    
    let postCache: PostRepository
    
    init(postCache: PostRepository = PostCache()) {
        self.postCache = postCache
    }
    
    func execute() throws -> [PostViewModel] {
        try postCache.retrievePosts()
    }
}
