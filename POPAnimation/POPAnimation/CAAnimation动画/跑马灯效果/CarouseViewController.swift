//
//  CarouseViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/30.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

class CarouseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        
        let carouseV1 = CarouseAnimationView(frame: CGRect(x: 100, y: 100, width: 150, height: 25))
        carouseV1.title = "我是最帅的程序员"
        view.addSubview(carouseV1)
        
        let carouseV2 = CarouseAnimationView(frame: CGRect(x: 100, y: 150, width: 150, height: 25))
        carouseV2.title = "我是最帅的iOS开发攻城狮, 这是一个测试的跑马灯"
        view.addSubview(carouseV2)
        
    }
}
