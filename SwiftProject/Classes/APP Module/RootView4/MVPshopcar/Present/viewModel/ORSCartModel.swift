//
//  ORSCartModel.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/14.
//  Copyright © 2018年 KJ. All rights reserved.
//

import Foundation
import HandyJSON

struct CartBigModel: HandyJSON {
    var allMoney: Double?
    var shopsitem: Array<CartShopModel> = []
    var all_sel: Bool?
}

struct CartShopModel: HandyJSON {
    var goodsitem: Array<CartGoodsModel> = []
    var shop_name: String?
    var shop_sel: Bool = false
    var shop_id: String?
}

struct CartGoodsModel: HandyJSON {
    var good_price: Double?
    var good_num: Int = 0
    var good_name: String?
    var good_sel: Bool = false
    var good_id: String?
}


