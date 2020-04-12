//
//  RetrievePostDetailsAdapter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

final class RetrievePostDetailsAdapter: RetrievePostDetailsProvider {
    
    let fetchCommentsUseCase: FetchCommentsProvider
    let fetchUserUseCase: FetchUserProvider
    
    init(fetchCommentsUseCase: FetchCommentsProvider = FetchCommentsAdapter(),
         fetchUserUseCase: FetchUserProvider = FetchUserAdapter()) {
        self.fetchCommentsUseCase = fetchCommentsUseCase
        self.fetchUserUseCase = fetchUserUseCase
    }
    
    func execute(postId: String, userId: String, completion: @escaping InitialDataClosure) {
        let dispatchGroup = DispatchGroup()
        var comments = [Comment]()
        var currentUser: User?
        
        dispatchGroup.enter()
        fetchCommentsUseCase.fetchComments(by: postId) { (response) in
            switch response {
            case .failure(let error):
                completion(.failure(error: error))
            case .success(let arrayComments):
                comments = arrayComments
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchUserUseCase.fetchUser(by: userId) { (response) in
            switch response {
            case .failure(let error):
                completion(.failure(error: error))
            case .success(let user):
                currentUser = user
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(response: (currentUser, comments)))
        }
    }
}
