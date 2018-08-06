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
  
    let theTitleArr : [String] = ["图片盒子,飞机,车", "平面,船", "火箭,物理系统", "车,动画", "太阳系,旋转", "斯嘉丽,图片识别", "环,视频", "网页", "P5"]
    
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
        case 3:
            navigationController?.pushViewController(JoeAR4VC(), animated: true)
        case 4:
            navigationController?.pushViewController(JoeAR5VC(), animated: true)
        case 5:
            navigationController?.pushViewController(JoeAR6VC(), animated: true)
        case 6:
            navigationController?.pushViewController(JoeAR7VC(), animated: true)
        case 7:
            navigationController?.pushViewController(JoeAR8VC(), animated: true)
        case 8:
            navigationController?.pushViewController(JoeP5VC(), animated: true)
            
        default: break
            
        }
       
        
    }
}
