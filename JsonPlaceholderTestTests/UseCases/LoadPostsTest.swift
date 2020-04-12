//
//  LoadPostsTest.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 12/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderTest

class LoadPostsTests: XCTestCase {

    var useCase: LoadPostsAdapter?
    var mockCache: MockPostCache?
    
    override func setUp() {
        super.setUp()
        mockCache = MockPostCache()
        guard let cache = mockCache else { return }
        useCase = LoadPostsAdapter(postCache: cache)
    }

    override func tearDown() {
        useCase = nil
        mockCache = nil
        super.tearDown()
    }

    func testLoadPosts() {
        let posts = (1...3).map { PostViewModel(userId: $0, id: $0, title: "Title \($0)", body: "Description \($0)", isNew: false, isFavorite: false) }
        
        try? mockCache?.save(posts: posts)
        
        var postsFromDB = [PostViewModel]()
        var error: Error?
        
        do {
            postsFromDB = try (useCase?.execute() ?? [])
        } catch let err {
            error = err
        }
        
        XCTAssertNil(error, "if the retrieve process was successful, the error should be nil")
        XCTAssertEqual(posts.count, postsFromDB.count, "the posts from memory and DB must be the same")
    }
}

