//
//  UITableviewExtension.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/3/5.
//  Copyright © 2018年 KJ. All rights reserved.
//

import Foundation
import UIKit
import EmptyDataSet_Swift

extension UITableView: EmptyDataSetSource, EmptyDataSetDelegate {
     
    
    override open var frame:CGRect{
        didSet {
            self.emptyDataSetSource = self
            self.emptyDataSetDelegate = self
        }
    }

    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        let myString = "暂无数据"
        let myAttribute = [NSAttributedStringKey.foregroundColor: UIColor.fontGrey, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute )

        return myAttrString
    }
    
    public func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        let image = #imageLiteral(resourceName: "vip")
        
        return image
    }
}
