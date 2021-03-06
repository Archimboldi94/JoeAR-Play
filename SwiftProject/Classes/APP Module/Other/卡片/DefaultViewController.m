//
//  DefaultViewController.m
//  LZSwipeableViewDemo
//
//  Created by 周济 on 16/4/21.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "DefaultViewController.h"
#import "LZSwipeableView.h"
#import "AVCardInfo.h"
#import "AVSwipeCardCell.h"
#import "AVKnackBottomToolView.h"
@interface DefaultViewController ()<LZSwipeableViewDataSource,
LZSwipeableViewDelegate,AVKnackBottomToolViewDelegate>
@property (nonatomic, strong) NSMutableArray *cardInfoList;
@property (nonatomic, strong) LZSwipeableView *swipeableView;

/** desc  */
@property (nonatomic, strong) LZSwipeableViewCell *topCell;
@end

@implementation DefaultViewController

- (NSMutableArray *)cardInfoList{
    if (!_cardInfoList) {
        _cardInfoList = [NSMutableArray array];
    }
    return _cardInfoList;
}

- (LZSwipeableView *)swipeableView{
    if (!_swipeableView) {
        _swipeableView = [[LZSwipeableView alloc] initWithFrame:self.view.bounds];
        _swipeableView.datasource = self;
        _swipeableView.delegate = self;
//        _swipeableView.backgroundColor = [UIColor colorWithHex:0xebebeb];
        _swipeableView.backgroundColor = [UIColor whiteColor];

        _swipeableView.topCardInset = UIEdgeInsetsMake(20, 20, 20, 20);

        _swipeableView.hidden = YES;
    }
    return _swipeableView;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self.swipeableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
//    self.view.backgroundColor = [UIColor colorWithHex:0xebebeb];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.swipeableView];
    self.swipeableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.swipeableView registerClass:[AVSwipeCardCell class] forCellReuseIdentifier:NSStringFromClass([AVSwipeCardCell class])];
    
    self.swipeableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.swipeableView.bottomCardInsetHorizontalMargin = 3;
    self.swipeableView.bottomCardInsetVerticalMargin = 3;
    
    // 使用xib时请使用以下方法
//    [self.swipeableView registerNibName:NSStringFromClass([AVSwipeCardCell class]) forCellReuseIdentifier:NSStringFromClass([AVSwipeCardCell class])];
    
    for (int i = 0; i < 100; i++) {
        AVCardInfo *info = [[AVCardInfo alloc] init];
        info.feed_id = 123145;
        info.title = [NSString stringWithFormat:@"测试%zd",i];
        info.summary = [NSString stringWithFormat:@"测试desc%zd",i];
        info.fav_count = arc4random_uniform(100);
        info.is_fav = arc4random_uniform(1);
        [self.cardInfoList addObject:info];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.swipeableView.hidden = NO;
        [self.swipeableView reloadData];
    });

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.swipeableView.frame = self.view.bounds;
}

#pragma mark LZSwipeableViewDataSource
- (NSInteger)swipeableViewNumberOfRowsInSection:(LZSwipeableView *)swipeableView{
    return self.cardInfoList.count;
}

- (LZSwipeableViewCell *)swipeableView:(LZSwipeableView *)swipeableView cellForIndex:(NSInteger)index{
    AVSwipeCardCell *cell = [swipeableView dequeueReusableCellWithIdentifier:NSStringFromClass([AVSwipeCardCell class])];
    cell.cardInfo = self.cardInfoList[index];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (LZSwipeableViewCell *)swipeableView:(LZSwipeableView *)swipeableView substituteCellForIndex:(NSInteger)index{
    AVSwipeCardCell *cell = [[AVSwipeCardCell alloc] initWithReuseIdentifier:@""];
    cell.cardInfo = self.cardInfoList[index];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark LZSwipeableViewDelegate
- (NSInteger)swipeableViewMaxCardNumberWillShow:(LZSwipeableView *)swipeableView{
    return 4;
}
- (void)swipeableView:(LZSwipeableView *)swipeableView didTapCellAtIndex:(NSInteger)index{

}

- (UIView *)footerViewForSwipeableView:(LZSwipeableView *)swipeableView{
    if(self.type == 2){
        return [self showHeaderOrFooterView];
    }
    return nil;
}

- (UIView *)showHeaderOrFooterView{
    
    UIView *btmview = [UIView new];
//    btmview.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    btmview.frame = CGRectMake(0, 0, pingmuwidth, 100);
//
//    UIImageView *icon1 = [UIImageView new];
//    icon1.contentMode = UIViewContentModeCenter;
//    [btmview addSubview:icon1];
//    icon1.image = [UIImage imageNamed:@"ting"];
//
//
//    icon1.sd_layout.heightIs(80).widthIs(pingmuwidth/2).leftSpaceToView(btmview, 0).topSpaceToView(btmview, 0);
//
//
//    UIImageView *icon2 = [UIImageView new];
//    icon2.contentMode = UIViewContentModeCenter;
//    icon2.image = [UIImage imageNamed:@"du"];
//
//    [btmview addSubview:icon2];
//
//    icon2.sd_layout.heightIs(80).widthIs(pingmuwidth/2).leftSpaceToView(icon1, 0).topSpaceToView(btmview, 0);
//
////    AVKnackBottomToolView *bottomView = [AVKnackBottomToolView viewFromXib];
////    bottomView.superVCtl = self;
////    bottomView.delegate  = self;
    return btmview;
}

- (CGFloat)heightForFooterView:(LZSwipeableView *)swipeableView{
    if(self.type == 2){
        return 75;
    }
    return 0;
}

- (UIView *)headerViewForSwipeableView:(LZSwipeableView *)swipeableView{
    if(self.type == 1){
        return [self showHeaderOrFooterView];
    }
    return nil;
}

- (CGFloat)heightForHeaderView:(LZSwipeableView *)swipeableView{
    if(self.type == 1){
        return 75;
    }
    return 0;
}

// 拉到最后一个
- (void)swipeableViewDidLastCardRemoved:(LZSwipeableView *)swipeableView{

}


- (void)swipeableView:(LZSwipeableView *)swipeableView didCardRemovedAtIndex:(NSInteger)index withDirection:(LZSwipeableViewCellSwipeDirection)direction{
       NSLog(@"%zd",direction);
}


- (void)swipeableView:(LZSwipeableView *)swipeableView didTopCardShow:(LZSwipeableViewCell *)topCell{

}


- (void)swipeableView:(LZSwipeableView *)swipeableView didLastCardShow:(LZSwipeableViewCell *)cell{

}

#pragma mark - AVKnackBottomToolViewDelegate
- (void)knackBottomToolViewDidCheckDetailBtnClick:(AVCardInfo *)idInfo{
    [self.swipeableView removeTopCardViewFromSwipe:LZSwipeableViewCellSwipeDirectionLeft];
}


- (void)knackBottomToolViewDidCollectBtnClick:(AVCardInfo *)idInfo{
    [self.swipeableView removeTopCardViewFromSwipe:LZSwipeableViewCellSwipeDirectionRight];
}

- (void)knackBottomToolViewDidShareBtnClick:(AVCardInfo *)idInfo{
    if (self.type == 1) {
      [self.swipeableView removeTopCardViewFromSwipe:LZSwipeableViewCellSwipeDirectionBottom];
    }else{
      [self.swipeableView removeTopCardViewFromSwipe:LZSwipeableViewCellSwipeDirectionTop];
    }

}




@end
