//
//  LoadTableCellController.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/12/20.
//  Copyright © 2018 iOS-Jun. All rights reserved.
//

import UIKit

class LoadTableCellController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titles = ["左侧飞出", "下落渐显", "快速下落", "左右出现", "翻转出现", "飞到顶端", "跳动下落", "向上靠拢"]
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LoadCellViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
