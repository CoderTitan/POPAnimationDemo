//
//  BaseTableViewController.swift
//  POPAnimation
//
//  Created by quanjunt on 2018/12/19.
//  Copyright © 2018 iOS-Jun. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var titles = [String]()
    var vcArr = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.selectionStyle = .none
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = vcArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
