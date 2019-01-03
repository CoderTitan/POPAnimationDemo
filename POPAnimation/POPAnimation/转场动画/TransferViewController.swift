//
//  TransferViewController.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/12/20.
//  Copyright © 2018 iOS-Jun. All rights reserved.
//

import UIKit

class TransferViewController: BaseTableViewController {

    fileprivate var typeArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        titles = ["淡入淡出", "推挤", "揭开", "覆盖", "立方体", "吸吮", "翻转", "波纹", "反翻页", "开镜头", "关镜头"]
        typeArray = [
        "fade",     //淡入淡出    kCATransitionFade
        "push",     //推挤    kCATransitionPush
        "reveal",    //揭开    kCATransitionReveal
        "moveIn",    //覆盖    kCATransitionMoveIn
        "cube",     //立方体    私有API
        "suckEffect",    //吮吸    私有API
        "oglFlip",      //翻转    私有API
        "rippleEffect",    //波纹    私有API
        "pageCurl",     //反翻页    私有API
        "cameraIrisHollowOpen",     //开镜头    私有API
        "cameraIrisHollowClose",    //关镜头    私有API
        ]
        
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PushTransViewController()
        let animation = CATransition()
        animation.duration = 0.35
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = typeArray[indexPath.row]
        animation.subtype = kCATransitionFromRight
        view.window?.layer.add(animation, forKey: "transition")
        navigationController?.pushViewController(vc, animated: false)
    }

}
