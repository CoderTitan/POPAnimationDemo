//
//  WaterWaveAnimationView.swift
//  POPAnimation
//
//  Created by iOS_Tian on 2017/10/31.
//  Copyright © 2017年 iOS-Jun. All rights reserved.
//

import UIKit

enum JunWaterWaveType {
    case show
    case hide
}
class WaterWaveAnimationView: UIView {
    //外部参数
    var mainColor = UIColor.blue ///第一个颜色(主色)
    var secondColor = UIColor.cyan ///第二个颜色(辅色)
    var percent: CGFloat = 0.5 ///最大高度所占比例
    
    //私有属性
    fileprivate var waveDisplaylink: CADisplayLink?
    fileprivate var mainWaveLayer = CAShapeLayer()
    fileprivate var secondWaveLayer = CAShapeLayer()
    fileprivate var waveAmplitude: CGFloat = 0  /// 波纹振幅
    fileprivate var waveCycle: CGFloat = 0      /// 波纹周期
    fileprivate var waveSpeed: CGFloat = 0      /// 波纹速度
    fileprivate var waveGrowth: CGFloat = 0     /// 波纹上升速度
    fileprivate var waterWaveHeight: CGFloat = 0
    fileprivate var waterWaveWidth: CGFloat = 0
    fileprivate var offsetX: CGFloat = 0           /// 波浪x位移
    fileprivate var currentWavePointY: CGFloat = 0 /// 当前波浪上升高度Y（高度从大到小 坐标系向下增长）
    fileprivate var variable = false    ///可变参数 更加真实 模拟波纹
    fileprivate var increase: CGFloat = 0      /// 增减变化
    fileprivate var animateType = JunWaterWaveType.show ///展现时先上升，隐藏时先下降
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 视图创建和处理
extension WaterWaveAnimationView{
    //初始化View
    fileprivate func initSubviews(){
        waterWaveHeight = frame.height / 2
        waterWaveWidth  = frame.width
        waveGrowth = 0.85
        waveSpeed = 0.4 / CGFloat(Double.pi)
        waveCycle =  2.5 * CGFloat(Double.pi) / waterWaveWidth
        currentWavePointY = frame.height
        offsetX = 0
    }
}

//MARK: show/hide
extension WaterWaveAnimationView{
    /// 开始
    func startWaterWave(){
        animateType = .show
        
        mainWaveLayer.fillColor = mainColor.cgColor
        secondWaveLayer.fillColor = secondColor.cgColor
        layer.addSublayer(mainWaveLayer)
        layer.addSublayer(secondWaveLayer)
        
        //停止当前定时器
        stopWaterWave()
        
        //重新开启定时器
        waveDisplaylink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        waveDisplaylink?.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    /// 结束
    func stopWaterWave(){
        animateType = .hide
        if waveDisplaylink != nil {
            waveDisplaylink?.invalidate()
        }
        
    }
    
    @objc fileprivate func getCurrentWave(){
        
    }
}


/* y=Asin(ωx+φ)+k
 * A: 振幅
 * ω: 频率的倒数, 最小正周期T=2π/|ω|
 * φ: 初相位, 决定波形与X轴位置关系或横向移动距离（左加右减）
 * k: 表示波形在Y轴的位置关系或纵向移动距离（上加下减）
 */
