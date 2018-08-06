//
//  Function.swift
//  SwiftPalyGround
//
//  Created by Archimboldi on 2017/12/27.
//  Copyright © 2017年 KJ. All rights reserved.
//
 
import UIKit
import Foundation
import Photos
import Toast_Swift
import SwiftyJSON
//import HandyJSON

// MARK: -  设置toast
func oneToast(message: String?)  -> () {
    topVC?.view?.makeToast(message, duration: 2.5, position: .center)
}

func oneToastView(view: UIView?, point: CGPoint)  -> () {
    topVC?.view?.showToast(view!, duration: 3600, point: point, completion: { (false) in
    })
}


// MARK: -  设置button
func KSetButton(btn: UIButton, img: String?, fontcolor: UIColor?, bgcolor: UIColor?, fontsize: CGFloat?, str: String?) -> () {
    
    if let img = img {
        btn.setImage(UIImage(named: img as String), for: .normal)
    }
    if let fontcolor = fontcolor {
        btn.setTitleColor(fontcolor, for: .normal)
    }
    if let bgcolor = bgcolor {
        btn.backgroundColor = bgcolor
    }
    if let fontsize = fontsize {
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontsize)
    }
    if let str = str {
        btn.setTitle(str as String, for: .normal)
    }
    
}

// MARK: -  设置label
func KSetLabel(label: UILabel, color: UIColor?, fontsize: CGFloat?, alignment: NSTextAlignment?, str: String?) -> () {
    
    if let color = color {
        label.textColor = color
    }
    if let fontsize = fontsize {
        label.font = UIFont.systemFont(ofSize: fontsize)
    }
    if let alignment = alignment {
        label.textAlignment = alignment
    }
    if let str = str {
        label.text = str as String
    }
    label.adjustsFontSizeToFitWidth = true //当文字超出标签宽度时，自动调整文字大小，使其不被截断
    
}



// MARK: - 从PHAsset获取图片
func getAssetThumbnail(asset: PHAsset) -> UIImage {
    var retimage = UIImage()
    //print(retimage)
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    option.deliveryMode = .highQualityFormat
    option.resizeMode = .exact
    option.isNetworkAccessAllowed = true
    option.isSynchronous = true
    manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
        retimage = result!
    })
    //print(retimage)
    return retimage
    //参考:https://stackoverflow.com/questions/30812057/phasset-to-uiimage
    //https://developer.apple.com/documentation/photos/phasset
    //http://io.upyun.com/2016/03/23/the-real-files-in-alasset-and-phasset/
    //https://happenroc.github.io/blog/2016/01/23/get-image-from-phasset/
}

// MARK: - 图片压缩 https://www.jianshu.com/p/55963644aeba
func resizeImage(originalImg:UIImage) -> UIImage{
    
    //prepare constants
    let width = originalImg.size.width
    let height = originalImg.size.height
    let scale = width/height
    
    var sizeChange = CGSize()
    
    if width <= 1280 && height <= 1280{ //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
        return originalImg
    }else if width > 1280 || height > 1280 {//b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
        
        if scale <= 2 && scale >= 1 {
            let changedWidth:CGFloat = 1280
            let changedheight:CGFloat = changedWidth / scale
            sizeChange = CGSize(width: changedWidth, height: changedheight)
            
        }else if scale >= 0.5 && scale <= 1 {
            
            let changedheight:CGFloat = 1280
            let changedWidth:CGFloat = changedheight * scale
            sizeChange = CGSize(width: changedWidth, height: changedheight)
            
        }else if width > 1280 && height > 1280 {//宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280
            
            if scale > 2 {//高的值比较小
                
                let changedheight:CGFloat = 1280
                let changedWidth:CGFloat = changedheight * scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if scale < 0.5{//宽的值比较小
                
                let changedWidth:CGFloat = 1280
                let changedheight:CGFloat = changedWidth / scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }
        }else {//d, 宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
            return originalImg
        }
    }
    
    UIGraphicsBeginImageContext(sizeChange)

    //draw resized image on Context
    originalImg.draw(in: CGRect(x: 0, y: 0, width: sizeChange.width, height: sizeChange.height))
    //create UIImage
    let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return resizedImg!
    
}

 

