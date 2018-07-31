//
//  ORSCartPresent.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/14.
//  Copyright © 2018年 KJ. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift


let scartCellSubject = PublishSubject<[String]>()

class CartPresent: NSObject {
    
    var cartDataArray: [CartShopModel] = []
 
    //
    func myFunction(goods_id: String, callBlock: ([CartShopModel]) -> Void) {
        callBlock(cartDataArray)
    }
    //选择具体商品
    func selGoods(goods_id: String, callBlock: ([CartShopModel]) -> Void) {
        cartDataArray = cartDataArray.map { make in
            var oneShop: CartShopModel = make
            var goodsSelArray: Array<Bool> = []
            let goodsArray:[CartGoodsModel] = oneShop.goodsitem.map{ make2 in
                var oneGood: CartGoodsModel = make2
                if goods_id == oneGood.good_id{
                     oneGood.good_sel = !oneGood.good_sel
                }
                if !(goodsSelArray.contains(oneGood.good_sel)){
                    goodsSelArray.append(oneGood.good_sel)
                }
                return oneGood
            }
            
            if goodsSelArray.count == 1{
               oneShop.shop_sel = goodsSelArray[0]
            }else{
                oneShop.shop_sel = false
            }
           
            oneShop.goodsitem = goodsArray
            return oneShop
        }
        
        callBlock(cartDataArray)
    }
    //选择组
    func selShops(shop_id: String, callBlock: ([CartShopModel]) -> Void) {
        cartDataArray = cartDataArray.map { make in
            var oneShop: CartShopModel = make
            if shop_id == oneShop.shop_id{
                oneShop.shop_sel = !oneShop.shop_sel
            }
            
            let goodsArray:[CartGoodsModel] = oneShop.goodsitem.map{ make2 in
                var oneGood: CartGoodsModel = make2
                oneGood.good_sel = oneShop.shop_sel
                return oneGood
            }
            oneShop.goodsitem = goodsArray
            
            return oneShop
        }
        callBlock(cartDataArray)
    }
    //全选
    func selAll(goods_id: String, callBlock: ([CartShopModel]) -> Void) {
        callBlock(cartDataArray)
    }
    //加数量
    func plusGoods(goods_id: String, callBlock: ([CartShopModel]) -> Void) {
        
       cartDataArray = cartDataArray.map { make in
            var oneShop: CartShopModel = make
            let goodsArray:[CartGoodsModel] = oneShop.goodsitem.map{ make2 in
                var oneGood: CartGoodsModel = make2
                if goods_id == oneGood.good_id{
                    oneGood.good_num += 1
                    uLog("oneGood.good_num == \(String(describing: oneGood.good_num ))")
                }
                return oneGood
            }
            oneShop.goodsitem = goodsArray
            return oneShop
        }
        
        callBlock(cartDataArray)
    }
    //减数量
    func minusGoods(goods_id: String, callBlock: ([CartShopModel]) -> Void) {
        cartDataArray = cartDataArray.map { make in
            var oneShop: CartShopModel = make
            let goodsArray:[CartGoodsModel] = oneShop.goodsitem.map{ make2 in
                var oneGood: CartGoodsModel = make2
                if goods_id == oneGood.good_id{
                    if oneGood.good_num <= 1{
                        uLog("请至少选择一件商品")
                    }else{
                        oneGood.good_num -= 1
                    }
                    uLog("oneGood.good_num == \(String(describing: oneGood.good_num ))")
                }
                return oneGood
            }
            oneShop.goodsitem = goodsArray
            return oneShop
        }
        
        callBlock(cartDataArray)
    }
    //删除商品
    func delGoods(goods_id: String, callBlock: ([CartShopModel]) -> Void) {
        callBlock(cartDataArray)
    }
    //获取总金额
    func getTotalPrice(goods_id: String, callBlock: (Double) -> Void) {
        callBlock(0932313)
    }
    //获取确定好的商品
    func getComfirmProductsCallBack(goods_id: String, callBlock: ([CartShopModel]) -> Void) {
        callBlock(cartDataArray)
    }
}

extension CartPresent {
    //从网络获取数据
    func getDataNet() {
        let  cartNetDataArray = [
            ["shop_name" : "kaka乐器店",
             "shop_id"   : "12",
             "goodsitem" : [
                ["good_name" : "小提琴",
                 "good_price": 200,
                 "good_num"  : 12,
                 "good_id"   : "11"],
                ["good_name" : "大提琴",
                 "good_price": 300,
                 "good_num"  : 11,
                 "good_id"   : "22"],
                ["good_name" : "钢琴",
                 "good_price": 500,
                 "good_num"  : 11,
                 "good_id"   : "42"]
                ]
            ],
            ["shop_name" : "pipi乐器仿",
             "shop_id"   : "11",
             "goodsitem" : [
                ["good_name" : "二胡",
                 "good_price": 100,
                 "good_num"  : 2,
                 "good_id"   : "10"],
                ["good_name" : "琵琶",
                 "good_price": 210,
                 "good_num"  : 22,
                 "good_id"   : "89"],]
            ],
            ["shop_name" : "UU音乐店",
             "shop_id"   : "10",
             "goodsitem" : [
                ["good_name" : "竖琴",
                 "good_price": 200,
                 "good_num"  : 6,
                 "good_id"   : "77"],
                ["good_name" : "小号",
                 "good_price": 50,
                 "good_num"  : 8,
                 "good_id"   : "66"],
                ["good_name" : "尤克里里",
                 "good_price": 500,
                 "good_num"  : 1,
                 "good_id"   : "53"]
                ]
            ]
        ]
      
        //字典数组转模型数组
        //1.字典数组转 Data (系统)
        let cartdata = try? JSONSerialization.data(withJSONObject: cartNetDataArray, options: JSONSerialization.WritingOptions.prettyPrinted)
        //2.Data 转 Json (SwiftyJSON https://tangplin.github.io/swiftyjson/)
        let json = try? JSON(data: cartdata!)
        //3.Json 转 模型数组 (HandyJSON https://github.com/alibaba/HandyJSON/blob/master/README_cn.md#json%E6%95%B0%E7%BB%84)
        let stringstr = json?.rawString()
        uLog("stringstr == \(String(describing: stringstr))")
        if let modelArray = [CartShopModel].deserialize(from: stringstr){
            modelArray.forEach({ (model) in
                print("modelhaha == \(String(describing: model?.shop_name))")
            })
            cartDataArray = modelArray as! [CartShopModel]
        }
         
    }
    
}
