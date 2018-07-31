//
//  RootVC1.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/2/28.
//  Copyright © 2018年 KJ. All rights reserved.


import UIKit
import HGPlaceholders //列表占位
//import MJRefresh

class RootVC1: UBaseViewController  {
    
    //    private var placeholderTableView: TableView?
    //懒加载tableview
    //    private var tableViewMain :TableView!
    
    var barHight: CGFloat = 80
    
    lazy var tableViewMain: UITableView = {
        var tm = UITableView()
        tm.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tm.delegate = self
        tm.dataSource = self
        tm.separatorStyle = .none
        tm.isSkeletonable = true
        tm.register(UITableViewCell.self , forCellReuseIdentifier: "ID")//注册cell重用
        tm.tableFooterView = UIView()
        tm.showsVerticalScrollIndicator = false
 
        //开启自动计算高度【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        tm.estimatedRowHeight = 44//预估高度，随便设置
        tm.rowHeight = UITableViewAutomaticDimension
        
        return tm
    }()
    
    //懒加载数据源-可变数组用Var，类型自动推导,数组字典都用[]
    private lazy var dataSouce :[FireBallHomeMdeol] = [FireBallHomeMdeol]()
    override func configUI() {
 
        creatData()//数据
        createUI()//创建UI
        
        super.configUI()
//        tableViewMain.showNoResultsPlaceholder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = setupOnceSkeleton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    lazy var setupOnceSkeleton: Void = {
        tableViewMain.mj_header.beginRefreshing()
        view.showAnimatedSkeleton()
        headerview.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:
            {
 
                self.view.hideSkeleton()
                self.headerview.hideSkeleton()
                self.tableViewMain.reloadData()
        })
    }()
    
     func createUI(){
        
        //标题
        //self.title = "Swift自动布局"
        //tableview
        self.view.addSubview(tableViewMain)
        
        let header = URefreshDIYHeader()// 顶部刷新
        let footer = URefreshBackNormalFooter()// 底部刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(loadData))
        tableViewMain.mj_header = header
        tableViewMain.mj_header.ignoredScrollViewContentInsetTop = 0
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadData))
        tableViewMain.mj_footer = footer
        
        view.addSubview(navView)
        navView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: barHight)
        
        view.addSubview(headerview)
        headerview.frame = CGRect(x: 0, y: 0, width: screenWidth, height: kFitH(300))//tableheader用snp布局有问题
        headerview.addSubview(headerImg)
        headerImg.snp.makeConstraints { (make) in
            make.width.equalTo(kFitW(300))
            make.height.equalTo(kFitH(150))
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
        }
        tableViewMain.tableHeaderView = headerview
     
        headerImg.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                oneToast(message: "常常")
            })
            .disposed(by: disposeBag)
        
    }
    
    @objc func loadData() {
        print("开始旋转~")
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:
            {
                print("回合结束")
                self.tableViewMain.reloadData()
                self.tableViewMain.mj_header.endRefreshing()
                self.tableViewMain.mj_footer.endRefreshing()
        })
        
    }
    
    //MARK: - UI
    lazy var headerImg: UIImageView = {
        var hi = UIImageView()
        hi.kf.setImage(urlString: "https://upload-images.jianshu.io/upload_images/1861592-4fe694ff619dadf3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700")
        hi.layer.cornerRadius = 7
        hi.layer.masksToBounds = true;
        hi.isSkeletonable = true
        return hi
    }()
    
    lazy var headerview: UIView = {
        var hv = UIView()
        hv.backgroundColor = .white
        hv.isSkeletonable = true
        return hv
    }()
    
    lazy var haha = UILabel().then { (make) in
        make.text = "自动提示不好用"
        make.textColor = .red
    }
    
   lazy var navView = UIView().then { (make) in
        var leftStr = UILabel()
        KSetLabel(label: leftStr, color: .black, fontsize: 30, alignment: .left, str: "关注")
        var rightBtn = UIButton()
        rightBtn.set(image: UIImage.init(named: "vip"), title: "添加买手", titlePosition: .bottom, additionalSpacing: 20, state: .normal)
        rightBtn.setTitleColor(.black, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
    
        make.sd_addsubViews(subviews: [leftStr,rightBtn])
        leftStr.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.top.equalTo(35)
        })
        rightBtn.snp.makeConstraints({ (make) in
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(27)
        })

    
    }
    
}

extension RootVC1: UITableViewDelegate,UITableViewDataSource  {
    
    
    
    //代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let cell = FBHomeCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "ID")
        cell.selectionStyle = .none//cell样式，取消选中
        cell.model = dataSouce[indexPath.row]
        return cell
    }
    
    //处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: - 滚动效果
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        //uLog("offsetY == \(offsetY)")
        
 
        if 0 < offsetY && offsetY < 80{
            navView.alpha = 1 - offsetY/50
//            tableViewMain.frame.origin.y = 80 - offsetY
            //uLog("y == \(tableViewMain.frame.origin.y)")
        }
        
        //  navView.frame.size.height =
       
        
    }
    
    func creatData(){
        var imageArray = ["http://www.wallcoo.com/film/2008_07_movies/wallpapers/1600x1200/The_Dark_Knight_wallpaper_burning.jpg","https://desk-fd.zol-img.com.cn/t_s960x600c5/g5/M00/00/01/ChMkJlZKiP2IWOWvAAiOsJVY6pAAAE_rQE1lV8ACI7I090.jpg","https://desk-fd.zol-img.com.cn/t_s960x600c5/g3/M01/0B/00/Cg-4WFRhhXmIdNkxAAhkwaJyy0QAARJHAGxJm0ACGTZ000.jpg","http://img.bzdao.com/11990/1580911.jpg","http://www.wallcoo.com/film/2011_10_The_Thing/wallpapers/1920x1080/TT_03.jpg","http://i5.download.fd.pchome.net/t_960x600/g1/M00/05/01/oYYBAFHw4QGIHPx4AAjxch4_5o0AAAwgQHyNRwACPGK897.jpg","http://www.wallcoo.com/film/naturalcity/images/wallpaper5.jpg","http://image5.tuku.cn/pic/wallpaper/qita/huobiteren2bizhi/019.jpg","http://2b.zol-img.com.cn/product/67_940x705/441/ceFLFS65Z8mC2.jpg"]
        
        var titleArray = ["凤凰台上凤凰台上凤凰游凤凰游","凤去台空江空空空自流","吴宫花草埋幽径","晋代衣冠成古丘","三山半落青天外","二水中分白鹭洲","总为浮云能蔽日","长安不见使人愁"]
        
        var contentArray = ["渡远荆门外,来从楚国游\n渡远荆门外,来从楚国游","山随平野尽，江入大荒流\n 山随平野尽，江入大荒流","月下飞天境，云生结海楼。","仍怜故乡水，万里送行舟。\n仍怜故乡水，万里送行舟","谁家玉笛暗飞声，散入春风满洛城。","此夜曲中闻折柳，何人不起故园情。","天门中断楚江开，碧水东流至此回。","两岸青山相对出，孤帆一片日边来。"]
        
        var n = 0
        for i in 0..<50 {
            let model = FireBallHomeMdeol()
            let voice = Int(arc4random_uniform(8))
            model.good_image = imageArray[voice]
            model.good_title = contentArray[voice]
            model.user_name = titleArray[voice]
            model.user_icon = imageArray[voice]
            dataSouce.append(model)
            n += i
        }
    }
    
}

