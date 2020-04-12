//
//  RealmPostMapper.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPostMapper: DatabaseMapper {
    typealias Model = PostViewModel
    typealias DatabaseModel = RealmPost
    
    func mapToDomain(from databaseObject: RealmPost) -> PostViewModel {
        return PostViewModel(userId: databaseObject.userId,
                             id: databaseObject.id,
                             title: databaseObject.title,
                             body: databaseObject.body,
                             isNew: databaseObject.isNew,
                             isFavorite: databaseObject.isFavorite)
    }
    
    func mapToDatabase(from domainObject: PostViewModel) -> RealmPost {
        return RealmPost(id: domainObject.id,
                         userId: domainObject.userId,
                         title: domainObject.title,
                         body: domainObject.body,
                         isNew: domainObject.isNew,
                         isFavorite: domainObject.isFavorite)
    }
}
