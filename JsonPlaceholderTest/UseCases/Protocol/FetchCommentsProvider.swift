//
//  FetchCommentsProvider.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

protocol FetchCommentsProvider {
    func fetchComments(by postId: String, completion: @escaping (ServiceResponse<[Comment]>) -> Void)
}
