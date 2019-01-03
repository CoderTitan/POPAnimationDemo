//
//  WaterWaveViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/31.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

class TKWaterWaveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let waterView = TKWaterWaveAnimationView(frame: CGRect(x: 200, y: 200, width: 60, height: 60))
        view.addSubview(waterView)
    }

}
