//
//  TRAMoreVC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/26.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class TRAMoreVC: JoeViewController {

    let theViewModel = TRAMoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creatWrapperView(theViewModel.theView)
        theScroollView.backgroundColor = .groundTab
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
