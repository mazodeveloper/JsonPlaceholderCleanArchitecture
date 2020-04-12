//
//  PostsViewController.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

final class PostsViewController: UIViewController {
    
    var presenter: PostPresentation?
    
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var deleteButton: UIButton!
    lazy var loader: CustomLoader = {
        let loader = CustomLoader()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.containerView.backgroundColor = .clear
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.visibleCells.forEach {
            let cell = $0 as? PostTableViewCell
            guard let index = tableView.indexPath(for: $0),
                let post = presenter?.posts[index.row] else { return }
            cell?.post = post
            if segmentedControl.selectedSegmentIndex == 1, !post.isFavorite {
                presenter?.posts.remove(at: index.row)
                tableView.deleteRows(at: [index], with: .fade)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == SeguesId.fromPostsToPostDetails.rawValue,
            let destination = segue.destination as? PostDetailsViewController, let indexPath = sender as? IndexPath else { return }
        
        destination.post = presenter?.posts[indexPath.row]
    }
    
    private func setup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.alpha = 0.0
        segmentedControl.alpha = 0.0
        presenter = PostPresenter(view: self)
        
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.widthAnchor.constraint(equalToConstant: 300),
            loader.heightAnchor.constraint(equalToConstant: 300),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        loader.startAnimation()
        presenter?.retrievePosts()
    }
    
    
    @IBAction func SegmentValueChanged(_ sender: Any) {
        presenter?.filterPosts(favorites: segmentedControl.selectedSegmentIndex == 1)
        tableView.reloadData()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        presenter?.removePosts()
        reloadButton.isEnabled = true
        tableView.reloadData()
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 1 {
            segmentedControl.selectedSegmentIndex = 0
        }
        presenter?.reloadPosts()
        tableView.reloadData()
        animateCells()
        
        reloadButton.isEnabled = false
    }
}

// MARK: Presenter delegate
extension PostsViewController: PresenterViewProtocol {
    func updateUI() {
        tableView.reloadData()
        loader.stopAnimation()
        UIView.animate(withDuration: 0.4) {
            self.loader.alpha = 0.0
            self.tableView.alpha = 1.0
            self.segmentedControl.alpha = 1.0
            self.deleteButton.alpha = 1.0
        }
    }
    
    func display(error: Error) {
        loader.stopAnimation()
        UIView.animate(withDuration: 0.4, animations: {
            self.loader.alpha = 0.0
            self.tableView.alpha = 1.0
            self.segmentedControl.alpha = 1.0
            self.deleteButton.alpha = 1.0
        }, completion: { (_) in
            self.presentAlert(error: error)
        })
    }
}
