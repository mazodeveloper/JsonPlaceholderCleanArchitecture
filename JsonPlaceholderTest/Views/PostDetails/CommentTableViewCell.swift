//
//  CommentTableViewCell.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

final class CommentTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "CommentCellID"
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var comment: Comment? {
        didSet {
            guard let comment = comment else { return }
            authorLabel.text = comment.email
            commentLabel.text = comment.body
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CommentTableViewCell.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
