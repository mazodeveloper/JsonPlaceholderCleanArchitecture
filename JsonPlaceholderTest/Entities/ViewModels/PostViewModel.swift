//
//  PostViewModel.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class PostViewModel {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    var isNew: Bool
    var isFavorite: Bool
    
    init(userId: Int, id: Int, title: String, body: String, isNew: Bool, isFavorite: Bool) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.isNew = isNew
        self.isFavorite = isFavorite
    }
}
