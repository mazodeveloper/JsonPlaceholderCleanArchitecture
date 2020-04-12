//
//  PostDetailsPresenter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

protocol PostDetailsPresentation {
    var user: User? { get set }
    var comments: [Comment] { get set }
    func retrievePostDetails(post: PostViewModel)
    func updatePost(_ post: PostViewModel)
}

final class PostDetailsPresenter: PostDetailsPresentation {
    
    var user: User?
    var comments: [Comment] = []
    let retrievePostDetailsUseCase: RetrievePostDetailsProvider
    let storePostUseCase: StorePostProvider
    weak var view: PresenterViewProtocol?
    
    init(retrievePostDetailsUseCase: RetrievePostDetailsProvider = RetrievePostDetailsAdapter(),
         storePostUseCase: StorePostProvider = StorePostAdapter(),
         view: PresenterViewProtocol? = nil) {
        self.retrievePostDetailsUseCase = retrievePostDetailsUseCase
        self.storePostUseCase = storePostUseCase
        self.view = view
    }
    
    func retrievePostDetails(post: PostViewModel) {
        retrievePostDetailsUseCase.execute(postId: "\(post.id)", userId: "\(post.userId)") { [weak self] (response) in
            DispatchQueue.main.async {
                switch response {
                case .failure(let error):
                    self?.view?.display(error: error)
                case .success(let response):
                    self?.handleSuccess(response: response, post: post)
                }
            }
        }
    }
    
    func updatePost(_ post: PostViewModel) {
        do {
            try storePostUseCase.update(post: post)
        } catch {
            view?.display(error: AppError.cache(error: error))
        }
    }
    
    private func handleSuccess(response: (user: User?, comments: [Comment]), post: PostViewModel) {
        user = response.user
        comments = response.comments
        if post.isNew {
            post.isNew = false
            do {
                try storePostUseCase.update(post: post)
            } catch {
                view?.display(error: AppError.cache(error: error))
            }
        }
        view?.updateUI()
    }
}
