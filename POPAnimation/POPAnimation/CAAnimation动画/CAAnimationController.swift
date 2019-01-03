//
//  CAAnimationController.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/12/19.
//  Copyright © 2018 iOS-Jun. All rights reserved.
//

import UIKit

class CAAnimationController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        titles = ["QQ粘性动画", "跑马灯效果", "录音动画效果", "水波纹效果"]
        
        vcArr = [QQAnimationViewController(), CarouseViewController(), TKWaterWaveViewController(), WaterWaveController()]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
