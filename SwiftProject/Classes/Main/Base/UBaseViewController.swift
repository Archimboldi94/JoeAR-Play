//
//  UBaseViewController.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/2/28.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import RxSwift
//import RxCocoa
//import RxGesture

class UBaseViewController: UIViewController {
    
    lazy var disposeBag = DisposeBag()
    
//    lazy var dataArray: Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //push时会导致tabbar停顿一下 最好哪里用到那里加
        //navigationController?.isHeroEnabled = true
        //isHeroEnabled = true
        
        view.backgroundColor = UIColor.background
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    
    func configUI() {
 
    }
    
    func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.barStyle(.white)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                                   target: self,
                                                                   action: #selector(pressBack))
            }
        }
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension UBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}


