//
//  TRALoginTextView.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit


class TRALoginTextView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        
        backgroundColor = .white
        
        self.sd_addsubViews(subviews: [labelLeft,textFRight])
        
        labelLeft.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(5)
            make.width.equalTo(60)
            //make.height.equalTo(25)
        }
        
        textFRight.snp.makeConstraints { (make) in
            make.left.equalTo(labelLeft.snp.right).offset(10)
            make.right.equalTo(-20)
            make.centerY.equalTo(labelLeft.snp.centerY).offset(1)
            make.height.equalTo(23)
        }
        
        let line = UIImageView()
        self.addSubview(line)
        line.backgroundColor = .groundTab
        line.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(20)
            make.height.equalTo(1)
            make.top.equalTo(labelLeft.snp.bottom).offset(15)
        }
        
 
    }
    
    lazy var labelLeft: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .fontMain
        return label
    }()

    lazy var textFRight: UITextField = {
        var tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .fontMain
        return tf
    }()
    
}
