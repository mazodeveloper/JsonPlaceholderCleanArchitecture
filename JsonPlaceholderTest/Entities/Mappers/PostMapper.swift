//
//  PostMapper.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class PostMapper {
    func map(post: Post, isNew: Bool = false) -> PostViewModel {
        return PostViewModel(userId: post.userId,
                             id: post.id,
                             title: post.title,
                             body: post.body,
                             isNew: isNew,
                             isFavorite: false)
    }
}
