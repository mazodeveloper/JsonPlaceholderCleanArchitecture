//
//  StorePostProvider.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

protocol StorePostProvider {
    func store(posts: [PostViewModel]) throws
    func update(post: PostViewModel) throws
}
