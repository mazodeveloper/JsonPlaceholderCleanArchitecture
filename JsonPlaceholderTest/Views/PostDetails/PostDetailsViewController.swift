//
//  PostDetailsViewController.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

final class PostDetailsViewController: UIViewController {
    
    var post: PostViewModel?
    var presenter: PostDetailsPresentation?
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    lazy var loader: CustomLoader = {
        let loader = CustomLoader()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.containerView.backgroundColor = .clear
        return loader
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updatePostStatus()
    }
    
    private func setup() {
        tableView.alpha = 0.0
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.widthAnchor.constraint(equalToConstant: 300),
            loader.heightAnchor.constraint(equalToConstant: 300),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        presenter = PostDetailsPresenter(view: self)
        guard let post = post else { return }
        
        loader.startAnimation()
        presenter?.retrievePostDetails(post: post)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let post = post else { return }
        post.isFavorite = !post.isFavorite
        presenter?.updatePost(post)
        updatePostStatus()
    }
    
    private func updatePostStatus() {
        guard let post = post else { return }
        let image = UIImage(systemName: post.isFavorite ? "star.fill" : "star")
        favoriteButton.image = image
    }
}

// MARK: Presenter delegate
extension PostDetailsViewController: PresenterViewProtocol {
    func updateUI() {
        tableView.reloadData()
        loader.stopAnimation()
        UIView.animate(withDuration: 0.4) {
            self.loader.alpha = 0.0
            self.tableView.alpha = 1.0
        }
        post?.isNew = false
    }
    
    func display(error: Error) {
        loader.stopAnimation()
        UIView.animate(withDuration: 0.4, animations: {
            self.loader.alpha = 0.0
            self.tableView.alpha = 1.0
        }, completion: { (_) in
            self.presentAlert(error: error)
        })
    }
}

// MARK: UITableView DataSource and Delegate
extension PostDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return presenter?.comments.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailsTableViewCell.cellIdentifier, for: indexPath) as? PostDetailsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.post = post
            cell.user = presenter?.user
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.cellIdentifier, for: indexPath) as? CommentTableViewCell else {
                return UITableViewCell()
            }
            
            cell.comment = presenter?.comments[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }
        
        return CommentSectionHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 1 else { return 0.0 }
        return 40.0
    }
}
