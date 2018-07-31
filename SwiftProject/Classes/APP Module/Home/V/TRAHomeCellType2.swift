//
//  TRAHomeCellType2.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit


/// 右侧紫色的cell 
class TRAHomeCellType2: JoeTableViewCell {

    override func configUI() {
        
        contentView.sd_addsubViews(subviews: [theBackGround, theTriangle, theIcon])
        theBackGround.sd_addsubViews(subviews: [theTopLabel, theLine, theBottomLabel
            ])
        
        theBackGround.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.width.equalTo(170)
            make.height.equalTo(80)
            make.top.equalTo(10)
            make.bottom.equalTo(-3)
        }
        
        theTriangle.snp.makeConstraints { (make) in
            make.width.height.equalTo(8)
            make.centerX.equalTo(theBackGround.snp.right)
            make.top.equalTo(theBackGround.snp.top).offset(15)
        }
        
        theTopLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(theBackGround.snp.centerX)
            make.top.equalTo(15)
        }
        
        theLine.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(1)
            make.centerY.equalTo(theBackGround.snp.centerY)
        }
        
        theBottomLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(theBackGround.snp.centerX)
            make.bottom.equalTo(-15)
        }
        
        theIcon.snp.makeConstraints { (make) in
            make.right.equalTo(theBackGround.snp.left).offset(-12)
            make.width.equalTo(20)
            make.height.equalTo(30)
            make.bottom.equalTo(theBackGround.snp.bottom).offset(-2)
        }
    }
    
    lazy var theBackGround: UIView = {
        var make = UIView()
        make.layer.cornerRadius = 8
        make.backgroundColor = .theme
        return make
    }()
    
    lazy var theTriangle: UIView = {
        var make = UIView()
        make.layer.cornerRadius = 1
        make.backgroundColor = .theme
        make.transform = CGAffineTransform(rotationAngle: .pi/4);
        return make
    }()
    
    lazy var theTopLabel: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 15)
        make.textColor = .white
        make.text = "你好"
        return make
    }()
    
    lazy var theBottomLabel: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 15)
        make.textColor = .white
        make.text = "我怎么会"
        return make
    }()
    
    lazy var theLine: UIView = {
        var make = UIView()
        make.backgroundColor = .white
        return make
    }()
    
    lazy var theIcon: UIImageView = {
        var make = UIImageView()
        make.image = #imageLiteral(resourceName: "gendu")
        return make
    }()

}
