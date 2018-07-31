//
//  TRAMoreCollectionViewCell.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/26.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class TRAMoreCollectionViewCell: JoeCollectionViewCell {
    
    override func configUI() {
        
        contentView.backgroundColor = .white
        
        contentView.sd_addsubViews(subviews: [theIcon, theLable1, theLable2])
        
        theIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        theLable1.snp.makeConstraints { (make) in
            make.left.equalTo(theIcon.snp.right).offset(15)
            make.right.equalTo(-15)
            make.top.equalTo(20)
        }
        
        theLable2.snp.makeConstraints { (make) in
            make.left.equalTo(theIcon.snp.right).offset(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-20)
        }
        
    }
    
    lazy var theIcon: UIImageView = {
        var make = UIImageView()
        make.image = UIImage.init(named: "jiake")
        make.contentMode = .scaleAspectFill
        make.layer.masksToBounds = true
        make.layer.cornerRadius = 25
        
        
        return make
    }()
    
    lazy var theLable1: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 16)
        make.text = "深思每幕 醇美渐现 不需花巧却能触碰"
        return make
    }()
    
    lazy var theLable2: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 14)
        make.textColor = .fontGrey
        make.text = "赏深细味 夕昼共渡 细味每段爱与怒"
        return make
    }()
}
