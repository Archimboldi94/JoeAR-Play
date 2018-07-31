//
//  JoeViewController.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class JoeViewController: UIViewController {
    
    lazy var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        isHeroEnabled = true
        
        view.backgroundColor = UIColor.background
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func creatWrapperView(_ theWrapperView: UIView) {
        theWrapperView.isUserInteractionEnabled = true
        theScroollView.addSubview(theWrapperView)
        theWrapperView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
    }
 
    lazy var theScroollView: UIScrollView = {
        var aScroollView = UIScrollView()
        view.addSubview(aScroollView)
        aScroollView.isUserInteractionEnabled = true
        aScroollView.isScrollEnabled = true
        aScroollView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return aScroollView
    }()
    
}

