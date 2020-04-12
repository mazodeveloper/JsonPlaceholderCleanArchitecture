//
//  RealmDatabase.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
import RealmSwift

protocol Database {
    associatedtype DatabaseModel
    
    func add(object: DatabaseModel) throws
    func add(objects: [DatabaseModel]) throws
    func update(object: DatabaseModel) throws
    func delete(object: DatabaseModel) throws
    func deleteObjects(objects: [DatabaseModel]) throws
    func deleteAll() throws
    func objects(type: DatabaseModel.Type) throws -> [DatabaseModel]
}

class RealmDatabase<RealmObject: Object>: Database {
    
    func add(object: RealmObject) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(object)
        }
    }
    
    func add(objects: [RealmObject]) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func update(object: RealmObject) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func delete(object: RealmObject) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteObjects(objects: [RealmObject]) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(objects)
        }
    }
    
    func deleteAll() throws {
        let realm = try Realm()
        try realm.write {
            realm.deleteAll()
        }
    }
    
    func objects(type: RealmObject.Type) throws -> [RealmObject] {
        let realm = try Realm()
        return Array(realm.objects(type))
    }
}
