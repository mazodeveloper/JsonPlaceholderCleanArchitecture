//
//  FetchUserTests.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderTest

class FetchUserTests: XCTestCase {

    var useCase: FetchUserAdapter?
    
    override func setUp() {
        super.setUp()
        let user = User(id: 1, name: "Hannah", email: "Hannah@gmail.com", phone: "3543432", website: "Hannah.com")
        let mockService = MockUserService(result: .success(response: user))
        useCase = FetchUserAdapter(userService: mockService)
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func testFetchUser() {
        let expectation = self.expectation(description: "promise response")
        var user: User?
        var error: Error?
        useCase?.fetchUser(by: "\(1)") { (response) in
            switch response {
            case .failure(let err):
                error = err
            case .success(let result):
                user = result
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (_) in
            XCTAssertNil(error, "if the response was successful, the error should be nil")
            XCTAssertNotNil(user, "if the response was successful, the user must have data")
        }
    }

    func testFetchUserWrongId() {
        let expectation = self.expectation(description: "promise response")
        var user: User?
        var error: Error?
        useCase?.fetchUser(by: "\(2)") { (response) in
            switch response {
            case .failure(let err):
                error = err
            case .success(let result):
                user = result
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (_) in
            XCTAssertNotNil(error, "if the response failed, the error must have a value")
            XCTAssertNil(user, "if the response failed, the user should be nil")
        }
    }
}
