//
//  CommentSectionHeader.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

final class CommentSectionHeader: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Bold", size: 19)
        label.textColor = .white
        label.text = "Comments 💬"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        backgroundColor = .systemGreen
        addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
