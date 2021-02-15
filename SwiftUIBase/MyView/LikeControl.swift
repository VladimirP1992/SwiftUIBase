//
//  LikeControl.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 13.02.2021.
//

import UIKit

final class LikeControl: UIControl {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var likesCounterLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    var likedByMe: Bool = false
    var likeCounter: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LikeControl", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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