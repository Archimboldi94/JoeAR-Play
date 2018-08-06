//
//  KJTabBarConteoller.swift
//  SwiftPlay
//
//  Created by Archimboldi on 2017/12/7.
//  Copyright © 2017年 KJ. All rights reserved.
//

import UIKit

class KJTabBarConteoller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.creatSubViewControllers()
        
        tabBar.layer.removeAllAnimations()
    }
    
    func creatSubViewControllers(){
        
//        tabBar.isTranslucent = false
         
//        let homeVC = RootVC1()
//        addChildViewController(homeVC,
//                               title: "首页",
//                               image: UIImage(named: "tab_mine"),
//                               selectedImage: UIImage(named: "tab_mine_S"))
//
//        let discoverVC = RootVC2()
//        addChildViewController(discoverVC,
//                               title: "发现",
//                               image: UIImage(named: "tab_mine"),
//                               selectedImage: UIImage(named: "tab_mine_S"))
//        
//        let messageVC = RootVC3()
//        addChildViewController(messageVC,
//                               title: "消息",
//                               image: UIImage(named: "tab_mine"),
//                               selectedImage: UIImage(named: "tab_mine_S"))
//        
//        let mineVC = RootVC4()
//        addChildViewController(mineVC,
//                               title: "我的",
//                               image: UIImage(named: "tab_mine"),
//                               selectedImage: UIImage(named: "tab_mine_S"))
        
 
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(12))], for: .normal)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        addChildViewController(UNavigationController(rootViewController: childController))
    }
}
