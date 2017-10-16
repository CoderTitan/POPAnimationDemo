//
//  PublishView.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/14.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import pop

fileprivate let kAnimationDelay = 0.1
fileprivate let kSpringFactor: CGFloat = 10
class PublishView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //0. 设置背景
        backgroundColor = UIColor(white: 0.8, alpha: 0.9)
        
        //1. 设置相关view不能被点击
        kRootView?.isUserInteractionEnabled = false
        isUserInteractionEnabled = false
        
        //2. 创建中间6个按钮
        addCenterButton()
    }
    
    //创建中间6个按钮
    fileprivate func addCenterButton(){
        let images = ["publish-0", "publish-1", "publish-2", "publish-3", "publish-4", "publish-5"]
        let titles = ["发视频", "发图片", "发段子", "发声音", "审帖", "离线"]
        
        //button各部分尺寸
        let maxCols = 3  //每一行的个数
        let buttonW: CGFloat = 72.0 //button宽度
        let buttonH = buttonW + 30.0 //button高度
        let btnStartY = (kScreenHeight - buttonH * 2) * 0.5 ////y方向起始值
        let btnStsrtX: CGFloat = 20.0 //x方向起始值
        let xMargin = (kScreenWidth - btnStsrtX * 2 - buttonW * CGFloat(maxCols)) / CGFloat(maxCols - 1) //x方向间距
        
        //创建button
        for i in 0..<titles.count {
            let button = BaseButton()
            button.setTitle(titles[i], for: .normal)
            button.setImage(UIImage(named: images[i]), for: .normal)
            button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
            addSubview(button)
            
            //计算X/Y
            let row = i / maxCols
            let col = i % maxCols
            let buttonX = btnStsrtX + CGFloat(col) * (xMargin + buttonW)
            let buttonEndY = btnStartY + CGFloat(row) * buttonH
            let buttonStartY = buttonEndY - kScreenHeight
            
            //按钮动画
            let popSpring = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            popSpring?.fromValue = CGRect(x: buttonX, y: buttonStartY, width: buttonW, height: buttonH)
            popSpring?.toValue = CGRect(x: buttonX, y: buttonEndY, width: buttonW, height: buttonH)
            popSpring?.springBounciness = kSpringFactor
            popSpring?.springSpeed = kSpringFactor
            popSpring?.beginTime = CACurrentMediaTime() + kAnimationDelay * Double(i)
            button.pop_add(popSpring, forKey: "spring")
        }
        
        //添加最上部分标语
        addTopImage(btnCount: images.count)
    }
    
    //添加最上部分标语
    fileprivate func addTopImage(btnCount: Int){
        let topImage = UIImageView(image: UIImage(named: "2-2"))
        addSubview(topImage)
        
        //z执行动画
        let imagePOP = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        imagePOP?.fromValue = CGPoint(x: kScreenWidth * 0.5, y: -0.8 * kScreenHeight)
        imagePOP?.toValue = CGPoint(x: kScreenWidth * 0.5, y: 0.2 * kScreenHeight)
        imagePOP?.springSpeed = kSpringFactor
        imagePOP?.springBounciness = kSpringFactor
        imagePOP?.beginTime = CACurrentMediaTime() + Double(btnCount) * kAnimationDelay
        imagePOP?.completionBlock = { popAnim, finished in
            //所有动画执行完毕,回复View点击事件
            kRootView?.isUserInteractionEnabled = true
            self.isUserInteractionEnabled = true
        }
        topImage.pop_add(imagePOP, forKey: nil)
    }
}


//MARK: 返回页面,退出动画
extension PublishView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cancelAnimation {
            print("退出页面")
        }
    }
    
    //先执行退出动画, 动画完毕后执行completionBlock
    fileprivate func cancelAnimation(completionClosure: @escaping() -> ()) {
        //设置相关view不能被点击
        kRootView?.isUserInteractionEnabled = false
        isUserInteractionEnabled = false
        
        for i in 1..<subviews.count {
            let subview = subviews[i]
            let popBasic = POPBasicAnimation(propertyNamed: kPOPViewCenter)
            popBasic?.toValue = CGPoint(x: subview.center.x, y: subview.center.y + kScreenHeight)
            popBasic?.beginTime = CACurrentMediaTime() + Double(i - 1) * kAnimationDelay
            subview.pop_add(popBasic, forKey: nil)
            
            //监听最后一个动画
            if i == subviews.count - 1 {
                popBasic?.completionBlock = { anim, finished in
                    kRootView?.isUserInteractionEnabled = true
                    self.removeFromSuperview()
                    
                    //执行传进来的闭包
                    completionClosure()
                }
            }
        }
    }
}

//MARK: 事件监听
extension PublishView {
    @objc fileprivate func buttonClick(button: UIButton){
        print(button.currentTitle ?? "")
    }
    
    @IBAction func clouseAction(_ sender: Any) {
        cancelAnimation {
            print("退出页面")
        }
    }
}


//MARK: 加载方法
extension PublishView {
    class func loadFromNib() -> PublishView{
        guard let publishV = Bundle.main.loadNibNamed("PublishView", owner: nil, options: nil)?.first as? PublishView else {
            return PublishView()
        }
        return publishV
    }
}
