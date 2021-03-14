//
//  ViewingCounterControl.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 28.02.2021.
//

import UIKit

final class ViewingCounterView: UIView {
      
    private var imageView: UIImageView!
    private var viewingCounterLabel: UILabel!
    
    private var viewingImage =  UIImage(systemName: "eye.fill")
    
    private var viewingCounter: Int = 0
    
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
        self.viewingCounterLabel = UILabel()
        self.viewingCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.viewingCounterLabel)
        //Like image
        self.imageView = UIImageView()
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.imageView.image = viewingImage
        self.imageView.contentMode = .scaleAspectFit
        
        self.viewingCounterLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 2).isActive = true
        self.viewingCounterLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
        
        self.viewingCounterLabel.text = "\(viewingCounter)"
        
        //Some logic to count viewings
        viewing()
    }
    
    private func viewing(){
        viewingCounter += 1
        self.viewingCounterLabel.text = "\(viewingCounter)"
    }
}
