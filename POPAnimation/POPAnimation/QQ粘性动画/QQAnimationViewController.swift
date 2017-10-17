//
//  QQAnimationViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/16.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

class QQAnimationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let pointBtn = PointButton(frame: CGRect(x: kScreenWidth / 2 - 50, y: 150, width: 20, height: 20))
        view.addSubview(pointBtn)
        pointBtn.reloadViews()
        
        
    }
}
