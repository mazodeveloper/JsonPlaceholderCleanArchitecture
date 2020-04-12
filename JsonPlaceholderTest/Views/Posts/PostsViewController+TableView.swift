//
//  PostsViewController+TableView.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

// MARK: UITableView DataSource and Delegate
extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.post = presenter?.posts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(.fromPostsToPostDetails, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            self?.presenter?.removePost(at: indexPath.row)
            self?.reloadButton.isEnabled = true
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "trash", withConfiguration: config)
        
        action.image = image
        action.backgroundColor = .red
        
        return action
    }
    
    func animateCells() {
        tableView.visibleCells.forEach { $0.transform = CGAffineTransform(translationX: view.frame.width, y: 0) }
        var delay = 0.3
        tableView.visibleCells.forEach { cell in
            UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = .identity
            })
            
            delay = 0.1
        }
    }
}
