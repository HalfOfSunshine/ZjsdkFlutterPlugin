//
//  ZJImageTextVC.m
//  ZJSDKDemo
//
//  Created by 麻明康 on 2023/1/5.
//  Copyright © 2023 zj. All rights reserved.
//

#import "ZJImageTextVC.h"
#import <ZJSDK/ZJImageTextPage.h>
#import <ZJSDK/ZJContentPageStateDelegate.h>
@interface ZJImageTextVC ()<ZJContentPageHorizontalFeedCallBackDelegate,ZJImageTextDetailDelegate>
@property (nonatomic,strong)ZJImageTextPage *contentPage;

@end

@implementation ZJImageTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentPage = [[ZJImageTextPage alloc]initWithPlacementId:self.contentId];
    self.contentPage.callBackDelegate = self;
    self.contentPage.imageTextDelegate = self;
    UIViewController *vc = self.contentPage.viewController;
    if(vc){
        CGFloat contentY = [UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height;
        vc.view.frame = CGRectMake(0, contentY, self.view.frame.size.width, self.view.frame.size.height-contentY);
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
    }else{
        NSLog(@"未能创建对应广告位VC，建议从以下原因排查：\n 1，视频内容需要手动导入快手模块（pod版本不支持视频内容）\n 2，确保sdk已注册成功 \n 3，确保广告位正确可用");
    }
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


#pragma mark =============== ZJImageTextDetailDelegate ===============
/// 进入图文详情页
/// @param detailViewController 图文详情页VC
/// @param feedId feedId
- (void)zj_imageTextDetailDidEnter:(UIViewController *)detailViewController feedId:(NSString *)feedId{
    if (self.imageTextDetailDidEnter) self.imageTextDetailDidEnter();
}

/// 离开图文详情页
/// @param detailViewController 图文详情页VC
- (void)zj_imageTextDetailDidLeave:(UIViewController *)detailViewController{
    if (self.imageTextDetailDidLeave) self.imageTextDetailDidLeave();
}


/// 图文详情页appear
/// @param detailViewController 图文详情页VC
- (void)zj_imageTextDetailDidAppear:(UIViewController *)detailViewController{
    if (self.imageTextDetailDidAppear) self.imageTextDetailDidAppear();
}

/// 图文详情页disappear
/// @param detailViewController 图文详情页VC
- (void)zj_imageTextDetailDidDisappear:(UIViewController *)detailViewController{
    if (self.imageTextDetailDidDisappear) self.imageTextDetailDidDisappear();
}


/// 图文详情加载结果
/// @param detailViewController 图文详情页VC
/// @param success 是否成功
/// @param error error
- (void)zj_imageTextDetailDidLoadFinish:(UIViewController *)detailViewController sucess:(BOOL)success error:(NSError *)error{
    if (self.imageTextDetailDidLoadFinish) self.imageTextDetailDidLoadFinish();
}


/// 图文详情阅读进度
/// @param detailViewController 图文详情页VC
/// @param isFold 是否折叠
/// @param totalHeight 详情总高度
/// @param seenHeight 已经看过的高度
- (void)zj_imageTextDetailDidScroll:(UIViewController *)detailViewController isFold:(BOOL)isFold totalHeight:(CGFloat)totalHeight seenHeight:(CGFloat)seenHeight{
    if (self.imageTextDetailDidScroll) self.imageTextDetailDidScroll();
}
@end
