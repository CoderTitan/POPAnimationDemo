//
//  BaseButton.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/16.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    
    override func awakeFromNib() {
        titleLabel?.textAlignment = .center
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //调整图片
        imageView?.frame.origin.x = 0
        imageView?.frame.origin.y = 0
        imageView?.frame.size.width = frame.width
        imageView?.frame.size.height = frame.width
        
        //调整文字
        titleLabel?.frame.origin.x = 0
        titleLabel?.frame.origin.y = imageView?.frame.height ?? 70
        titleLabel?.frame.size.width = frame.width
        titleLabel?.frame.size.height = frame.height - (titleLabel?.frame.minY ?? 70)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
