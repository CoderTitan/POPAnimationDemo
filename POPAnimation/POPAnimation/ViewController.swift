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
        
        
        /*
        if let proper = POPAnimatableProperty.property(withName: "prop", initializer: { (prop) in
            guard let prop = prop else { return }
            //read
            prop.readBlock = { (obj, values) in
                guard let array = values else { return }
                print(array[0])
            }
            
            //write
            prop.writeBlock = {(obj, values) in
                guard let button = obj as? UIButton, let array = values else { return }
                let value = array[0]
                button.setTitle(String(format: "%02d:%02d:%02d", Int(value / 60), Int(value.truncatingRemainder(dividingBy: 60)), Int((value * 100).truncatingRemainder(dividingBy: 100))), for: .normal)
            }
            prop.threshold = 0.01
            
        }) as? POPAnimatableProperty {
            if let popBasic = POPBasicAnimation.linear() {
                //秒表用线性的时间函数初始化
                popBasic.property = proper
                popBasic.fromValue = 0 //从0开始
                popBasic.toValue = 18  //到18秒
                popBasic.duration = 18 //持续18秒
                popBasic.beginTime = CACurrentMediaTime() + 2 //延迟2秒开始
                pictureBtn.pop_add(popBasic, forKey: "linear")
            }
        }
 */
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
    }
    
    @IBAction func button6Action(_ sender: Any) {
    }
    
    @IBAction func button7Action(_ sender: Any) {
    }
    
}

