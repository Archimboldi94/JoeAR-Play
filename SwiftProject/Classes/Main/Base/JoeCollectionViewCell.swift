//
//  JoeCollectionViewCell.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/26.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import Reusable

class JoeCollectionViewCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}


