//
//  TRAHomeVC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class TRAHomeVC: JoeViewController {

    let theViewModel = TRAHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        view = theViewModel.theView
        
        theViewModel.setHomeNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
