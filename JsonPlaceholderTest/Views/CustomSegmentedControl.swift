//
//  CustomSegmentedControl.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 10/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

final class CustomSegmentedControl: UISegmentedControl {
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.systemGreen.cgColor
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGreen], for: .normal)
        backgroundColor = .white
    }
}
