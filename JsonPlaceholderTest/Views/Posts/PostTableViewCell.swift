//
//  PostTableViewCell.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "PostCellID"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var post: PostViewModel? {
        didSet {
            guard let post = post else { return }
            titleLabel.text = post.title
            descriptionLabel.text = post.body
            setupStatus(post: post)
        }
    }
    
    private func setupStatus(post: PostViewModel) {
        let imageName = post.isNew ? "🔵" : post.isFavorite ? "⭐️" : ""
        status.text = imageName
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
