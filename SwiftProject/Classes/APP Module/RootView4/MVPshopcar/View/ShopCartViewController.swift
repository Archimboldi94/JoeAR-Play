//
//  ShopCartViewController.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/14.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class ShopCartViewController: UBaseViewController {

    override func configUI() {
        super.configUI()
        title = "购物车"
        
        theTableView.CartCallBack = {[weak self] (sender,CartCallEnum) -> Void in
            switch CartCallEnum {
            case .CartCallEnumSelall:
                uLog("\(sender)\(CartCallEnum)")
            case .CartCallEnumSelGroup:
                self?.theCartPresent.selShops(shop_id: sender as! String, callBlock: { (newData) in
                    self?.theTableView.shopModelArray = newData
                    self?.theTableView.TableView.reloadData()
                })
            case .CallEnumSelProduct:
                self?.theCartPresent.selGoods(goods_id: sender as! String, callBlock: { (newData) in
                    self?.theTableView.shopModelArray = newData
                    self?.theTableView.TableView.reloadData()
                })
            case .CartCallEnumMinus:
                self?.theCartPresent.minusGoods(goods_id: sender as! String, callBlock: { (newData) in
                    self?.theTableView.shopModelArray = newData
                    self?.theTableView.TableView.reloadData()
                })
            case .CartCallEnumPlus:
                self?.theCartPresent.plusGoods(goods_id: sender as! String, callBlock: { (newData) in
                    self?.theTableView.shopModelArray = newData
                    self?.theTableView.TableView.reloadData()
                })
            case .CartCallEnumDel:
                uLog("\(sender)\(CartCallEnum)")
            case .CallEnumConfirm:
                uLog("\(sender)\(CartCallEnum)")
            default:
                uLog("CartCallEnum error")
            }
        }
        view.addSubview(theTableView)
        
        theCartPresent.getDataNet()
 
//        theCartPresent.myFunction("1") { (make) in
//            uLog("testBlack == \(make)")
//        }
        
        theTableView.shopModelArray = theCartPresent.cartDataArray
        theTableView.TableView.reloadData()
    }
 
    var theTableView = ShopCartTableview().then { (make) in
        make.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight )
    }
    
    lazy var theCartPresent = CartPresent().then { (make) in}
    
}
