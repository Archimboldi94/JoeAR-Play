//
//  TRAHomeCellType1.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit


/// 左侧灰紫色的cell 
class TRAHomeCellType1: JoeTableViewCell {

    override func configUI() {
        
        contentView.sd_addsubViews(subviews: [theBackGround, theTriangle])
        theBackGround.sd_addsubViews(subviews: [theTopLabel, theContentLabel1, theContentLabel2, theContentLabel3, theContentLabel4, theBottomLabel, theLineLabel1, theLineLabel2, theLineLabel3])
        
        theBackGround.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.bottom.equalTo(-3)
        }
        
        theTriangle.snp.makeConstraints { (make) in
            make.width.height.equalTo(8)
            make.centerX.equalTo(theBackGround.snp.left)
            make.top.equalTo(theBackGround.snp.top).offset(15)
        }
        
        theTopLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(15)
        }
        
        theContentLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(35)
            make.left.equalTo(15)
        }
        
        theLineLabel1.snp.makeConstraints { (make) in
            make.centerY.equalTo(theContentLabel1.snp.centerY)
            make.left.equalTo(theContentLabel1.snp.right).offset(3)
        }
        
        theContentLabel2.snp.makeConstraints { (make) in
            make.centerY.equalTo(theContentLabel1.snp.centerY)
            make.left.equalTo(theLineLabel1.snp.right).offset(3)
        }
        theLineLabel2.snp.makeConstraints { (make) in
            make.centerY.equalTo(theContentLabel1.snp.centerY)
            make.left.equalTo(theContentLabel2.snp.right).offset(3)
        }
        
        theContentLabel3.snp.makeConstraints { (make) in
            make.centerY.equalTo(theContentLabel1.snp.centerY)
            make.left.equalTo(theLineLabel2.snp.right).offset(3)
        }
        
        theLineLabel3.snp.makeConstraints { (make) in
            make.centerY.equalTo(theContentLabel1.snp.centerY)
            make.left.equalTo(theContentLabel3.snp.right).offset(3)
        }
        
        theContentLabel4.snp.makeConstraints { (make) in
            make.centerY.equalTo(theContentLabel1.snp.centerY)
            make.left.equalTo(theLineLabel3.snp.right).offset(3)
        }
        
        theBottomLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-7)
            make.right.equalTo(-13)
        }
        
    }
 
    lazy var theBackGround: UIView = {
        var make = UIView()
        make.layer.cornerRadius = 8
        make.backgroundColor = .theme2
        return make
    }()
    
    lazy var theTriangle: UIView = {
        var make = UIView()
        make.layer.cornerRadius = 1
        make.backgroundColor = .theme2
        make.transform = CGAffineTransform(rotationAngle: .pi/4);
        return make
    }()
    
    lazy var theTopLabel: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 15)
        make.textColor = .fontMain
        make.text = "你好"
        return make
    }()
    
    lazy var theBottomLabel: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 13)
        make.textColor = .fontMain
        make.text = "汉英词典 >"
        return make
    }()
    
    lazy var theContentLabel1: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 14)
        make.textColor = .fontMain
        make.text = "hello"
        return make
    }()
    
    lazy var theContentLabel2: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 14)
        make.textColor = .fontMain
        make.text = "howday"
        return make
    }()
    
    lazy var theContentLabel3: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 14)
        make.textColor = .fontMain
        make.text = "hiya"
        return make
    }()
    
    lazy var theContentLabel4: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 14)
        make.textColor = .fontMain
        make.text = "g'day"
        return make
    }()
    
    lazy var theLineLabel1: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 14)
        make.textColor = .fontMain
        make.text = "/"
        return make
    }()
    
    lazy var theLineLabel2: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 14)
        make.textColor = .fontMain
        make.text = "/"
        return make
    }()
    
    lazy var theLineLabel3: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 14)
        make.textColor = .fontMain
        make.text = "/"
        return make
    }()
    
    
    
    
}
