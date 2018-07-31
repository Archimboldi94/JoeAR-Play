//
//  TRALoginVC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit


class TRALoginVC: JoeViewController {

    let theView = TRALoginView()
     
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        
        view = theView
        
        manageEvent()
    }
    
    
    private func manageEvent() {
        
        theView.theBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        
    }
    
    @objc private func loginClick() {
    
        let rootCv = TRAHomeVC();
        let nav = UNavigationController(rootViewController: rootCv)
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = "fade"
        UIApplication.shared.keyWindow?.layer.add(transition, forKey: nil)
        UIApplication.shared.keyWindow?.rootViewController = nav;
 
    }
    
}
