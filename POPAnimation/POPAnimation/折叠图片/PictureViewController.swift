//
//  PictureViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/14.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import pop

class PictureViewController: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var dragVIew: UIView!

    // 渐变图层
    fileprivate var gradLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 一张图片必须要通过两个控件展示，旋转的时候，只旋转上部分控件
        
        //0. 通过设置contentsRect可以设置图片显示的尺寸，取值0~1
        topImage.layer.contentsRect = CGRect(x: 0, y: 0, width: 1, height: 0.5)
        topImage.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        bottomImage.layer.contentsRect = CGRect(x: 0, y: 0.5, width: 1, height: 0.5)
        bottomImage.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        // 1. 添加手势
        dragVIew.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panAction(pan:))))
        
        //2. 渐变图层
        //尺寸
        gradLayer.frame = bottomImage.bounds
        //这个属性是调协渐变层的不透明度.它的取值范围同样也是0-1,
        //当为0时代表透明, 当为1明,代码不透明
        gradLayer.opacity = 0
        //渐变颜色
        gradLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        
        //3. 添加到视图
        bottomImage.layer.addSublayer(gradLayer)

    }

    @objc fileprivate func panAction(pan: UIPanGestureRecognizer) {
        // 获取偏移量
        let point = pan.translation(in: dragVIew)
        // 计算旋转角度
        let angle = -point.y / 200.0
        
        // 增加旋转的立体感，近大远小
        var transform = CATransform3DIdentity
        //200.0可以理解为，人的眼睛离手机屏幕的垂直距离，近大远小效果越明显
        transform.m34 = -1 / 500.0
        transform = CATransform3DRotate(transform, angle, 1, 0, 0)
        topImage.layer.transform = transform
        
        //设置阴影效果
        gradLayer.opacity = Float(point.y * 1 / 200.0)
        
        //反弹, 结束的动画
        if pan.state == .ended {
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                self.topImage.layer.transform = CATransform3DIdentity
            }, completion: { (true) in

            })
        }
    }

}
