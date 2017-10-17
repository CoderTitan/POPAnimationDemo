//
//  RadarViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/17.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

class RadarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

//        let shapeLayer = CAShapeLayer()
//        shapeLayer.position = CGPoint(x: 100, y: 100)
//        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
//        shapeLayer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
//        shapeLayer.backgroundColor = UIColor.red.cgColor
//        view.layer.addSublayer(shapeLayer)
        
        let radarView = RadarView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        radarView.center = view.center
        view.addSubview(radarView)

        
    }
    

}
