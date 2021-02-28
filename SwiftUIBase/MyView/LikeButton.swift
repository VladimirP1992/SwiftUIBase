//
//  LikeControl.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 13.02.2021.
//

import UIKit

final class LikeButton: UIControl {
      
    private var imageView: UIImageView!
    private var likesCounterLabel: UILabel!
    
    private var heartImage: UIImage {
        return likedByMe ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
    }
    
    private var likeCounter: Int = 0
    private var likedByMe: Bool = false {
        didSet{
            imageView.image = heartImage
            oldValue ? unlike() : like()
        }
    }
    
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
        self.likesCounterLabel = UILabel()
        self.likesCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.likesCounterLabel)
        //Like image
        self.imageView = UIImageView()
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.imageView.image = heartImage
        self.imageView.contentMode = .scaleAspectFit
        
        self.likesCounterLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 2).isActive = true
        self.likesCounterLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
        
        self.likesCounterLabel.text = "\(likeCounter)"
        
        self.addTarget(self, action: #selector(touchUpInside), for: .touchDown)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted != oldValue {
                self.imageView.alpha = self.isHighlighted ? 0.7 : 1
            }
        }
    }
    
    @objc func touchUpInside() {
        likedByMe.toggle()
    }
    
    private func like () {
        likeCounter += 1
        self.likesCounterLabel.text = "\(likeCounter)"
        
    }
    private func unlike () {
        likeCounter -= 1
        self.likesCounterLabel.text = "\(likeCounter)"
    }
    
}
