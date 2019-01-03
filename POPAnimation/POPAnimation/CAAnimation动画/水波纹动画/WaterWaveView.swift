//
//  WaterWaveView.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/12/19.
//  Copyright © 2018 iOS-Jun. All rights reserved.
//

import UIKit

class WaterWaveView: UIView {

   
    /// 水纹速度, 默认0.05
    var waveSpeed: CGFloat = 0.05
    /// 水纹振幅, 默认10
    var waveA: CGFloat = 10
    /// 周期, 默认(2 * M_PI) / self.bounds.size.width
    var waveW: CGFloat = CGFloat(2 * Double.pi)
    
    
    /// 位移
    fileprivate var offsetX: CGFloat = 0
    /// 当前波浪高度
    fileprivate var currentK: CGFloat = 0
    /// 波浪宽度
    fileprivate var waveWidth: CGFloat = 0
    fileprivate var waveLayer = CAShapeLayer()
    /// 定时器与屏幕刷新频率一致)
    fileprivate var displayLink: CADisplayLink?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        waveW = CGFloat(2 * Double.pi) / frame.width
        currentK = frame.height / 2
        waveWidth = frame.width
        
        initLayers()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil && displayLink != nil {
            displayLink?.invalidate()
            displayLink = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WaterWaveView {
    fileprivate func initLayers() {
        // 设置闭环颜色
        waveLayer.fillColor = UIColor.orange.cgColor
        layer.addSublayer(waveLayer)
        
        //CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。
        displayLink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        displayLink?.add(to: RunLoop.current, forMode: .commonModes)
    }
}


extension WaterWaveView {
    /// 定时器刷新方法
    @objc fileprivate func getCurrentWave() {
        offsetX += waveSpeed
        
        setCurrentFirstWavePath()
    }
    
    fileprivate func setCurrentFirstWavePath() {
        let path = CGMutablePath()
        var y = currentK
        
        path.move(to: CGPoint(x: 0, y: y))
        for i in 0..<Int(waveWidth) {
            y = waveA * sin(waveW * CGFloat(i) + offsetX) + currentK
            path.addLine(to: CGPoint(x: CGFloat(i), y: y))
        }
        path.addLine(to: CGPoint(x: waveWidth, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        
        waveLayer.path = path
    }
}


/* y=Asin(ωx+φ)+k
 * A: 振幅
 * ω: 频率的倒数, 最小正周期T=2π/|ω|
 * φ: 初相位, 决定波形与X轴位置关系或横向移动距离（左加右减）
 * k: 表示波形在Y轴的位置关系或纵向移动距离（上加下减）
 */
