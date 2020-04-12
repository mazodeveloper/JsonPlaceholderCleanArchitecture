//
//  RetrievePostDetailsProvider.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

typealias InitialDataClosure = (ServiceResponse<(user: User?, comments: [Comment])>) -> Void

protocol RetrievePostDetailsProvider {
    func execute(postId: String, userId: String, completion: @escaping InitialDataClosure)
}
