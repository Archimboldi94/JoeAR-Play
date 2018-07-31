//
//  ShopCartTableview.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/14.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

enum CartCallEnum {
    case CartCallEnumSelall
    case CartCallEnumSelGroup
    case CallEnumSelProduct
    case CartCallEnumMinus
    case CartCallEnumPlus
    case CartCallEnumDel
    case CallEnumConfirm
}

typealias CartCallBlock = (_ sender: Any, _ actionEnum: CartCallEnum)->()

class ShopCartTableview: UIView ,UITableViewDelegate,UITableViewDataSource{
    
    var shopModelArray: [CartShopModel] = []
    
    var CartCallBack: CartCallBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        addSubview(TableView)
        addSubview(FootBar)
    }
    
    //MARK: - tableview代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return shopModelArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ShopCartHeader()
        header.model = shopModelArray[section]
        header.HeadCallBack = {(sender) -> Void in
            self.CartCallBack!(sender, .CartCallEnumSelGroup)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopModelArray[section].goodsitem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShopCartCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "ID")
        cell.selectionStyle = .none//cell样式，取消选中
        cell.model = shopModelArray[indexPath.section].goodsitem[indexPath.row]
        cell.cellCallBack = {(sender,CartCellCallEnum) -> Void in
         
            switch CartCellCallEnum {
            case .CartCellActionEnumSel:
                self.CartCallBack!(sender, .CallEnumSelProduct)
            case .CartCellActionEnumplus:
                self.CartCallBack!(sender, .CartCallEnumPlus)
            case .CartCellActionEnumMinus:
                self.CartCallBack!(sender, .CartCallEnumMinus)
            default:
                uLog("CartCellCallEnum error")
            }
            
        }
        return cell
    }
    
    lazy var TableView: UITableView = {
        var tb = UITableView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-64-50), style:.plain)
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(UITableViewCell.self , forCellReuseIdentifier: "ID")
        
        return tb
    }()
    
    lazy var FootBar = ShopCartFootBar().then { (make) in
        make.frame = CGRect(x: 0, y: screenHeight-64-50, width: screenWidth, height: 50)
    }
}
