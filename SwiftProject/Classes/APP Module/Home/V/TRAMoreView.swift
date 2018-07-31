//
//  TRAMoreView.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/26.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class TRAMoreView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        
        backgroundColor = .groundTab
        
        addSubview(theImageV)
        theImageV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(kFitW(333))
        }
        
        addSubview(theCollectionView)
        theCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(theImageV.snp.bottom)
            make.height.equalTo(210)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-100)
        }
        
    }
    
    lazy var theImageV: UIImageView = {
        var make = UIImageView()
        make.image = #imageLiteral(resourceName: "shengciben")
        return make
    }()
    

    lazy var theCollectionView: UICollectionView = {
 
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 90)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 3
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 5, 5)
        
        var make = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 210), collectionViewLayout: layout)
        make.backgroundColor = .groundTab
        make.delegate = self
        make.dataSource = self
        make.showsHorizontalScrollIndicator = false
        make.register(cellType: TRAMoreCollectionViewCell.self)
        return make
    }()
}



extension TRAMoreView: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 23
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TRAMoreCollectionViewCell.self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        uLog("indexPath == \(indexPath)")
    }
    
}
