//
//  RemovePostAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class RemovePostAdapter: RemovePostProvider {
    
    let postCache: PostRepository
    
    init(postCache: PostRepository = PostCache()) {
        self.postCache = postCache
    }
    
    func removePosts() throws {
        try postCache.deleteAll()
    }
}
