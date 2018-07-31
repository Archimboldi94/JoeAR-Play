//
//  TRAHomeViewModel.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit


class TRAHomeViewModel: NSObject {

    let theView = TRAHomeView()
    
    //左侧灰cell为1, 右侧紫cell为2, 右侧轮播cell为3
    var theDataArr : Array<Int> = [1, 3, 2, 2, 2, 1]
    
    lazy var hideGesture: UITapGestureRecognizer = {
        let make = UITapGestureRecognizer(target: self, action: #selector(removeAnimate(_:)))
        return make
    }()
    
    override init() {
        super.init()
        
        theView.theDataArr = theDataArr
        theView.tableView.reloadData()
        
        setEvent()
    }
    
    
    
    //MARK: - Event
    
    private func setEvent() {
        
        theView.theLeftBtn.addTarget(self, action: #selector(BtnClick), for: .touchUpInside)
        theView.theRightBtn.addTarget(self, action: #selector(BtnClick), for: .touchUpInside)
        theView.tableView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadData))
    }
    
    @objc private func BtnClick() {
        showAnimate()
    }
    
    @objc private func loadData() {
        sleep(2)
        theView.tableView.mj_footer.endRefreshing()
    }
    
    func showAnimate() {
        
        theView.tableView.addGestureRecognizer(hideGesture)
        
        _ = firstShow
        
        theView.theVoiceView.snp.updateConstraints({ (make) in
            make.bottom.equalTo(0)
        })
        
        UIView.animate(withDuration: 0.5) {
            self.theView.layoutIfNeeded()
        }
        
    }
    
    lazy var firstShow: Void = {
        theView.addSubview(theView.theVoiceView)
        theView.theVoiceView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(300)
            make.height.equalTo(270)
        }
        theView.layoutIfNeeded()
    }()
    
    @objc func removeAnimate(_ recognizer: UITapGestureRecognizer){
        
        theView.tableView.removeGestureRecognizer(hideGesture)
        
        theView.theVoiceView.snp.updateConstraints({ (make) in
            make.bottom.equalTo(300)
        })
        
        UIView.animate(withDuration: 0.5) {
            self.theView.layoutIfNeeded()
        }
        
    }
    
}


extension TRAHomeViewModel {
    
    func setHomeNav() {
        
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "gerenzhongxin"), for: .normal)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 28)
        let btnItem = UIBarButtonItem(customView: leftBtn)
        leftBtn.addTarget(self, action: #selector(pushTRAMoreVC), for: .touchUpInside)
        topVC?.navigationItem.leftBarButtonItem = btnItem
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: "list"), for: .normal)
        rightBtn.frame = CGRect(x: -10, y: -8, width: 50, height: 25)
        let btnItem2 = UIBarButtonItem(customView: rightBtn)
        topVC?.navigationItem.rightBarButtonItem = btnItem2
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
 
        let textF = UITextField()
        textF.placeholder = "    查单词或翻译句子"
        textF.backgroundColor = .theme2
        textF.isEnabled = false
        textF.font = UIFont.systemFont(ofSize: 14)
        textF.frame = CGRect(x: 0, y: 0, width: 157, height: 30)
        textF.layer.cornerRadius = 4
        titleView.addSubview(textF)
        
        let photoBtn = UIButton()
        photoBtn.setImage(UIImage(named: "camre"), for: .normal)
        photoBtn.frame = CGRect(x: 163, y: 0, width: 30, height: 30)
        titleView.addSubview(photoBtn)
        topVC?.navigationItem.titleView = titleView;
        
    }
    
    @objc private func pushTRAMoreVC() {
        topVC?.navigationController?.pushViewController(TRAMoreVC(), animated: true)
    }

}
