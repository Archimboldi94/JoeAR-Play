//
//  ShopCartHeader.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/15.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

typealias CartHeadCallBlock = (_ sender: Any)->()

class ShopCartHeader: UIView {

    var HeadCallBack: CartHeadCallBlock?
    
    var shop_id: String = ""
    
    var model: CartShopModel? {
        didSet{
            guard let model = model else { return }
            shop_id        = model.shop_id!
            shop_name.text = model.shop_name
            (model.shop_sel == true) ? (selBtn.isSelected = true) : (selBtn.isSelected = false)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selAction(sender: Any) {
        if self.HeadCallBack != nil {
            self.HeadCallBack!(shop_id)
        }
    }
    
    //选择按钮
    lazy var selBtn = UIButton().then { (make) in
        let img_n = UIImage.init(named: "quan")
        let img_s = UIImage.init(named: "Success")
        make.setImage(img_n, for: .normal)
        make.setImage(img_s, for: .selected)
        make.addTarget(self, action: #selector(selAction(sender:)), for: .touchUpInside)
    }
    //icon
    lazy var shop_icon = UIImageView().then { (make) in
        make.image = #imageLiteral(resourceName: "house")
    }
    //店铺名
    lazy var shop_name = UILabel().then { (make) in
        make.text =  "店铺名"
        make.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func configUI() {
        
        backgroundColor = .white
        sd_addsubViews(subviews: [selBtn,shop_icon,shop_name])
        selBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(27)
            make.left.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        shop_icon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(selBtn.snp.right).offset(15)
            make.width.height.equalTo(20)
        }
        shop_name.snp.makeConstraints { (make) in
            make.centerY.equalTo(shop_icon.snp.centerY)
            make.left.equalTo(shop_icon.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    
}
