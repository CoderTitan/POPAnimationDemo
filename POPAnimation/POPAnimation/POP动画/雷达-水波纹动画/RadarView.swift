//
//  RadarView.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/17.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import pop

//中间圆的宽高
fileprivate let kCircleSize: CGFloat = 50
//每一组动画时间
fileprivate let animDuration = 2.0

class RadarView: UIView {
    
    //定时器
    fileprivate var radarTimer: Timer?
    fileprivate var viewTimer: Timer?
    
    //懒加载属性
    fileprivate lazy var circleView = {() -> UIView in
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: kCircleSize, height: kCircleSize))
        circleView.layer.masksToBounds = true
        circleView.layer.cornerRadius = kCircleSize / 2
        circleView.backgroundColor = UIColor.yellow
        return circleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatCircleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeViewTimer()
    }
}

//MARK: 视图逻辑处理
extension RadarView {
    //创建中间圆形
    fileprivate func creatCircleView(){
        //0. 创建中间圆形
        circleView.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addSubview(circleView)
        
        //t添加定时器
        radarTimer = Timer(timeInterval: 0.5, target: self, selector: #selector(getRadarAnimation), userInfo: nil, repeats: true)
        RunLoop.current.add(radarTimer!, forMode: .commonModes)
        viewTimer = Timer(timeInterval: 6, target: self, selector: #selector(removeRadarView), userInfo: nil, repeats: true)
        RunLoop.current.add(viewTimer!, forMode: .commonModes)
    }
    
    //创建单一视图
    @objc fileprivate func getRadarAnimation(){
        //1. CAShapeLayer画图
        let shapeLayer = CAShapeLayer()
        shapeLayer.position = CGPoint(x: 0, y: 0)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0) //锚点: 默认(0.5, 0.5)
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        
        //2. 贝塞尔曲线
        //该方法将会创建一个闭合路径,  该方法会通过顺时针的绘制贝塞尔曲线, 绘制出一个近似椭圆的形状. 如果 rect 参数指定了一个矩形, 那么该 UIBezierPath 对象将会描述一个圆形.
        let path = UIBezierPath(ovalIn: CGRect(x: circleView.frame.minX, y: circleView.frame.minY, width: kCircleSize, height: kCircleSize))
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.insertSublayer(shapeLayer, below: circleView.layer)
        
        //3. 创建始末曲线
        let beginPath = UIBezierPath(ovalIn: CGRect(x: circleView.frame.minX, y: circleView.frame.minY, width: 50, height: 50))
        let endPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        //4. 设置终点曲线
        shapeLayer.path = endPath.cgPath
        shapeLayer.opacity = 0.0
        
        //5. 创建动画
        let rippleAnim = CABasicAnimation(keyPath: "path")
        rippleAnim.fromValue = beginPath.cgPath
        rippleAnim.toValue = endPath.cgPath
        rippleAnim.duration = animDuration
        
        let opactityAnim = CABasicAnimation(keyPath: "opacity")
        opactityAnim.fromValue = 0.6
        opactityAnim.toValue = 0
        opactityAnim.duration = animDuration
        shapeLayer.add(opactityAnim, forKey: "")
        shapeLayer.add(rippleAnim, forKey: "")
        perform(#selector(remove(rillpeL:)), with: shapeLayer, afterDelay: animDuration)
    }
}

//MARK: 销毁页面控件
extension RadarView{
    //销毁self
    @objc func removeRadarView(){
        //清除定时器
        removeRadarTimer()
        
        //清除子视图
        guard let layerArr = layer.sublayers, layerArr.count > 0 else { return }
        for _ in 0..<layerArr.count {
            layerArr.first?.removeFromSuperlayer()
        }
        
        removeFromSuperview()
        layer.removeAllAnimations()
    }
    
    //销毁viewTimer
    func removeViewTimer(){
        if viewTimer != nil {
            if viewTimer!.isValid {
                viewTimer?.invalidate()
            }
            viewTimer = nil
        }
    }
    
    //清除圆环
    @objc fileprivate func remove(rillpeL: CAShapeLayer){
        rillpeL.removeFromSuperlayer()
    }
    
    //销毁radarTimer
    fileprivate func removeRadarTimer(){
        if radarTimer != nil {
            if radarTimer!.isValid {
                radarTimer?.invalidate()
            }
            radarTimer = nil
        }
    }
}
