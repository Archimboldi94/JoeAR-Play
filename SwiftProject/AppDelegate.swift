//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/2/28.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        
        let rootCv = ARListViewController();
        let nav = UNavigationController(rootViewController: rootCv)
        window?.rootViewController = nav
        //window?.rootViewController = rootCv
        
        
        //let vc = KJTabBarConteoller()
        //window?.rootViewController = vc
        //window?.makeKeyAndVisible()
        
//        configIQKeyboardManager()
        
        return true
    }
    
//    func configIQKeyboardManager(){
//        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "完成"
//        IQKeyboardManager.sharedManager().enable = true
//    }

  
}

