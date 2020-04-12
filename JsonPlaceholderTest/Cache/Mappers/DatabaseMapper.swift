//
//  DatabaseMapper.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

protocol DatabaseMapper {
    associatedtype Model
    associatedtype DatabaseModel
    
    func mapToDomain(from databaseObject: DatabaseModel) -> Model
    func mapToDatabase(from domainObject: Model) -> DatabaseModel
}
