//
//  WaterWaveAnimationView.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/31.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

class TKWaterWaveAnimationView: UIView {
    
    fileprivate var microphoneTimer: Timer?
    fileprivate var maskLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame
        initSubviews()
        addTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 视图创建和处理
extension TKWaterWaveAnimationView{
    //初始化View
    fileprivate func initSubviews(){
        let bottomImg = UIImageView(image: UIImage(named: "microPhone_bottom"))
        bottomImg.frame = CGRect(x: (frame.width - 43) / 2, y: (frame.height - 48) / 2, width: 43, height: 48)
        addSubview(bottomImg)
        
        let topImg = UIImageView(image: UIImage(named: "microPhone_top"))
        topImg.frame = CGRect(x: (frame.width - 43) / 2, y: (frame.height - 48) / 2, width: 43, height: 48)
        addSubview(topImg)
        
        maskLayer.position = CGPoint(x: topImg.frame.width / 2, y: 3 * topImg.frame.height / 2)
        maskLayer.bounds = topImg.bounds
        maskLayer.backgroundColor = UIColor.orange.cgColor
        topImg.layer.mask = maskLayer
    }
    
    /// 添加计时器
    fileprivate func addTimer() {
        closeTimer()
        
        microphoneTimer = Timer(timeInterval: 0.3, target: self, selector: #selector(timerActon), userInfo: ["mode": NSNumber(value: 1)], repeats: true)
        RunLoop.current.add(microphoneTimer!, forMode: .defaultRunLoopMode)
    }
}

//MARK: show/hide
extension TKWaterWaveAnimationView{
    /// 计时器方法
    @objc fileprivate func timerActon() {
        let beginPoint = maskLayer.position
        let height: CGFloat = CGFloat(arc4random() % 48)
        let endPoint = CGPoint(x: beginPoint.x, y: 48 / 2 * 3 - height)
        maskLayer.position = endPoint
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = beginPoint
        animation.toValue = endPoint
        animation.duration = 0.3
        maskLayer.add(animation, forKey: "")
    }
    
    /// 销毁计时器
    fileprivate func closeTimer() {
        if microphoneTimer != nil {
            if microphoneTimer!.isValid {
                microphoneTimer?.invalidate()
            }
            microphoneTimer = nil
        }
    }
}


