//
//  ViewController.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/14.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit
import pop


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var titleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "动画列表"

        let titles = ["折叠图片", "音量震动条", "活动指示器", "微博动画", "倒计时-计时器", "QQ粘性动画", "雷达动画", "跑马灯效果", "水波纹效果"]
        titleArray = titles
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = titleArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcArr = [PictureViewController(), VolumeViewController(), ActivityViewController(), WeiBoViewController(), ClockViewController(), QQAnimationViewController(), RadarViewController(), CarouseViewController(), WaterWaveViewController()]
        let vc = vcArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
