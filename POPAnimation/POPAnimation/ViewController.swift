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
        titleArray = ["pop动画组", "CA动画组", "其他动画", "列表加载动画", "转场动画"]
    }
    
    @objc fileprivate func getCurrentWave() {
        print("skajsdha")
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
        cell?.selectionStyle = .none
        cell?.textLabel?.text = titleArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcArr = [POPAnimationController(), CAAnimationController(), OtherViewController(), LoadTableCellController(), TransferViewController()]
        let vc = vcArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
