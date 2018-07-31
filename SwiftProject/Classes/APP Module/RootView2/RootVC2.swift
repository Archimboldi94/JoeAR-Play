//
//  RootVC2.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/2/28.
//  Copyright © 2018年 KJ. All rights reserved.
 

import UIKit
import Photos
import Gallery//相册
import SKPhotoBrowser//图片浏览器

class RootVC2: UBaseViewController,FSPagerViewDataSource,FSPagerViewDelegate,GalleryControllerDelegate{
    
    var gallery: GalleryController!
    
    // MARK: 生命周期入口
    override func configUI() {
        
        self.view.addSubview(pagerView)
        // Create a page contro
        self.view.addSubview(pageControl)
       
        let btn = UIButton()
        KSetButton(btn: btn, img: nil, fontcolor: .black, bgcolor: nil, fontsize: 15, str: "跳转到XL分页")
        btn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController(XLRootVC(), animated: true)
            })
            .disposed(by: disposeBag)
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        let btn2 = UIButton()
        KSetButton(btn: btn2, img: nil, fontcolor: .black, bgcolor: nil, fontsize: 15, str: "alert")
        //        ButtonddTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(haha), for: .touchUpInside)
        //        Button.addTarget(self)
        
        btn2.rx.tap
            .subscribe(onNext: { [weak self] in
                
//                let alert = UIAlertController(style: .actionSheet, title: "Simple Alert", message: "3 kinds of actions")
//                alert.addAction(title: "Cancel", style: .cancel)
//                alert.addAction(title: "好啊", style: .default, handler: { (alert) in
//                    uLog("点击了好啊=)")
//                })
//                alert.show()
                
                //                let alert = UIAlertController(style: .actionSheet)
                //                alert.addPhotoLibraryPicker(flow: .vertical, paging: false,
                //                                            selection: .single(action: {
                //                                                assets in Log("选择图片 \(String(describing: assets))")
                //                                                if (assets?.mediaType == PHAssetMediaType.image)
                //                                                {
                //                                                    //遇到本地没有,存在iCloud中的图片会有下载时间,进度不可知,使用起来不是很好
                //                                                    self?.show_img.image = getAssetThumbnail(asset: assets!)
                //                                                }
                //                                            }))
                //                alert.addAction(title: "取消", style: .cancel)
                //                alert.show()
            })
            .disposed(by: disposeBag)
        view.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.top.equalTo(btn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        view.addSubview(show_img)
        show_img.snp.makeConstraints { (make) in
            make.top.equalTo(btn2.snp.bottom)
            make.width.equalTo(300)
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
        }
        
        show_img.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                print("点击了图片")
                
                SKPhotoBrowserOptions.displayDeleteButton = true
                SKPhotoBrowserOptions.swapCloseAndDeleteButtons = true
                //                SKPhotoBrowserOptions.closeAndDeleteButtonPadding = 20
                SKPhotoBrowserOptions.displayAction = true
                SKPhotoBrowserOptions.displayStatusbar = true
                SKPhotoBrowserOptions.displayToolbar = true
                SKPhotoBrowserOptions.displayCounterLabel = true
                SKPhotoBrowserOptions.displayBackAndForwardButton = true
                
                var images = [SKPhoto]()
                let photo = SKPhoto.photoWithImage((self?.show_img.image!)!)// add some UIImage
                images.append(photo)
                images.append(photo)
                images.append(photo)//加三张
                 
                // 2. create PhotoBrowser Instance, and present from your viewController.
                let browser = SKPhotoBrowser(photos: images)
                browser.initializePageIndex(0)
                self?.present(browser, animated: true, completion: {})
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK:- 图片选择代理
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        let One = images
        let two = One[0]
        self.show_img.image =  getAssetThumbnail(asset: two.asset)
        self.show_img.image = resizeImage(originalImg: self.show_img.image!)
        let imageData: Data = UIImagePNGRepresentation(self.show_img.image!)!
        print("图片data== \(imageData)")
        controller.dismiss(animated: true, completion: nil)
        gallery = nil
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
        gallery = nil
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
        gallery = nil
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
        gallery = nil
    }
    
    @objc func haha() {
        
        //oneToast(message: "哈哈")
        
        Config.tabsToShow = [.imageTab,.cameraTab]
        Config.Camera.imageLimit = 1
  
        gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    fileprivate let imageNames = ["http://www.wfallcoo.com/film/2008_07_movies/wallpapers/1600x1200/The_Dark_Knight_wallpaper_burning.jpg","https://desk-fd.zol-img.com.cn/t_s960x600c5/g5/M00/00/01/ChMkJlZKiP2IWOWvAAiOsJVY6pAAAE_rQE1lV8ACI7I090.jpg","https://desk-fd.zol-img.com.cn/t_s960x600c5/g3/M01/0B/00/Cg-4WFRhhXmIdNkxAAhkwaJyy0QAARJHAGxJm0ACGTZ000.jpg","http://www.wallcoo.com/film/2011_10_The_Thing/wallpapers/1920x1080/TT_03.jpg","http://i5.download.fd.pchome.net/t_960x600/g1/M00/05/01/oYYBAFHw4QGIHPx4AAjxch4_5o0AAAwgQHyNRwACPGK897.jpg","http://www.wallcoo.com/film/naturalcity/images/wallpaper5.jpg","http://image5.tuku.cn/pic/wallpaper/qita/huobiteren2bizhi/019.jpg","http://2b.zol-img.com.cn/product/67_940x705/441/ceFLFS65Z8mC2.jpg"]
    
    
    // MARK:- FSPagerView Delegate 轮播代理
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(urlString: imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        //cell.textLabel?.text = index.description+index.description 隐藏文字
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: false)
        pagerView.scrollToItem(at: index, animated: true)
        uLog("点的是第\(index)个")
        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    
    lazy var pageControl: FSPageControl = {
        var pc = FSPageControl()
        pc.numberOfPages = self.imageNames.count
        pc.contentHorizontalAlignment = .right
        pc.frame = CGRect(x:0, y: screenWidth/2-20+64, width: screenWidth, height: 20)
        pc.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return pc
    }()
    
    lazy var pagerView: FSPagerView = {
        var pv = FSPagerView()
        pv.frame = CGRect(x: 0, y: 64, width: screenWidth, height: screenWidth/2)
        pv.dataSource = self
        pv.delegate = self
        pv.isInfinite = true//无限滚动 默认false
        pv.automaticSlidingInterval = 3.0//3s间隔 不设置不滚
        pv.interitemSpacing = 5//滚动时的间距
        //pv.transformer = FSPagerViewTransformer(type: .linear)
        //let transform = CGAffineTransform(scaleX: 0.6, y: 0.75) demo"linear""coverFlow"的效果,
        //pv.itemSize = pv.frame.size.applying(transform)
        pv.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pv
    }()
    
    lazy var show_img: UIImageView = {
        var si = UIImageView()
        si.image =  #imageLiteral(resourceName: "jiake")
        return si
        
         
    }()
}


