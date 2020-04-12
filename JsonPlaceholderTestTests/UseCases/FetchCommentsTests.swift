//
//  FetchCommentsTests.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderTest

class FetchCommentsTests: XCTestCase {

    var useCase: FetchCommentsAdapter?
    
    override func setUp() {
        super.setUp()
        let comments = (0..<3).map { Comment(id: $0 + 1, email: "random@gmail.com", body: "random message") }
        let commentService = MockCommentService(result: ServiceResponse.success(response: comments))
        useCase = FetchCommentsAdapter(commentService: commentService)
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func testFetchComments() {
        let expectation = self.expectation(description: "promise response")
        var comments = [Comment]()
        var error: Error?
        useCase?.fetchComments(by: "\(1)") { (response) in
            switch response {
            case .failure(let err):
                error = err
            case .success(let arrayComments):
                comments = arrayComments
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (_) in
            XCTAssertNil(error, "if the response was successful, the error should be nil")
            XCTAssertFalse(comments.isEmpty, "if the response was successful, the comments should have elements")
        }
    }
}

