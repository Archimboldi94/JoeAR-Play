//
//  XibViewController.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/9.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class XibViewController: UBaseViewController {

    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var textf1: UITextField!
    
    override func configUI() {
        
        textf1.rx.text
            .bind(to: label1.rx.text)
            .disposed(by: disposeBag)
        
        
        
        super.configUI()
    }
 
    @IBAction func daijiclick(_ sender: Any) {
         uLog("click~")
        
    }
    

}
