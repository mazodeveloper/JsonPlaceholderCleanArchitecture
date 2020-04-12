//
//  RealmPost.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class RealmPost: Object {
    dynamic var id: Int = 0
    dynamic var userId: Int = 0
    dynamic var title = String()
    dynamic var body = String()
    dynamic var isNew: Bool = false
    dynamic var isFavorite: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int,
                     userId: Int,
                     title: String,
                     body: String,
                     isNew: Bool,
                     isFavorite: Bool) {
        self.init()
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
        self.isNew = isNew
        self.isFavorite = isFavorite
    }
}
