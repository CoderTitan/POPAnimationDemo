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

    @IBOutlet weak var pictureBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func button1Action(_ sender: Any) {
        navigationController?.pushViewController(PictureViewController(), animated: true)
    }

    @IBAction func button2Action(_ sender: Any) {
        navigationController?.pushViewController(VolumeViewController(), animated: true)
    }
    
    @IBAction func button3Action(_ sender: Any) {
        navigationController?.pushViewController(ActivityViewController(), animated: true)
    }
    
    @IBAction func button4Action(_ sender: Any) {
        navigationController?.pushViewController(WeiBoViewController(), animated: true)
    }
    
    @IBAction func button5Action(_ sender: Any) {
        navigationController?.pushViewController(ClockViewController(), animated: true)
    }
    
    @IBAction func button6Action(_ sender: Any) {
        navigationController?.pushViewController(QQAnimationViewController(), animated: true)
    }
    
    @IBAction func button7Action(_ sender: Any) {
        navigationController?.pushViewController(WeiBoViewController(), animated: true)
    }
    
}

