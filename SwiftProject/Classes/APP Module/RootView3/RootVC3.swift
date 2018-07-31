//
//  RootVC3.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/2/28.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class RootVC3: UBaseViewController {
  
    //MARK: - configUI
    override func configUI() {
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        let btn = UIButton()
        KSetButton(btn: btn, img: nil, fontcolor: .black, bgcolor: nil, fontsize: nil, str: "出现图片")
        let btn2 = UIButton()
        KSetButton(btn: btn2, img: nil, fontcolor: .black, bgcolor: nil, fontsize: nil, str: "隐藏图片")
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(50)
            make.centerX.equalToSuperview()
        }
        view.addSubview(textf)
        textf.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(btn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        btn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.showToast((self?.icon)!, duration: 3600, point: (self?.view.center)!) { (false) in
                    print("视图消失触发 上面的bool发现什么用")
                }
            })
            .disposed(by: disposeBag)
        btn2.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.hideToast((self?.icon)!)
            })
            .disposed(by: disposeBag)
        
        UserDefaults.standard.set("张三", forKey: "user_name")
        let stringValue = UserDefaults.standard.string(forKey: "user_name")
        uLog("用户名\(String(describing: stringValue))")
        
        //rxLearn()
        
        //rxLearn2()
        
        //rxLearn3()
        
        //rxLearn4()
        
        rxLearn5()
        
        super.configUI()
    }
    
    
    func rxLearn5() {
        
        //var model = UserViewModel()
        
        let text = Variable("双向绑定")
        
        //将用户名与textField做双向绑定
       _ = textf.rx.textInput <-> text
        
        //将用户信息绑定到label上
        textf.rx.text.bind(to: label.rx.text).disposed(by: disposeBag)
    }
    
    func rxLearn() {
     
        
        var isOdd = true
        
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
            
            //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
            
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        //第1次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }.disposed(by: disposeBag)
        
        //第2次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }.disposed(by: disposeBag)
        
        //第3次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }.disposed(by: disposeBag)
        
        //5秒种后发出唯一的一个元素0
        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable2 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        observable2
            .map { "当前索引数：\($0 )"}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func rxLearn2() {
        
        //创建一个PublishSubject
        let subject = PublishSubject<String>()
        
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        subject.onNext("111")
        
        //第1次订阅subject
        subject.subscribe(onNext: { string in
            print("第1次订阅：", string)
        }, onCompleted:{
            print("第1次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有1个订阅，则该信息会输出到控制台
        subject.onNext("222")
        
        //第2次订阅subject
        subject.subscribe(onNext: { string in
            print("第2次订阅：", string)
        }, onCompleted:{
            print("第2次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
        
        //让subject结束
        subject.onCompleted()
        
        //subject完成后会发出.next事件了。
        subject.onNext("444")
        
        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        subject.subscribe(onNext: { string in
            print("第3次订阅：", string)
        }, onCompleted:{
            print("第3次订阅：onCompleted")
        }).disposed(by: disposeBag)
    }
    
    func rxLearn3() {
        
        //创建一个PublishSubject
        let subject = PublishSubject<String>()
        
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        subject.onNext("111")
        
        //第1次订阅subject
        subject.subscribe(onNext: { string in
            print("第1次订阅：", string)
        }, onCompleted:{
            print("第1次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有1个订阅，则该信息会输出到控制台
        subject.onNext("222")
        
        //第2次订阅subject
        subject.subscribe(onNext: { string in
            print("第2次订阅：", string)
        }, onCompleted:{
            print("第2次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
        
        //让subject结束
        subject.onCompleted()
        
        //subject完成后会发出.next事件了。
        subject.onNext("444")
        
        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        subject.subscribe(onNext: { string in
            print("第3次订阅：", string)
        }, onCompleted:{
            print("第3次订阅：onCompleted")
        }).disposed(by: disposeBag)
    }
    
    func rxLearn4() {
//        let subject1 = BehaviorSubject(value: "A")
//        let subject2 = BehaviorSubject(value: "1")
//
//        let variable = Variable(subject1)
//
//        variable.asObservable()
//            .flatMapLatest { $0 }
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
//
//        subject1.onNext("B")
//        variable.value = subject2
//        subject2.onNext("2")
//        subject1.onNext("C")
        
        //将奇数偶数分成两组
//        Observable<Int>.of(0, 1, 2, 3, 4, 5)
//            .groupBy(keySelector: { (element) -> String in
//                return element % 2 == 0 ? "偶数" : "基数"
//            })
//            .subscribe { [weak self] (event) in
//                switch event {
//                case .next(let group):
//                    group.asObservable().subscribe({ (event) in
//                        print("key：\(group.key)    event：\(event)")
//                    })
//                        .disposed(by: self!.disposeBag)
//                default:
//                    print("")
//                }
//            }
//            .disposed(by: disposeBag)
        
        let array = [1,2,3,45,6,7,78,2]
        
        Observable.from(array)
            .filter {
                $0 > 10
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
//        Observable.of(1, 2, 3, 4)
//            .elementAt(2)
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)

        let source = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
        
        source
            .sample(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext(1)
        
        //让源序列接收接收消息
        notifier.onNext("A")
        
        source.onNext(2)
        
        //让源序列接收接收消息
        notifier.onNext("B")
        notifier.onNext("C")
        
        source.onNext(3)
        source.onNext(4)
        
        //让源序列接收接收消息
        notifier.onNext("D")
        
        source.onNext(5)
        
        //让源序列接收接收消息
        notifier.onCompleted()
        
       
        Observable.of(1, 2, 3, 4, 5)
            .reduce(0, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        Observable.of(1, 2, 1)
            .materialize()//转成事件
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    lazy var icon: UIImageView = {
        var ic = UIImageView()
        ic.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        ic.image = #imageLiteral(resourceName: "girl")
        return ic
    }()
    
    lazy var label: UILabel = {
        var l1 = UILabel()
        l1.text = "我是label"
        return l1
    }()
    
    lazy var textf: UITextField = {
        var l1 = UITextField()
        l1.placeholder = "我是UITextField"
        return l1
    }()
}

