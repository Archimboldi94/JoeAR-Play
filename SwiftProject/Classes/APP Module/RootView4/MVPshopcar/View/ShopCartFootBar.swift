//
//  ShopCartFootBar.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/16.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

enum CartBarCallEnum {
    case CartBarActionEnumSel
    case CartBarActionEnumSub
}

typealias CartBarlCallBlock = (_ sender: Any, _ actionEnum: CartBarCallEnum)->()

class ShopCartFootBar: UIView {

    var barCallBlock: CartBarlCallBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        sd_addsubViews(subviews: [selectBtn,totalMoneyLabel,submitBtn])
        selectBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.height.equalTo(25)
            make.top.equalTo(15)
        }
        submitBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.bottom.equalTo(self)
            make.width.equalTo(100)
        }
        totalMoneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(selectBtn.snp.right).offset(40)
            make.centerY.equalTo(submitBtn.snp.centerY)
            make.right.equalTo(submitBtn.snp.left)
            make.height.equalTo(30)
        }
    }
    
    @objc func selAction(sender: Any) {
        if self.barCallBlock != nil {
//            self.barCallBlock!(good_id, .CartCellActionEnumSel)
        }
    }
    
    //商品选择按钮
    lazy var selectBtn = UIButton().then { (make) in
        let img_n = UIImage.init(named: "quan")
        let img_s = UIImage.init(named: "Success")
        make.setImage(img_n, for: .normal)
        make.setImage(img_s, for: .selected)
//        make.addTarget(self, action: #selector(selAction(sender:)), for: .touchUpInside)
    }
    //总金额label
    lazy var totalMoneyLabel = UILabel().then { (make) in
        make.font = UIFont.systemFont(ofSize: 14)
    }
    //提交按钮
    lazy var submitBtn = UIButton().then { (make) in
        KSetButton(btn: make, img: nil, fontcolor: .white, bgcolor: .blue, fontsize: 15, str: "结算")
    }
    
    
}
