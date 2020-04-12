//
//  PostCache.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
import RealmSwift

protocol PostRepository {
    func save(post: PostViewModel) throws
    func save(posts: [PostViewModel]) throws
    func update(post: PostViewModel) throws
    func delete(post: PostViewModel) throws
    func delete(posts: [PostViewModel]) throws
    func deleteAll() throws
    func retrievePosts() throws -> [PostViewModel]
}

typealias PostDatabase = RealmDatabase<RealmPost>

final class PostCache: Repository<PostDatabase, RealmPostMapper>, PostRepository {
    
    init() {
        super.init(database: PostDatabase(), mapper: RealmPostMapper())
    }
    
    func save(post: PostViewModel) throws {
        try super.add(object: post)
    }
    
    func save(posts: [PostViewModel]) throws {
        try super.add(objects: posts)
    }
    
    func update(post: PostViewModel) throws {
        try super.update(object: post)
    }
    
    func delete(post: PostViewModel) throws {
        try super.delete(object: post)
    }
    
    func delete(posts: [PostViewModel]) throws {
        try super.delete(objects: posts)
    }
    
    override func deleteAll() throws {
        try super.deleteAll()
    }
    
    func retrievePosts() throws -> [PostViewModel] {
        return try super.objects()
    }
}
