//
//  PostDetailsTableViewCell.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

final class PostDetailsTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "PostDetailsCellID"
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stackUserContainer: UIStackView!
    @IBOutlet weak var userTitleLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var post: PostViewModel? {
        didSet {
            guard let post = post else { return }
            descriptionLabel.text = post.body
        }
    }
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            nameLabel.text = user.name
            emailLabel.text = user.email
            phoneLabel.text = user.phone
            websiteLabel.text = user.website
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: PostDetailsTableViewCell.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
