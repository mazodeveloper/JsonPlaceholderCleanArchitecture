//
//  RepositoryTests.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 12/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import XCTest
import RealmSwift
@testable import JsonPlaceholderTest

class RepositoryTests: XCTestCase {

    var repository: Repository<PostDatabase, RealmPostMapper>?
    
    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = name
        repository = Repository(database: PostDatabase(), mapper: RealmPostMapper())
    }

    override func tearDown() {
        try? repository?.deleteAll()
        repository = nil
        super.tearDown()
    }

    func testSaveObject() {
        let post = PostViewModel(userId: 1, id: 1, title: "Title 1", body: "Description 1", isNew: false, isFavorite: false)
        
        try? repository?.add(object: post)
        guard let postsFromDB = try? repository?.objects() else {
            return XCTFail("The cache object should have values")
        }
        
        XCTAssertFalse(postsFromDB.isEmpty, "The posts from Database shouldn't be empty.")
    }
    
    func testSaveObjects() {
        let posts = (1...3).map { PostViewModel(userId: $0, id: $0, title: "Title \($0)", body: "Description \($0)", isNew: false, isFavorite: false) }
        
        try? repository?.add(objects: posts)
        guard let postsFromDB = try? repository?.objects() else {
            return XCTFail("The cache object should have values")
        }
        
        XCTAssertFalse(postsFromDB.isEmpty, "The posts from Database shouldn't be empty.")
    }
    
    func testUpdateObject() {
        let post = PostViewModel(userId: 1, id: 1, title: "Title 1", body: "Description 1", isNew: false, isFavorite: false)
        
        try? repository?.add(object: post)
        post.isFavorite = true
        try? repository?.update(object: post)
        
        guard let postFromDB = try? repository?.objects().first else {
            return XCTFail("The cache object should have values")
        }
        
        XCTAssertEqual(post.isFavorite, postFromDB.isFavorite, "If the update process was successful the posts must have the same values")
    }
}
