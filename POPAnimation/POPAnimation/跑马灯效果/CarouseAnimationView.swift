//
//  CarouseAnimationView.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/30.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit


class CarouseAnimationView: UIView {
    
    fileprivate var staticLabel = UILabel()
    fileprivate var firseLabel = UILabel()
    fileprivate var secondLabel = UILabel()
    fileprivate var titleType = JunTitleType.carousel
    
    var title = "" {
        didSet{
            updataTitleType()
            updataSubviews()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initicationSubviews()
    }
    
    fileprivate func initicationSubviews(){
        backgroundColor = UIColor.red
        staticLabel = initLabel(isStatic: true)
        addSubview(staticLabel)
        
        firseLabel = initLabel()
        addSubview(firseLabel)
        secondLabel = initLabel()
        addSubview(secondLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Label处理
extension CarouseAnimationView {
    //更新显示类型
    fileprivate func updataTitleType(){
        let titleWidth = getTitleWidth(title)
        titleType = titleWidth > frame.width ? .carousel : .statical
    }
    
    //更新视图
    fileprivate func updataSubviews(){
        let text = titleType == .statical ? title : "      " + title + "      "
        staticLabel.text = text
        firseLabel.text = text
        secondLabel.text = text
        
        let size = firseLabel.sizeThatFits(.zero)
        firseLabel.frame.size.width = size.width
        secondLabel.frame.size.width = size.width
        secondLabel.frame.origin.x = firseLabel.frame.maxX
        
        //清除所有动画
        layer.removeAllAnimations()
        if titleType == .statical {
            staticLabel.isHidden = false
            firseLabel.isHidden = true
            secondLabel.isHidden = true
        }else{
            staticLabel.isHidden = true
            firseLabel.isHidden = false
            secondLabel.isHidden = false
            let duration = TimeInterval(text.characters.count / 3)
            addCarouselAnimation(duration)
        }
    }
    
    //动画展示, 无限递归
    fileprivate func addCarouselAnimation(_ duration: TimeInterval){
        UIView.transition(with: self, duration: duration, options: .curveLinear, animations: {
            self.firseLabel.frame.origin.x -= self.firseLabel.frame.width
            self.secondLabel.frame.origin.x = self.firseLabel.frame.maxX
        }) { (true) in
            self.firseLabel.frame.origin.x = 0
            self.secondLabel.frame.origin.x = self.firseLabel.frame.maxX
            self.addCarouselAnimation(duration)
        }
    }
    
    //创建label
    fileprivate func initLabel(isStatic: Bool = false) -> UILabel{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.isHidden = true
        label.textAlignment = isStatic ? .center : .left
        label.backgroundColor = UIColor.clear
        return label
    }
    
    //计算width
    fileprivate func getTitleWidth(_ title: String) -> CGFloat {
        let width = (title as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 25), options: .usesLineFragmentOrigin, attributes: [.font: staticLabel.font], context: nil).size.width
        return width
    }
}
