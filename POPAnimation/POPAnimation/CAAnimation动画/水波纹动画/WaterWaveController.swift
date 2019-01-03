//
//  WaterWaveController.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/12/20.
//  Copyright © 2018 iOS-Jun. All rights reserved.
//

import UIKit

class WaterWaveController: UIViewController {

    @IBOutlet weak var slide1: UISlider!
    @IBOutlet weak var slide2: UISlider!
    @IBOutlet weak var slide3: UISlider!
    
    fileprivate var waveView = WaterWaveView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        waveView = WaterWaveView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 300))
        view.addSubview(waveView)
        
        slide1.minimumValue = Float(waveView.waveA)
        slide1.maximumValue = Float(waveView.waveA * 2)
        slide2.minimumValue = Float(waveView.waveA)
        slide2.maximumValue = Float(waveView.waveA * 2)
        slide3.minimumValue = Float(waveView.waveA)
        slide3.maximumValue = Float(waveView.waveA * 2)
    }
    
    @IBAction func slideAction1(_ sender: UISlider) {
        waveView.waveSpeed = CGFloat(sender.value)
    }
    
    @IBAction func slideAction2(_ sender: UISlider) {
        waveView.waveW = CGFloat(sender.value)
    }
    
    @IBAction func slideAction3(_ sender: UISlider) {
        waveView.waveA = CGFloat(sender.value)
    }

}
