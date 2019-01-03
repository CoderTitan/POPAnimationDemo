//
//  LoadCellViewController.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/12/20.
//  Copyright © 2018 iOS-Jun. All rights reserved.
//

import UIKit

class LoadCellViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        
        tableView.reloadData()
        starAnimation(tableView: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
            let back = UIView(frame: CGRect(x: 15, y: 10, width: kScreenWidth - 30, height: 80))
            back.backgroundColor = UIColor.orange
            back.layer.masksToBounds = true
            back.layer.cornerRadius = 5
            cell?.contentView.addSubview(back)
            
            cell?.contentView.backgroundColor = UIColor.clear
            cell?.backgroundColor = UIColor.clear
        }
        cell?.selectionStyle = .none

        return cell ?? UITableViewCell()
    }

    
    fileprivate func starAnimation(tableView: UITableView) {
        
    }

}
