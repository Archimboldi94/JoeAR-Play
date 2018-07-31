//
//  TRAHomeCellType3.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/24.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class TRAHomeCellType3: JoeTableViewCell {

    override func configUI() {
        
        contentView.addSubview(pagerView)
        pagerView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.height.equalTo(120)
            make.right.equalTo(-18)
            make.left.equalTo(18)
        }
        
    }
    
    var imageNamesArr : [String] = ["tu1", "tu2", "tu3"]

    lazy var pageControl: FSPageControl = {
        var pc = FSPageControl()
        pc.numberOfPages = imageNamesArr.count
        pc.contentHorizontalAlignment = .right
        pc.frame = CGRect(x:0, y: screenWidth/2-20+64, width: screenWidth, height: 20)
        pc.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return pc
    }()
    
    lazy var pagerView: FSPagerView = {
        var pv = FSPagerView()
        pv.dataSource = self
        pv.delegate = self
        pv.interitemSpacing = 5//滚动时的间距
        pv.transformer = FSPagerViewTransformer(type: .linear)
        pv.itemSize = CGSize(width: 180, height: 115)
        pv.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        //pv.frame = CGRect(x: 100, y: 0, width: screenWidth - 100, height: 150)
        //pv.isInfinite = true//无限滚动 默认false
        //pv.automaticSlidingInterval = 3.0//3s间隔 不设置不滚
        //let transform = CGAffineTransform(scaleX: 0.6, y: 0.75) demo"linear""coverFlow"的效果,
        //pv.itemSize = pv.frame.size.applying(transform)
        
        return pv
    }()
}

extension TRAHomeCellType3 :FSPagerViewDataSource,FSPagerViewDelegate{
 
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNamesArr.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        //cell.imageView?.kf.setImage(urlString: imageNamesArr[index])
        cell.imageView?.image = UIImage(named: imageNamesArr[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 20
        cell.contentView.backgroundColor = .white
        cell.clipsToBounds = true
        cell.isUserInteractionEnabled = false
        //cell.textLabel?.text = index.description+index.description
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: false)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
}
