//
//  LikeControl.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 13.02.2021.
//

import UIKit

final class LikeControl: UIControl {
      
    let likesCounterLabel = UILabel()
    let likeImage = UIImageView()
    
    var likedByMe: Bool = false
    var likeCounter: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.likeImage)
        self.addSubview(likesCounterLabel)
        
        if likedByMe {
            self.likeImage.image = UIImage(systemName: "heart.fill")
        }
        else {
            self.likeImage.image = UIImage(systemName: "heart")
        }
        self.likesCounterLabel.text = "\(likeCounter)"
        
        self.likeImage.translatesAutoresizingMaskIntoConstraints = false
        self.likeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.likeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.likeImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        self.likesCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.likesCounterLabel.leadingAnchor.constraint(equalTo: self.likeImage.trailingAnchor, constant: 5).isActive = true
        self.likesCounterLabel.centerYAnchor.constraint(equalTo: self.likeImage.centerYAnchor).isActive = true
        self.likesCounterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted != oldValue {
                self.likeImage.alpha = self.isHighlighted ? 0.7 : 1
            }
        }
    }
    
    func onTap() {
        likedByMe = !likedByMe

        if likedByMe {
            unlike()
        } else {
            like()
        }
    }
    
    private func like () {
        likeImage.image = UIImage(systemName: "heart.fill")
        likeCounter += 1
        likesCounterLabel.text = "\(likeCounter)"
        
    }
    private func unlike () {
        likeImage.image = UIImage(systemName: "heart")
        likeCounter -= 1
        likesCounterLabel.text = "\(likeCounter)"
    }
    
}
