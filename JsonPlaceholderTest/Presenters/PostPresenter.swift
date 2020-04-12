//
//  PostPresenter.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

protocol PostPresentation {
    var posts: [PostViewModel] { get set }
    func retrievePosts()
    func removePost(at row: Int)
    func filterPosts(favorites: Bool)
    func removePosts()
    func reloadPosts()
}

final class PostPresenter: PostPresentation {
    var posts: [PostViewModel] = []
    var originalPosts: [PostViewModel] = []
    let fetchPostsUseCase: FetchPostsProvider
    let storePostUseCase: StorePostProvider
    let loadPostsUseCase: LoadPostsProvider
    weak var view: PresenterViewProtocol?
    let postMapper: PostMapper
    
    init(fetchPostsUseCase: FetchPostsProvider = FetchPostsAdapter(),
         storePostUseCase: StorePostProvider = StorePostAdapter(),
         loadPostsUseCase: LoadPostsProvider = LoadPostsAdapter(),
         postMapper: PostMapper = PostMapper(),
         view: PresenterViewProtocol? = nil) {
        self.fetchPostsUseCase = fetchPostsUseCase
        self.storePostUseCase = storePostUseCase
        self.loadPostsUseCase = loadPostsUseCase
        self.postMapper = postMapper
        self.view = view
    }
    
    func removePost(at row: Int) {
        posts.remove(at: row)
        originalPosts.remove(at: row)
    }
    
    func filterPosts(favorites: Bool) {
        if favorites {
            posts = originalPosts.filter { $0.isFavorite }
        } else {
            posts = originalPosts
        }
    }
    
    func removePosts() {
        posts.removeAll()
        originalPosts.removeAll()
    }
    
    func reloadPosts() {
        do {
            originalPosts = try loadPostsUseCase.execute()
            posts = originalPosts
        } catch {
            view?.display(error: AppError.cache(error: error))
        }
    }
    
    func retrievePosts() {
        fetchPostsUseCase.execute { [weak self] (response) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .failure(let error):
                    self.view?.display(error: error)
                case .success(let posts):
                    self.handleSuccess(posts: posts)
                }
            }
        }
    }
    
    private func handleSuccess(posts: [Post]) {
        self.posts = posts.enumerated().map {
            let isNew = $0.offset < 20 ? true : false
            return postMapper.map(post: $0.element, isNew: isNew)
        }
        do {
            try storePostUseCase.store(posts: self.posts)
        } catch {
            view?.display(error: AppError.cache(error: error))
        }
        originalPosts = self.posts
        view?.updateUI()
    }
}
