//
//  ActivityViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/14.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import pop

class ActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "活动指示器"
        
        //1. 创建复制图层
        let repLayer = CAReplicatorLayer()
        repLayer.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        repLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(repLayer)

        // 2. c创建CALayer
        let caLayer = CALayer()
        caLayer.position = CGPoint(x: 100, y: 20)
        caLayer.transform = CATransform3DMakeScale(0, 0, 0)
        caLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        caLayer.backgroundColor = UIColor.green.cgColor
        repLayer.addSublayer(caLayer)
        
        //3. 添加动画
        let cabasic = CABasicAnimation(keyPath: "transform.scale")
        cabasic.fromValue = 1
        cabasic.toValue = 0.1
        cabasic.duration = 1
        cabasic.repeatCount = HUGE
        caLayer.add(cabasic, forKey: "scale")
        
        //4. 复制图层属性
        repLayer.instanceCount = 20
        repLayer.instanceDelay = 1 / 20
        repLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(Double.pi) * 2 / 20, 0, 0, 1)

    }


}
