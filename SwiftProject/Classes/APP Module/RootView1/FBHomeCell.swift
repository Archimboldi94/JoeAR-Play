//
//  FBHomeCell.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/2/28.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class FBHomeCell: UITableViewCell {
    
  
    
    var model: FireBallHomeMdeol?{
        didSet{
            guard let model = model else { return  }
            
//            var good_image: String?
//            var good_title: String?
//            var user_name: String?
//            var user_icon: String?
//            var user_typeicon: String?
            good_img.kf.setImage(urlString: model.good_image)
            good_title.text = model.good_title
            user_icon.kf.setImage(urlString: model.user_icon)
            user_name.text = model.user_name
//            if model.user_name == "凤凰台上凤凰游" {
                user_typeicon.isHidden = false
//            }else{
//                user_typeicon.isHidden = true
//            }
 
        }
    }
    
    
    //用户头像
    lazy var user_icon: UIImageView = {
        var ui = UIImageView()
        //  把图片设置成圆形
        ui.layer.cornerRadius = 14;//裁成自身尺寸的一半
        ui.layer.masksToBounds = true;//隐藏裁剪掉的部分
        ui.isSkeletonable = true
        ui.image = #imageLiteral(resourceName: "girl")
        return ui
    }()
    //用户姓名
    lazy var user_name: UILabel = {
        var un = UILabel()
        KSetLabel(label: un, color: .fontGrey, fontsize: 14, alignment: .left, str: "K-Joe")
        un.adjustsFontSizeToFitWidth = true
        un.isSkeletonable = true
        return un
    }()
    //用户身份标识
    lazy var user_typeicon: UIImageView = {
        var ut = UIImageView()
        ut.image = #imageLiteral(resourceName: "vip")
        ut.isHidden = true
        return ut
    }()
    //"更多"按钮
    lazy var more_btn: UIButton = {
        var mb = UIButton()
        KSetButton(btn: mb, img: "more", fontcolor: nil, bgcolor: .white, fontsize: 1, str: nil)
        return mb
    }()
    //商品图片
    lazy var good_img: UIImageView = {
        var gi = UIImageView()
        gi.layer.cornerRadius = 7;//裁成自身尺寸的一半
        gi.layer.masksToBounds = true;//隐藏裁剪掉的部分
//        gi.contentMode = .scaleAspectFit
        gi.isSkeletonable = true
        gi.kf.setImage(urlString:"https://upload-images.jianshu.io/upload_images/1861592-43d2f8b1b7c25213.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700", placeholder: placeholder)
        return gi
    }()
    
    lazy var placeholder: UIImage = {
        var pr = UIImage()
        pr = #imageLiteral(resourceName: "jiake")
        return pr
    }()
    //商品标题
    lazy var good_title: UILabel = {
        var gt = UILabel()
        KSetLabel(label: gt, color: .black, fontsize: 16, alignment: .left, str: "男女同款 | 天暖宜脱衣, 记得套上教练夹克就行 \n[K-Joe 墙裂推荐]")
        gt.isSkeletonable = true
        gt.numberOfLines = 0
        return gt
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //创建UI
//        self.InitUI()
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        layoutUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //布局
    func layoutUI() {
        
        let cell_padding : CGFloat = 20
        
        
        
        contentView.addSubview(user_icon)
        user_icon.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(cell_padding)
            make.width.height.equalTo(28)
            make.left.equalTo(cell_padding)
        }
        contentView.addSubview(user_name)
        user_name.snp.makeConstraints { (make) in
            make.left.equalTo(user_icon.snp.right).offset(8)
            make.centerY.height.equalTo(user_icon)
//            make.
        }
        contentView.addSubview(user_typeicon)
        user_typeicon.snp.makeConstraints { (make) in
            make.left.equalTo(user_name.snp.right).offset(8)
            make.centerY.equalTo(user_name)
            make.width.height.equalTo(13)
        }
        contentView.addSubview(more_btn)
        more_btn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-cell_padding)
            make.width.equalTo(15)
            make.height.equalTo(10)
            make.centerY.equalTo(user_icon)
        }
        contentView.addSubview(good_img)
        good_img.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth - 2*cell_padding)
            make.height.equalTo((screenWidth - 2*cell_padding)/2)
            make.top.equalTo(user_icon.snp.bottom).offset(20)
        }
        contentView.addSubview(good_title)
        good_title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth - 2*cell_padding)
            make.top.equalTo(good_img.snp.bottom).offset(8)
            make.bottom.equalTo(contentView).offset(-15)
        }
    }
 
    @objc func Actionbuton() {
        print("点击了label")
    }
    
    
}

