//
//  WeiBoViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/14.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

class WeiBoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "微博动画"
        
    }

    @IBAction func publishAction(_ sender: Any) {
        let publishV = PublishView.loadFromNib()
        guard let window = UIApplication.shared.keyWindow else { return }
        publishV.frame = window.bounds
        window.addSubview(publishV)
    }

}
