//
//  TRALoginView.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit


class TRALoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        
        self.sd_addsubViews(subviews: [icon,theLoginView,thePWView,theBtn])
        
        icon.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.width.equalTo(230)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(135)
        }
        
        theLoginView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(icon.snp.bottom).offset(70)
            make.height.equalTo(45)
        }
        
        thePWView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(theLoginView.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        theBtn.snp.makeConstraints { (make) in
            make.width.equalTo(kFitW(300))
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(thePWView.snp.bottom).offset(50)
            make.height.equalTo(kFitW(45))
        }
    }
    
    lazy var icon: UIImageView = {
        var make = UIImageView()
        make.image = #imageLiteral(resourceName: "tralogo")
        return make
    }()
    
    lazy var theLoginView : TRALoginTextView = {
        var make = TRALoginTextView()
        make.labelLeft.text = "账号"
        make.textFRight.placeholder = "请输入账号"
        make.textFRight.keyboardType = .emailAddress
        return make
    }()
    
    lazy var thePWView : TRALoginTextView = {
        var make = TRALoginTextView()
        make.labelLeft.text = "密码"
        make.textFRight.placeholder = "请输入密码"
        make.textFRight.isSecureTextEntry = true
        return make
    }()
    
    lazy var theBtn: UIButton = {
        var make = UIButton()
        make.setTitle("登录", for: .normal)
        make.backgroundColor = .theme
        make.layer.cornerRadius = 20
        return make
    }()
    
    
    
}
