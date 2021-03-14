//
//  ShareButton.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 28.02.2021.
//

import UIKit

final class ShareButton: UIControl {
      
    private var imageView: UIImageView!
    private var sharesCounterLabel: UILabel!
    
    private var shareImage =  UIImage(systemName: "arrowshape.turn.up.right")
    
    private var sharesCounter: Int = 0
    
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
        self.sharesCounterLabel = UILabel()
        self.sharesCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.sharesCounterLabel)
        //Like image
        self.imageView = UIImageView()
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.imageView.image = shareImage
        self.imageView.contentMode = .scaleAspectFit
        
        self.sharesCounterLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 2).isActive = true
        self.sharesCounterLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
        
        self.sharesCounterLabel.text = "\(sharesCounter)"
        
        self.addTarget(self, action: #selector(touchUpInside), for: .touchDown)
    }
    
    private func toShare(){
        sharesCounter += 1
        self.sharesCounterLabel.text = "\(sharesCounter)"
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted != oldValue {
                self.imageView.alpha = self.isHighlighted ? 0.7 : 1
            }
        }
    }
    
    @objc func touchUpInside() {
        toShare()
    }
}
