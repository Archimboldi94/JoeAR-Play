//
//  Global.swift
//  U17
//
//  Created by charles on 2017/10/24.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
//import RxCocoa
//import RxGesture
//import RxDataSources
//import Kingfisher
import SnapKit
//import SkeletonView
//import Then
//import XLPagerTabStrip//分页
//import SKPhotoBrowser//图片浏览器
 

//class KObservable: Observable<Any> {}

//class XLButtonBarPagerTabStripViewController: ButtonBarPagerTabStripViewController {}

extension UIColor {
    class var background: UIColor {
        return UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
    }
    
    class var theme: UIColor {
        return UIColor(red:0.65, green:0.33, blue:0.96, alpha:1.00)//基佬紫
    }
    
    class var theme2: UIColor {
        return UIColor(red:0.94, green:0.93, blue:0.96, alpha:1.00)//灰紫
    }
    
    class var fontGrey: UIColor {
        return UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.00)
    }
    
    class var fontMain: UIColor {
        return UIColor(red:0.11, green:0.11, blue:0.11, alpha:1.00)
    }
    
    class var groundTab: UIColor {
        return UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
    }
    
    
}

extension String {
    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
} 

extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

//适配各种屏幕 设计稿按iPhone6的屏幕来适配
func kFitH(_ oHeight: CGFloat) -> CGFloat { //https://www.cnswift.org/functions 省略实际参数标签
    return oHeight*screenHeight/667.0
}
func kFitW(_ oWidth: CGFloat) -> CGFloat {
    return oWidth*screenWidth/375.0
}

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//MARK: print
func uLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}

//MARK: Kingfisher
// 
//extension Kingfisher where Base: ImageView {
//    @discardableResult
//    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "jiake")) -> RetrieveImageTask {
//        return setImage(with: URL(string: urlString ?? ""),
//                        placeholder: placeholder,
//                        options:[.transition(.fade(0.5))])
//    }
//}
//
//extension Kingfisher where Base: UIButton {
//    @discardableResult
//    public func setImage(urlString: String?, for state: UIControlState, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
//        return setImage(with: URL(string: urlString ?? ""),
//                        for: state,
//                        placeholder: placeholder,
//                        options: [.transition(.fade(0.5))])
//    }
//}
//MARK: SnapKit
extension ConstraintView {
    
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

extension UICollectionView {
    
    func reloadData(animation: Bool = true) {
        if animation {
            reloadData()
        } else {
            UIView .performWithoutAnimation {
                reloadData()
            }
        }
    }
}

//MARK: swizzledMethod
extension NSObject {
    
    static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}


