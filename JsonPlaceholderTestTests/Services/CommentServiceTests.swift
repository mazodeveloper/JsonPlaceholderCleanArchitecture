//
//  CommentServiceTests.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderTest

class CommentServiceTests: XCTestCase {

    var service: CommentServiceAdapter?
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testFetchComments() {
        let mockComment = Comment(id: 1, email: "author.com", body: "comment description")
        guard let data = try? JSONEncoder().encode([mockComment]) else {
            return XCTFail("The encode process should be successful")
        }
        
        let mockBaseService = MockBaseService(result: .success(response: data))
        let mockURLGenerator = MockURLGenerator()
        service = CommentServiceAdapter(baseService: mockBaseService, urlGenerator: mockURLGenerator)
        
        let expectation = self.expectation(description: "promise response")
        var comment: [Comment]?
        var error: Error?
        service?.fetchComments(by: "\(1)") { (response) in
            switch response {
            case .failure(let err):
                error = err
            case .success(let object):
                comment = object
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (_) in
            XCTAssertNil(error, "if the response was successful, the error should be nil")
            XCTAssertNotNil(comment, "if the response was successful, the comment shouldn't be nil")
        }
    }
}
