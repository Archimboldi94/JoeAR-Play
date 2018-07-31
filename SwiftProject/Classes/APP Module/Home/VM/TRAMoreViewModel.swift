//
//  TRAMoreViewModel.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/26.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class TRAMoreViewModel: NSObject {

    let theView = TRAMoreView()
    
    override init() {
        super.init()
        
        theView.backgroundColor = .groundTab
        setEvent()
        
    }
    
    private func setEvent() {
        
        let aGesture = UITapGestureRecognizer(target: self, action: #selector(pushCard))
        theView.theImageV.isUserInteractionEnabled = true
        theView.theImageV.addGestureRecognizer(aGesture)
    }
    
    
    @objc func pushCard() {
        
        topVC?.navigationController?.pushViewController(DefaultViewController(), animated: true)
    }
}
