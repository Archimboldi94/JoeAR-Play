//
//  XLSonVC2.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/13.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class XLSonVC2: UBaseViewController , IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = "View"
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    override func configUI() {
        
        super.configUI()
    }
   
}
