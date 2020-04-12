//
//  URLGenerable.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

enum Endpoint {
    case posts
    case post(id: String)
    case user(id: String)
    case comments(postId: String)
}

protocol URLGenerable {
    var baseUrl: String { get set }
    func getUrl(for endpoint: Endpoint) -> URL?
}

struct PlaceHolderEndpoint: URLGenerable {
    var baseUrl = "https://jsonplaceholder.typicode.com/"
    
    func getUrl(for endpoint: Endpoint) -> URL? {
        var path = baseUrl
        
        switch endpoint {
        case .posts:
            path.append("posts")
        case .post(let id):
            path.append("posts/\(id)")
        case .user(let id):
            path.append("users/\(id)")
        case .comments(let postId):
            path.append("comments?postId=\(postId)")
        }
        
        return URL(string: path)
    }
}
