//
//  MockPostCache.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 12/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
@testable import JsonPlaceholderTest

final class MockPostCache: PostRepository {
    
    var posts = [PostViewModel]()
    
    func save(post: PostViewModel) throws {
        posts.append(post)
    }
    
    func save(posts: [PostViewModel]) throws {
        self.posts += posts
    }
    
    func update(post: PostViewModel) throws {
        let index  = posts.firstIndex { $0.id == post.id }
        if let index = index {
            posts[index] = post
        }
    }
    
    func delete(post: PostViewModel) throws {
        let index  = posts.firstIndex { $0.id == post.id }
        if let index = index {
            posts.remove(at: index)
        }
    }
    
    func delete(posts: [PostViewModel]) throws {
        try posts.forEach { try delete(post: $0) }
    }
    
    func deleteAll() throws {
        posts.removeAll()
    }
    
    func retrievePosts() throws -> [PostViewModel] {
        return posts
    }
}
