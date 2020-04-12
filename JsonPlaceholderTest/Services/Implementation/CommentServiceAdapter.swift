//
//  CommentServiceAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class CommentServiceAdapter: CommentService {
    let baseService: BaseService
    let urlGenerator: URLGenerable
    
    init(baseService: BaseService = WebService(),
         urlGenerator: URLGenerable = PlaceHolderEndpoint()) {
        self.baseService = baseService
        self.urlGenerator = urlGenerator
    }
    
    func fetchComments(by postId: String, completion: @escaping (ServiceResponse<[Comment]>) -> Void) {
        let url = urlGenerator.getUrl(for: .comments(postId: postId))
        baseService.callEndpoint(responseType: [Comment].self, url: url, completion: completion)
    }
}
