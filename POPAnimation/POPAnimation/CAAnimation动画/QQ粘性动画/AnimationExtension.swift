//
//  AnimationExtension.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/16.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import Foundation

extension NSObject {
    /*
     获取两个圆之间的距离
     */
    public func centerDistance(bigCenter big: CGPoint, smallCenter small: CGPoint) -> CGFloat {
        //获取x轴偏移量
        let offsetX = small.x - big.x
        
        //获取y轴偏移量
        let offsetY = small.y - big.y
        
        //开平方
        return CGFloat(sqrtf(Float(offsetX * offsetX + offsetY * offsetY)))
    }
    
    //描述形变路径
    public func bezierPath(bigCenter: CGPoint, bigRadius: CGFloat, smallCenter: CGPoint, smallRadius: CGFloat) -> UIBezierPath {
        //获取小圆x, y
        let x1 = smallCenter.x
        let y1 = smallCenter.y
        
        //获取小圆x, y
        let x2 = bigCenter.x
        let y2 = bigCenter.y
        
        //获取圆心距离
        let distance = centerDistance(bigCenter: bigCenter, smallCenter: smallCenter)
        
        //获取偏移角度
        let sin0 = (x2 - x1) / distance
        let cos0 = (y2 - y1) / distance
        
        //获取
        let r1 = smallRadius
        let r2 = bigRadius
        //A点
        let pointA = CGPoint(x: x1 - r1 * cos0, y: y1 + r1 * sin0)
        //B点
        let pointB = CGPoint(x: x1 + r1 * cos0, y: y1 - r1 * sin0)
        //C点
        let pointC = CGPoint(x: x2 + r2 * cos0, y: y2 - r2 * sin0)
        //D点
        let pointD = CGPoint(x: x2 - r2 * cos0, y: y2 + r2 * sin0)
        
        //控制点
        //O点
        let pointO = CGPoint(x: pointA.x + distance * 0.5 * sin0, y: pointA.y + distance * 0.5 * cos0)
        //P点
        let pointP = CGPoint(x: pointB.x + distance * 0.5 * sin0, y: pointB.y + distance * 0.5 * cos0)
        
        //创建描述路径
        let path = UIBezierPath()
        path.move(to: pointA)
        path.addLine(to: pointB)
        //绘制二次贝塞尔曲线
        path.addQuadCurve(to: pointC, controlPoint: pointP)
        path.addLine(to: pointD)
        path.addQuadCurve(to: pointA, controlPoint: pointO)
        return path
    }
    
    /* path.addQuadCurve(to: CGPoint, controlPoint: CGPoint)
     *作用: 在接收器的路径上附加二次贝塞尔曲线(主要用于画曲线)
     *参数一: 终点, 参数二:控制点
     *可参考: https://developer.apple.com/documentation/uikit/uibezierpath/1624351-addquadcurvetopoint
     */
}


extension UIView {
    /*
     似GameCenter多图浮动效果的气泡晃动动画
     */
    func animationLikeGameCenterBubble() {
        //创建关键帧动画
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.calculationMode = kCAAnimationPaced
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.repeatCount = HUGE
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.duration = 5.0
        
        //制作画板,绘制图形
        let curvedPath = CGMutablePath()
        let circleContainer = frame.insetBy(dx: bounds.width / 2 - 3, dy: bounds.width / 2 - 3)
        curvedPath.addEllipse(in: circleContainer)
        pathAnimation.path = curvedPath
        layer.add(pathAnimation, forKey: "myCircleAnimation")
        
        //缩放X
        let scaleX = CAKeyframeAnimation(keyPath: "transform.scale.x")
        scaleX.duration = 1
        scaleX.values = [1.0, 1.1, 1.0]
        scaleX.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.5), NSNumber(value: 1.0)]
        scaleX.repeatCount = HUGE
        scaleX.autoreverses = true
        scaleX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(scaleX, forKey: "scaleXAnimation")
        
        //缩放y
        let scaleY = CAKeyframeAnimation(keyPath: "transform.scale.y")
        scaleY.duration = 1.5
        scaleY.values = [1.0, 1.1, 1.0]
        scaleY.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.5), NSNumber(value: 1.0)]
        scaleY.repeatCount = HUGE
        scaleY.autoreverses = true
        scaleY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(scaleY, forKey: "scaleYAnimation")
    }
}
