//
//  RootVC4.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/2/28.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class RootVC4: UBaseViewController,UITableViewDelegate{

    enum PushEnum: Int{
        case RxDataSources = 0
        case MVPVC = 1
        case Top = 2
        case Bottom = 3
    }
    
    var tableView: UITableView!
    
    
    override func configUI() {
        
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        self.tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        let navbtn = UIButton(frame: CGRect(x:0, y: 0, width: 50, height: 50))
        KSetButton(btn: navbtn, img: nil, fontcolor: .blue, bgcolor: nil, fontsize: 16, str: "编辑")
        let navitem = UIBarButtonItem(customView: navbtn)
        navbtn.rx.tap
            .subscribe(onNext: { [weak self] in
                if navbtn.titleLabel?.text == "编辑" {
                    self?.tableView.setEditing(true, animated: true)
                    navbtn.setTitle("完成", for: .normal)
                }else{
                    navbtn.setTitle("编辑", for: .normal)
                    self?.tableView.setEditing(false, animated: true)
                }
                
            }).disposed(by: disposeBag)
        
        self.navigationItem.rightBarButtonItem = navitem
        
        var dataArray = [
            "RxDataSources的用法",
            "MVP购物车",
            "进度条的用法",
            "文本标签的用法",
            ]
        
        let variable = BehaviorSubject(value: dataArray)
        
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        variable
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row)：\(element)"
                return cell
            }
            .disposed(by: disposeBag)
        
        //获取选中项的索引
        tableView.rx.itemSelected.subscribe(onNext: {[weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            self?.pushToSomeWhere(enmu: RootVC4.PushEnum(rawValue: indexPath.row)!)
            print("选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)

        //获取删除项的索引
        tableView.rx.itemDeleted.subscribe(onNext: {indexPath in
            print("删除项的indexPath为：\(indexPath)")
            dataArray.remove(at: indexPath.row)
            variable.onNext(dataArray)
        }).disposed(by: disposeBag)
        
        //获取移动项的索引
        tableView.rx.itemMoved.subscribe(onNext: {sourceIndexPath, destinationIndexPath in
            print("移动项原来的indexPath为：\(sourceIndexPath)")
            print("移动项现在的indexPath为：\(destinationIndexPath)")
        }).disposed(by: disposeBag)
        
        super.configUI()
    }
  
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func pushToSomeWhere(enmu: PushEnum) {
        switch enmu {
        case .RxDataSources:
            self.navigationController?.pushViewController(RxDataSourcesVC(), animated: true)
        case .MVPVC:
            self.navigationController?.pushViewController(ShopCartViewController(), animated: true)
        default:
            return
        }
    }
    
}
