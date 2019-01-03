//
//  VolumeViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/14.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import pop

class VolumeViewController: UIViewController {

    @IBOutlet weak var lightView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "音量震动条"

        // CAReplicatorLayer复制图层，可以把图层里面所有子层复制
        //1. 创建复制图层
        let repLayer = CAReplicatorLayer()
        repLayer.frame = lightView.bounds
        lightView.layer.addSublayer(repLayer)

        // instanceCount：表示复制层里面有多少个子层，包括原始层
        //设置4个子层，3个复制层
        repLayer.instanceCount = 4
        
        // 设置复制子层偏移量，不包括原始层,相对于原始层x偏移
        repLayer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0)
        
        // 设置复制层动画延迟时间
        repLayer.instanceDelay = 0.3
        
        // 如果设置了原始层背景色，就不需要设置这个属性
//        repLayer.instanceColor = UIColor.green.cgColor
        
        
        // 2. c创建CALayer
        let caLayer = CALayer()
        caLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        caLayer.position = CGPoint(x: 15, y: lightView.bounds.height)
        caLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 150)
        caLayer.backgroundColor = UIColor.red.cgColor
        repLayer.addSublayer(caLayer)
        
        //3. 动画        
        let basic = CABasicAnimation(keyPath: "transform.scale.y")
        basic.toValue = 0.1
        basic.duration = 0.6
        //动画翻转
        basic.autoreverses = true
        basic.repeatCount = HUGE
        caLayer.add(basic, forKey: "jing")
        
    }


}
