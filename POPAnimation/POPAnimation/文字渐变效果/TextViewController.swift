//
//  TextViewController.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/2/2.
//  Copyright © 2018年 iOS-Jun. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var showLabel: UILabel!
    fileprivate var textLabel = UILabel()
    fileprivate var guadientLayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 30)
        textLabel.text = "欢迎搜索博客: Shmily果子的博客"
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        
        //创建渐变层
        guadientLayer.frame = textLabel.frame
        
        //设置渐变层颜色
        guadientLayer.colors = [randomColor().cgColor, randomColor().cgColor, randomColor().cgColor]
        view.layer.addSublayer(guadientLayer)
        
        //设置渐变层的裁剪层
        guadientLayer.mask = textLabel.layer
        
        textLabel.frame = guadientLayer.bounds
        
        
        //定时器
        let link = CADisplayLink(target: self, selector: #selector(textColorChange))
        link.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
    }

    
    //创建随机颜色
    fileprivate func randomColor() -> UIColor{
        let r = CGFloat(arc4random_uniform(256)) / 255.0
        let g = CGFloat(arc4random_uniform(256)) / 255.0
        let b = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    //定时器触发
    @objc fileprivate func textColorChange(){
        guadientLayer.colors = [randomColor().cgColor, randomColor().cgColor, randomColor().cgColor]
    }
}
