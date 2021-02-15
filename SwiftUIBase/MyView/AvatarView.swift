//
//  AvatarView.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 09.02.2021.
//

import UIKit

@IBDesignable
class AvatarView: UIView {
    
    @IBOutlet var imageView: UIImageView! {
        didSet {
            self.imageView.layer.cornerRadius = cornerRadius
            self.imageView.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
//            self.imageView.layer.cornerRadius = cornerRadius
//            self.imageView.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.3
            self.layer.shadowOffset = shadowOffset
        }
    }
    
}
