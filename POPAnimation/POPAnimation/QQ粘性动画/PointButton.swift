//
//  PointButton.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/17.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import pop

//最大圆心距离
fileprivate let maxDistance: CGFloat = 100
// 粘性比例 0.9
fileprivate let gooRatio: CGFloat = 0.9
class PointButton: UIButton {
    fileprivate var circleR1: CGFloat = 0.0  //小圆的半径
    fileprivate var circleR2: CGFloat = 0.0  //大圆的半径
    fileprivate var oriCenter = CGPoint.zero  //self起始位置的center
    fileprivate var isOverBorder = false     //是否超出边界
    fileprivate var gifImageV = UIImageView()
    //大圆和小圆之间的部分
    fileprivate lazy var shapeLayer = { () -> CAShapeLayer in
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.red.cgColor
        return shape
    }()
    //小圆
    fileprivate lazy var smallCircleView = { () -> UIView in
        let smallView = UIView()
        smallView.backgroundColor = UIColor.red
        smallView.isHidden = true
        smallView.layer.cornerRadius = self.circleR1
        //此行代码只对xib加载有效,init代码初始化无效
        self.superview?.insertSubview(smallView, at: 0)
        return smallView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError的意思是无条件停止执行并打印, 要去掉,否则会闪退
    }
}

//MARK: 事件处理
extension PointButton {
    fileprivate func setupView(){
        //属性设置
        setTitle("11", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        layer.cornerRadius = frame.height / 2
        backgroundColor = UIColor.red
        //添加拖动手势
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panAction(pan:))))
        circleR1 = bounds.width / 2
        circleR2 = circleR1
        oriCenter = center
        smallCircleView.center = center
    }
    
    //手势滑动监听事件
    @objc fileprivate func panAction(pan: UIPanGestureRecognizer){
        if pan.state == .ended {
            //获取圆心的距离
            let distance = centerDistance(bigCenter: center, smallCenter: smallCircleView.center)
            //判断是否超出最大圆心距离
            distance > maxDistance ? boomView() : restoreViews()
        }else if pan.state == .changed {
            // 获取手指偏移量
            let transP = pan.translation(in: self)
            var temp = center
            temp.x += transP.x
            temp.y += transP.y
            
            //设置大圆的圆心
            center = temp
            
            //获取圆心的距离
            let dis = centerDistance(bigCenter: center, smallCenter: smallCircleView.center)
            
            //计算小圆的半径:随机搞个比例，随着圆心距离增加，圆心半径不断减少。
            let smallRadius = circleR2 - dis / 10
            
            smallCircleView.bounds = CGRect(x: 0, y: 0, width: smallRadius * 2, height: smallRadius * 2)
            smallCircleView.layer.cornerRadius = smallRadius
            
            // 超过最大圆心距离,不需要描述形变矩形
            if dis > maxDistance {
                // 超过边界
                isOverBorder = true
                // 隐藏小圆
                smallCircleView.isHidden = true
                // 没有弹性效果
                shapeLayer.removeFromSuperlayer()
            }else if dis > 0 && isOverBorder == false{// 否则设置小圆圆心，并且描述形变矩形
                smallCircleView.isHidden = false
                shapeLayer.path = bezierPath(bigCenter: center, bigRadius: circleR2, smallCenter: smallCircleView.center, smallRadius: smallRadius).cgPath
                superview?.layer.insertSublayer(shapeLayer, below: smallCircleView.layer)
            }
            pan.setTranslation(.zero, in: self)
        }
    }
}


extension PointButton {
    //init(frame)初始化方法需要调用, 否则smallCircleView无法添加到视图
    func reloadViews() {
        superview?.insertSubview(smallCircleView, at: 0)
    }

    //还原
    fileprivate func restoreViews(){
        shapeLayer.removeFromSuperlayer()
        //动画方式一
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.center = self.oriCenter
        }) { (finished) in
            self.isOverBorder = false
            self.smallCircleView.isHidden = false
        }
        
        /*动画方式二
         let popSpring = POPSpringAnimation(propertyNamed: kPOPViewCenter)
         popSpring?.fromValue = center
         popSpring?.toValue = oriCenter
         popSpring?.springSpeed = 10
         popSpring?.springBounciness = 10
         popSpring?.completionBlock = {anim, finished in
         self.isOverBorder = false
         self.smallCircleView.isHidden = false
         }
         self.pop_add(popSpring, forKey: nil)
         */
    }
    
    //爆炸效果
    fileprivate func boomView(){
        let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: circleR2 * 2, height: circleR2 * 2))
        addSubview(imageV)
        
        //图片数组
        var images = [UIImage]()
        for i in 1..<9 {
            images.append(UIImage(named: "boom\(i)")!)
        }
        
        //属性处理
        imageV.animationImages = images
        imageV.animationDuration = 1.2
        imageV.animationRepeatCount = 1
        imageV.startAnimating()
        
        //移除动画
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            imageV.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}
