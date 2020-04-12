//
//  FetchPostsTests.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderTest

class FetchPostsTests: XCTestCase {

    var useCase: FetchPostsAdapter?
    
    override func setUp() {
        super.setUp()
        let posts = (0..<3).map { Post(userId: $0 + 1, id: $0 + 1, title: "post title", body: "post description") }
        let postService = MockPostService(result: ServiceResponse.success(response: posts))
        useCase = FetchPostsAdapter(postService: postService)
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func testFetchPosts() {
        let expectation = self.expectation(description: "promise response")
        var posts = [Post]()
        var error: Error?
        useCase?.execute(completion: { (response) in
            switch response {
            case .failure(let err):
                error = err
            case .success(let arrayPosts):
                posts = arrayPosts
            }
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5.0) { (_) in
            XCTAssertNil(error, "if the response was successful, the error should be nil")
            XCTAssertFalse(posts.isEmpty, "if the response was successful, the posts should have elements")
        }
    }
}
