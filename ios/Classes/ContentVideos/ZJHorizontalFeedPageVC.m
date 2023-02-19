//
//  ZJHorizontalFeedPageVC.m
//  ZJSDKDemo
//
//  Created by 麻明康 on 2023/1/5.
//  Copyright © 2023 zj. All rights reserved.
//

#import "ZJHorizontalFeedPageVC.h"
#import <ZJSDK/ZJHorizontalFeedPage.h>
#import <ZJSDK/ZJContentPageStateDelegate.h>
@interface ZJHorizontalFeedPageVC ()<ZJContentPageHorizontalFeedCallBackDelegate>
@property (nonatomic,strong)ZJHorizontalFeedPage *contentPage;

@end

@implementation ZJHorizontalFeedPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频内容横版";
    self.contentPage = [[ZJHorizontalFeedPage alloc]initWithPlacementId:self.contentId];
    self.contentPage.callBackDelegate = self;
    UIViewController *vc = self.contentPage.viewController;
    [self tryAddSubVC:vc];
}


#pragma mark =============== ZJContentPageHorizontalFeedCallBackDelegate ===============

/// 进入横版视频详情页
/// @param viewController 详情页VC
/// @param content 视频信息
- (void)zj_horizontalFeedDetailDidEnter:(UIViewController *)viewController contentInfo:(id<ZJContentInfo>)content{
    if (self.horizontalFeedDetailDidEnter) self.horizontalFeedDetailDidEnter();
}
/// 离开横版视频详情页
/// @param viewController 详情页VC
- (void)zj_horizontalFeedDetailDidLeave:(UIViewController *)viewController{
    if (self.horizontalFeedDetailDidLeave) self.horizontalFeedDetailDidLeave();
}

/// 视频详情页appear
/// @param viewController 详情页VC
- (void)zj_horizontalFeedDetailDidAppear:(UIViewController *)viewController{
    if (self.horizontalFeedDetailDidAppear) self.horizontalFeedDetailDidAppear();
}

/// 详情页disappear
/// @param viewController 详情页VC
- (void)zj_horizontalFeedDetailDidDisappear:(UIViewController *)viewController{
    if (self.horizontalFeedDetailDidDisappear) self.horizontalFeedDetailDidDisappear();
}

@end
