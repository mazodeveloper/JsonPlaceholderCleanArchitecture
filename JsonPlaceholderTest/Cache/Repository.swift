//
//  Repository.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

class Repository<DB: Database, Mapper: DatabaseMapper> where DB.DatabaseModel == Mapper.DatabaseModel {

    let database: DB
    let mapper: Mapper
    
    init(database: DB, mapper: Mapper) {
        self.database = database
        self.mapper = mapper
    }
    
    func add(object: Mapper.Model) throws {
        try database.add(object: mapper.mapToDatabase(from: object))
    }
    
    func add(objects: [Mapper.Model]) throws {
        try database.add(objects: objects.map { mapper.mapToDatabase(from: $0) })
    }
       
    func update(object: Mapper.Model) throws {
        try database.update(object: mapper.mapToDatabase(from: object))
    }
    
    func delete(object: Mapper.Model) throws {
        try database.delete(object: mapper.mapToDatabase(from: object))
    }
    
    func delete(objects: [Mapper.Model]) throws {
        try database.deleteObjects(objects: objects.map { mapper.mapToDatabase(from: $0) })
    }
    
    func deleteAll() throws {
        try database.deleteAll()
    }
    
    func objects() throws -> [Mapper.Model] {
        let objects = try database.objects(type: Mapper.DatabaseModel.self)
        return objects.map { mapper.mapToDomain(from: $0) }
    }
}
