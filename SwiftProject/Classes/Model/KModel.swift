//
//  KModel.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/2.
//  Copyright © 2018年 KJ. All rights reserved.
//

import Foundation
//import HandyJSON
import RxSwift
//
//
//class FireBallHomeMdeol: HandyJSON {
//    var good_image: String?
//    var good_title: String?
//    var user_name: String?
//    var user_icon: String?
//    var user_typeicon: String?
//
//    required init() {}
//}
//
//class RxtestModel: HandyJSON {
//
//    //用户名
//    let username = Variable("guest")
//
//    //用户信息
//    lazy var userinfo = {
//        return self.username.asObservable()
//            .map{ $0 == "hangge" ? "您是管理员" : "您是普通访客" }
//            .share(replay: 1)
//    }()
//    var name: String = "张三"
//
//    required init() {}
//}
//
//struct UserViewModel: HandyJSON {
//    //用户名
//    let username = Variable("双向绑定")
//
////    let username: String = "K-Joe"
//    //用户信息
////    lazy var userinfo = username
//    lazy var userinfo = {
//        return self.username.asObservable()
////            .map{ $0 == "kj" ? "您是管理员" : "您是普通访客" }
//            .share(replay: 1)
//    }()
//}
//
//struct goodsModel: HandyJSON {
////    var good_price: Double?
//    var good_name: String?
//}
//
//struct shopModel: HandyJSON {
//    var goodsitem: Array<goodsModel> = []
//    var shop_name: String?
//}
//
//
