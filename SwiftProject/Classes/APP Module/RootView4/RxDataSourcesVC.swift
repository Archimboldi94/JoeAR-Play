//
//  RxDataSourcesVC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/12.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
//import EmptyDataSet_Swift

class RxDataSourcesVC: UBaseViewController{
    
    
    var tableView: UITableView!
    
    var dataArray: Array<shopModel> = []
    
    override func viewDidLoad() {
        
        tableView = UITableView(frame: self.view.frame, style:.plain)
        tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(self.tableView!)
//        dataArray = ["不搭","老伴","落俗","自拍"]
        tableView.tableFooterView = UIView()
        //initModel()
        
        //tableView.reloadData()
        
        //初始化数据
        let items = Observable.just([
            SectionModel(model: "", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ])
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, String>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(indexPath.row)：\(element)"
                return cell
            })
        
        //绑定单元格数据
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        super.viewDidLoad()
        
    }


    

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
//        -> UITableViewCell {
//            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
//            cell.selectionStyle = .none//cell样式，取消选中
//            var model = goodsModel()
//            model = dataArray[indexPath.section].goodsitem[indexPath.row]
//            cell.textLabel?.text = model.good_name
//            return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return dataArray.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataArray[section].goodsitem.count
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        KSetLabel(label: label, color: .red, fontsize: 14, alignment: .left, str: dataArray[section].shop_name)
//        //return的view会替换自带的头标题view
//        //frame设置无效,位置是固定的,宽度固定和table一样,高度通过代理方法设置
//        return label
//    }
//
//    func initModel() {
//        var goodsname = ["尤克里里","吉他","钢琴","二胡","小提琴","大提琴","手风琴","太鼓"]
//        var shopname = ["KK音乐店","JJ乐器仿"]
//        for k in 0..<2 {
//            var shopmodel = shopModel()
//            for _ in 0..<3 {
//                var goodmodel = goodsModel()
//                let voice = Int(arc4random_uniform(7))
//                goodmodel.good_name = goodsname[voice]
//                shopmodel.goodsitem.append(goodmodel)
//            }
//            shopmodel.shop_name = shopname[k]
//            dataArray.append(shopmodel)
//        }
//
//        print("dataArray == \(dataArray)")
//    }
    
    
    
}

