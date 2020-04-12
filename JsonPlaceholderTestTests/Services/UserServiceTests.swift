//
//  UserServiceTests.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderTest

class UserServiceTests: XCTestCase {

    var service: UserServiceAdapter?
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testFetchUser() {
        let mockUser = User(id: 1, name: "Chris", email: "chris@gmail.com", phone: "436554", website: "Chris.com")
        guard let data = try? JSONEncoder().encode(mockUser) else {
            return XCTFail("The encode process should be successful")
        }
        
        let mockBaseService = MockBaseService(result: .success(response: data))
        let mockURLGenerator = MockURLGenerator()
        service = UserServiceAdapter(baseService: mockBaseService, urlGenerator: mockURLGenerator)
        
        let expectation = self.expectation(description: "promise response")
        var user: User?
        var error: Error?
        service?.fetchUser(by: "\(1)") { (response) in
            switch response {
            case .failure(let err):
                error = err
            case .success(let object):
                user = object
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (_) in
            XCTAssertNil(error, "if the response was successful, the error should be nil")
            XCTAssertNotNil(user, "if the response was successful, the user shouldn't be nil")
        }
    }
}
