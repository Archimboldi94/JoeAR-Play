//
//  TRAHomeVoiceView.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/25.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit

class TRAHomeVoiceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        
        backgroundColor = .clear
        
        sd_addsubViews(subviews: [theVisualView, theLabel])
        theVisualView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        theLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(40)
        }
        
        //addSubview(theVoiceLine)
        //theVoiceLine.show(inParentView: self)
        //theVoiceLine.startVoiceWave()
    }

    lazy var theVoiceLine: VoiceWaveView = {
        let make = VoiceWaveView()
        make.setVoiceWaveNumber(6)
        return make
    }()
    
    private lazy var theVisualView: UIVisualEffectView = {
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        return visualEffectView
    }()
    
    private lazy var theLabel: UILabel = {
        var make = UILabel()
        make.font = UIFont.systemFont(ofSize: 15)
        make.text = "请说中文"
        make.textColor = .theme
        return make
    }()
}
