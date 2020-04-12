//
//  StorePostTests.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 12/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderTest

class StorePostTests: XCTestCase {

    var useCase: StorePostAdapter?
    var mockCache: MockPostCache?
    
    override func setUp() {
        super.setUp()
        mockCache = MockPostCache()
        guard let cache = mockCache else { return }
        useCase = StorePostAdapter(postCache: cache)
    }

    override func tearDown() {
        useCase = nil
        mockCache = nil
        super.tearDown()
    }

    func testStorePosts() {
        let posts = (1...3).map { PostViewModel(userId: $0, id: $0, title: "Title \($0)", body: "Description \($0)", isNew: false, isFavorite: false) }
        var error: Error?
        
        do {
            try useCase?.store(posts: posts)
        } catch let err {
            error = err
        }
        
        guard let postsFromDB = try? mockCache?.retrievePosts() else {
            return XCTFail("The cache object should have values")
        }
        
        XCTAssertNil(error, "if the store process was successful, the error should be nil")
        XCTAssertEqual(posts.count, postsFromDB.count, "the posts from memory and DB must be the same")
    }
    
    func testUpdatePost() {
        let post = PostViewModel(userId: 1, id: 1, title: "Title 1", body: "Description 1", isNew: false, isFavorite: false)
        
        try? useCase?.store(posts: [post])
        post.isFavorite = true
        try? useCase?.update(post: post)
        
        guard let postFromDB = try? mockCache?.retrievePosts().first else {
            return XCTFail("The cache object should have values")
        }
        
        XCTAssertEqual(post.isFavorite, postFromDB.isFavorite, "If the update process was successful the posts must have the same values")
    }
}
