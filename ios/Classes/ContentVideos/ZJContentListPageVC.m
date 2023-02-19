//
//  ZJContentListPageVC.m
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/16.
//

#import "ZJContentListPageVC.h"
#import <ZJSDK/ZJContentPage.h>
@interface ZJContentListPageVC ()

@property (nonatomic,strong)ZJContentPage *contentPage;
@end

@implementation ZJContentListPageVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"视频内容列表";
    self.contentPage = [[ZJContentPage alloc]initWithPlacementId:self.contentId];
    self.contentPage.videoStateDelegate = self;
    self.contentPage.stateDelegate = self;
    UIViewController *vc = self.contentPage.viewController;
    [self tryAddSubVC:vc];
}


@end
