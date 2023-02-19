//
//  ZJFeedPageVC.m
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import "ZJFeedPageVC.h"
#import <ZJSDK/ZJFeedPage.h>
@interface ZJFeedPageVC ()

@property (nonatomic,strong)ZJFeedPage *contentPage;
@end

@implementation ZJFeedPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频内容瀑布流";
    self.contentPage = [[ZJFeedPage alloc]initWithPlacementId:self.contentId];
    self.contentPage.videoStateDelegate = self;
    self.contentPage.stateDelegate = self;
    UIViewController *vc = self.contentPage.viewController;
    [self tryAddSubVC:vc];
}

@end
