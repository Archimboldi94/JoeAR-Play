//
//  ARListViewController.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/30.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class ARListViewController: JoeViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Joe ARList"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
  
    let theTitleArr : [String] = ["图片盒子,飞机,车", "平面,船", "火箭,物理系统"]
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = .background
        tw.delegate = self
        tw.dataSource = self
        //tw.separatorStyle = .none
        tw.estimatedRowHeight = 50
        tw.rowHeight = UITableViewAutomaticDimension
        tw.register(cellType: JoeTableViewCell.self)
        
        return tw
    }()

}

extension ARListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: JoeTableViewCell.self)
        cell.textLabel?.text = theTitleArr[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        uLog("indexPath.row == \(indexPath.row)")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(JoeAR1VC(), animated: true)
        case 1:
            navigationController?.pushViewController(JoeAR2VC(), animated: true)
        case 2:
            navigationController?.pushViewController(JoeAR3VC(), animated: true)
            
        default: break
            
        }
       
        
    }
}
