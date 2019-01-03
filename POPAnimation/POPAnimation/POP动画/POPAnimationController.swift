//
//  POPAnimationController.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/12/19.
//  Copyright © 2018 iOS-Jun. All rights reserved.
//

import UIKit

class POPAnimationController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titles = ["折叠图片", "音量震动条", "活动指示器", "微博动画", "倒计时-计时器", "雷达动画"]
        vcArr = [PictureViewController(), VolumeViewController(), ActivityViewController(), WeiBoViewController(), RadarViewController(), ClockViewController()]
    }
    

    

}
