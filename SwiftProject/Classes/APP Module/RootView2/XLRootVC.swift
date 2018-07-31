//
//  XLRootVC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/2.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class XLRootVC: ButtonBarPagerTabStripViewController {

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white // 顶部buttonBar背景颜色
        settings.style.buttonBarItemBackgroundColor = .clear// item(标签)背景颜色
        settings.style.selectedBarBackgroundColor = .red// 选中长条背景颜色
        settings.style.selectedBarHeight = 3// 选中长条高度
        settings.style.selectedBarVerticalAlignment = .bottom
        settings.style.buttonBarMinimumInteritemSpacing = 50
        settings.style.buttonBarMinimumLineSpacing = 0// 最小单元格间距
        settings.style.buttonBarLeftContentInset = 10 //线条宽度
        settings.style.buttonBarRightContentInset = 100 //线条宽度
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 31)// item(标签)字体大小
        settings.style.buttonBarItemLeftRightMargin = 20
        settings.style.buttonBarItemTitleColor = .black// item(标签)字体颜色
        settings.style.buttonBarHeight = 80
        settings.style.buttonBarItemsShouldFillAvailableWidth = false
        changeCurrentIndexProgressive = {   (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .fontGrey
            newCell?.label.textColor = .black //选中文字颜色
        }
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = XLSonVC1(itemInfo: "买手")
        let child_2 = XLSonVC1(itemInfo: "好物")

        return [child_1, child_2]
    }
}
