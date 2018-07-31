//
//  GitHubModel.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/5/2.
//  Copyright © 2018年 KJ. All rights reserved.
//

import Foundation
import HandyJSON

struct GitHubRepositories: HandyJSON {
    var totalCount: Int!
    var incompleteResults: Bool!
    var items: [GitHubRepository]! //本次查询返回的所有仓库集合
    
    //required init() {}
}

//单个仓库模型
struct GitHubRepository: HandyJSON {
    var id: Int!
    var name: String!
    var fullName:String!
    var htmlUrl:String!
    var description:String!
    
    //required init() {}
}
