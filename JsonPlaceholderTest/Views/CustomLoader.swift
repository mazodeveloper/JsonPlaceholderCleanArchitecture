//
//  CustomLoader.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import UIKit

final class CustomLoader: UIView {
    
    @IBOutlet var containerView: UIView!
    private var labels = [UILabel]()
    private var isAnimating = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func startAnimation() {
        isAnimating = true
        rotation()
    }
    
    func stopAnimation() {
        isAnimating = false
    }
    
    private func setup() {
        let className = String(describing: type(of: self))
        Bundle.main.loadNibNamed(className, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        
        containerView.subviews.enumerated().forEach {
            guard let label = containerView.viewWithTag($0.offset + 1) as? UILabel else { return }
            labels.append(label)
        }
    }
    
    private func rotation(index: Int = 0) {
        
        guard isAnimating else { return }
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
            
            self.labels[index].transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
            self.labels[index].textColor = .black
            
        }, completion: { (_) -> Void in
            
            UIView.animate(withDuration: 0.05, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
                
                self.labels[index].transform = .identity
                self.labels[index].textColor = .systemGreen
                
            }, completion: { (_) -> Void in
                let index = index + 1
                if index < self.labels.count {
                    self.rotation(index: index)
                } else {
                    self.scale()
                }
            })
            
        })
    }
    
    private func scale() {
        UIView.animate(withDuration: 0.35, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.labels.forEach { $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5) }
        }, completion: { (_) -> Void in
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.labels.forEach { $0.transform = .identity }
            }, completion: { (_) -> Void in
                if self.isAnimating {
                    self.rotation()
                } else {
                    self.labels.forEach { $0.transform = .identity; $0.textColor = .black }
                }
            })
            
        })
    }
}
