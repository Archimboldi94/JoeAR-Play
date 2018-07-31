//
//  TRAHomeView.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import SnapKit

class TRAHomeView: UIView {
    
    
    var theDataArr = [Int]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        
        backgroundColor = .white
        
        sd_addsubViews(subviews: [tableView, theBtnImage, theLeftBtn, theRightBtn]) 
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(-60)
        }
        
        theBtnImage.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-10)
            make.top.equalTo(tableView.snp.bottom)
        }
        
        theLeftBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.width.equalTo(screenWidth/2)
            make.top.equalTo(tableView.snp.bottom)
        }
        
        theRightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(-10)
            make.width.equalTo(screenWidth/2)
            make.top.equalTo(tableView.snp.bottom)
        }
        
       
    }
 
    //MARK: - GET
    
    var bottomConstraint:Constraint?
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = .background
        tw.delegate = self
        tw.dataSource = self
        tw.separatorStyle = .none
        tw.estimatedRowHeight = 50
        tw.rowHeight = UITableViewAutomaticDimension
        tw.register(cellType: TRAHomeCellType1.self)
        tw.register(cellType: TRAHomeCellType2.self)
        tw.register(cellType: TRAHomeCellType3.self)
        let footer = URefreshBackNormalFooter()
        tw.mj_footer = footer
        return tw
    }()
    
    private lazy var theBtnImage: UIImageView = {
        let make = UIImageView()
        make.image = #imageLiteral(resourceName: "button")
        return make
    }()
    
    lazy var theLeftBtn: UIButton = {
        let make = UIButton()
        make.setTitle("", for: .normal)
        make.backgroundColor = .clear
        return make
    }()

    lazy var theRightBtn: UIButton = {
        let make = UIButton()
        make.setTitle("", for: .normal)
        make.backgroundColor = .clear
        return make
    }()
    
    lazy var theVoiceView: TRAHomeVoiceView = {
        let make = TRAHomeVoiceView()
        make.isUserInteractionEnabled = true
        return make
    }()
 
}

extension TRAHomeView: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aMark = theDataArr[indexPath.row]
        switch aMark {
        
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TRAHomeCellType1.self)
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TRAHomeCellType2.self)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TRAHomeCellType3.self)
            return cell
            
        default:
            uLog("aMark error")
            return JoeTableViewCell()
        }
         
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        uLog("indexPath.row == \(indexPath.row)")
    }
}
