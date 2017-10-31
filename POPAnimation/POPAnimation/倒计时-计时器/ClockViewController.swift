//
//  ClockViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/16.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import pop

class ClockViewController: UIViewController {

    @IBOutlet weak var clockLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "倒计时-计时器"
        
        //因初始化的对象为可选类型,官方推荐初始化用if判断
        //官方推荐初始化方式
         if let proper = POPAnimatableProperty.property(withName: "prop", initializer: { (prop) in
             guard let prop = prop else { return }
             //read
             prop.readBlock = { (obj, values) in
                 guard let array = values else { return }
                 print(array[0])
             }
            
             //write
             prop.writeBlock = {(obj, values) in
                guard let label = obj as? UILabel, let array = values else { return }
                let value = array[0]
                label.text = String(format: "%02d:%02d:%02d", Int(value / 60), Int(value.truncatingRemainder(dividingBy: 60)), Int((value * 100).truncatingRemainder(dividingBy: 100)))
             }
            
             prop.threshold = 0.01

         }) as? POPAnimatableProperty {
             if let popBasic = POPBasicAnimation.linear() {
                 //秒表用线性的时间函数初始化
                 popBasic.property = proper
                 popBasic.fromValue = 0 //从0开始
                 popBasic.toValue = 18  //到18秒
                 popBasic.duration = 18 //持续18秒
                //注: 将fromValue改为18, toValue改为0,就是倒计时
                 popBasic.beginTime = CACurrentMediaTime() + 2 //延迟2秒开始
                 clockLabel.pop_add(popBasic, forKey: "linear")
             }
         }
 

    }
}
