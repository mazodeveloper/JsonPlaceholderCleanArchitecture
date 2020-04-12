//
//  PostServiceAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class PostServiceAdapter: PostService {
    
    let baseService: BaseService
    let urlGenerator: URLGenerable
    
    init(baseService: BaseService = WebService(),
         urlGenerator: URLGenerable = PlaceHolderEndpoint()) {
        self.baseService = baseService
        self.urlGenerator = urlGenerator
    }
    
    func fetchPosts(completion: @escaping (ServiceResponse<[Post]>) -> Void) {
        let url = urlGenerator.getUrl(for: .posts)
        baseService.callEndpoint(responseType: [Post].self, url: url, completion: completion)
    }
}
