//
//  CommentButton.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 28.02.2021.
//

import UIKit

final class CommentButton: UIControl {
      
    private var imageView: UIImageView!
    private var commentsCounterLabel: UILabel!
    
    private var commentImage =  UIImage(systemName: "bubble.left")
    
    private var commentCounter: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        //Likes counter label
        self.commentsCounterLabel = UILabel()
        self.commentsCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.commentsCounterLabel)
        //Like image
        self.imageView = UIImageView()
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.imageView.image = commentImage
        self.imageView.contentMode = .scaleAspectFit
        
        self.commentsCounterLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 2).isActive = true
        self.commentsCounterLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
        
        self.commentsCounterLabel.text = "\(commentCounter)"
        
        self.addTarget(self, action: #selector(touchUpInside), for: .touchDown)
    }
    
    private func toComment(){
        commentCounter += 1
        self.commentsCounterLabel.text = "\(commentCounter)"
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted != oldValue {
                self.imageView.alpha = self.isHighlighted ? 0.7 : 1
            }
        }
    }
    
    @objc func touchUpInside() {
        toComment()
    }
}
