//
//  ShopCartCell.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/14.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import RxSwift

enum CartCellCallEnum {
    case CartCellActionEnumSel
    case CartCellActionEnumMinus
    case CartCellActionEnumplus
}

typealias CartCellCallBlock = (_ sender: Any, _ actionEnum: CartCellCallEnum)->()

class ShopCartCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var cellCallBack: CartCellCallBlock?
    var good_id: String = ""
    
    var model: CartGoodsModel? {
        didSet{
        guard let model = model else { return }
            good_id         = model.good_id!
            good_name.text  = model.good_name
            good_price.text = "\(model.good_price ?? 0)"
            good_num.text   = "\(model.good_num)"
            (model.good_sel == true) ? (selectBtn.isSelected = true) : (selectBtn.isSelected = false)
//            _ = dingyue
        }
    }
    
    lazy var dingyue: Void = {
        uLog("我是了订阅 我是cell\(String(describing: model?.good_id!))")
        
        scartCellSubject.subscribe(onNext: { StrArr in
            let sub_id:String = StrArr[0]
            let sub_sel:String = StrArr[1]
            if sub_id == self.model?.good_id {
                (sub_sel == "true") ? (self.model?.good_sel = false) : (self.model?.good_sel = true)
                uLog("我的id\(sub_id) sub_sel== \(sub_sel)" )
                (self.model?.good_sel)! ? uLog("选择了") : uLog("没选中")
                uLog("cell里收到了")
            }
            
        }, onCompleted:{
            print("onCompleted")
        }).disposed(by: disposeBag)
        
    }()
    
    //MARK: - 事件
    @objc func selAction(sender: Any) {
        if self.cellCallBack != nil {
            self.cellCallBack!(good_id, .CartCellActionEnumSel)
        }
    }
    
    @objc func plusAction(sender: Any) {
        if self.cellCallBack != nil {
            self.cellCallBack!(good_id, .CartCellActionEnumplus)
        }
    }
    
    @objc func minusAction(sender: Any) {
        if self.cellCallBack != nil {
            self.cellCallBack!(good_id, .CartCellActionEnumMinus)
        }
    }
    
    //MARK: - 入口
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        layer.shouldRasterize = true //优化渲染
        layer.rasterizationScale = UIScreen.main.scale
        
        configUI()
        
      
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI样式
    //商品选择按钮
    lazy var selectBtn = UIButton().then { (make) in
        let img_n = UIImage.init(named: "quan")
        let img_s = UIImage.init(named: "Success")
        make.setImage(img_n, for: .normal)
        make.setImage(img_s, for: .selected)
        make.addTarget(self, action: #selector(selAction(sender:)), for: .touchUpInside)
    }
    //商品图片
    lazy var good_img = UIImageView().then { (make) in
        make.image = UIImage.init(named: "jiake")
    }
    //商品名字
    lazy var good_name = UILabel().then { (make) in
        make.numberOfLines = 2
        make.font = UIFont.systemFont(ofSize: 14)
        make.text = "我是名字"
    }
    //商品价格
    lazy var good_price = UILabel().then { (make) in
        make.text = "$100"
        make.font = UIFont.systemFont(ofSize: 14)
    }
    //商品数量
    lazy var good_num = UILabel().then { (make) in
        make.text = "20"
        make.textAlignment = .center
        make.font = UIFont.systemFont(ofSize: 14)
    }
    //加号
    lazy var plusBtn = UIButton().then { (make) in
        make.setTitle("+", for: .normal)
        make.backgroundColor = .gray
        make.addTarget(self, action: #selector(plusAction(sender:)), for: .touchUpInside)
    }
    //减号
    lazy var minusBtn = UIButton().then { (make) in
        make.setTitle("-", for: .normal)
        make.backgroundColor = .gray
        make.addTarget(self, action: #selector(minusAction(sender:)), for: .touchUpInside)
    }
    
    private func configUI() {
        contentView .sd_addsubViews(subviews: [selectBtn,good_img,good_name,good_price,good_num,plusBtn,minusBtn])
        
        good_img.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(70)
            make.width.height.equalTo(100)
            make.bottom.equalTo(contentView).offset(-20)
        }
        selectBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.height.equalTo(27)
            make.centerY.equalToSuperview()
        }
        good_name.snp.makeConstraints { (make) in
            make.left.equalTo(good_img.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(good_img)
        }
        good_price.snp.makeConstraints { (make) in
            make.left.equalTo(good_img.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(good_name.snp.bottom).offset(20)
        }
        good_num.snp.makeConstraints { (make) in
            make.centerX.equalTo(good_name)
            make.width.equalTo(130)
            make.top.equalTo(good_price.snp.bottom).offset(20)
        }
        plusBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.top.equalTo(good_price.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        minusBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.top.equalTo(good_price.snp.bottom).offset(20)
            make.left.equalTo(good_img.snp.right).offset(20)
        }
    }
    
}
