//
//  LikeView.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/17.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

class LikeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        animationLikeGameCenterBubble()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animationLikeGameCenterBubble()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
