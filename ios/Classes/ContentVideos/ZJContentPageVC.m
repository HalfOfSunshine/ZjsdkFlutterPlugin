//
//  ZJContentPageVC.m
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import "ZJContentPageVC.h"

@interface ZJContentPageVC ()

@end

@implementation ZJContentPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBackBarButton];
    
    NSLog(@"ZJKSContentPage===========%@",NSClassFromString(@"ZJKSContentPage"));
    NSLog(@"ZJKSSplashAd===========%@",NSClassFromString(@"ZJKSSplashAd"));
    NSLog(@"KSCUContentPage===========%@",NSClassFromString(@"KSCUContentPage"));
    NSLog(@"KSAd===========%@",NSClassFromString(@"KSAd"));
}

-(void)tryAddSubVC:(UIViewController *)vc{
    if(vc){
        CGFloat contentY = [UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height;
        vc.view.frame = CGRectMake(0, contentY, self.view.frame.size.width, self.view.frame.size.height-contentY);
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
    }else{
        if(NSClassFromString(@"KSCUContentPage")){
            NSLog(@"未能创建对应广告位VC，请确保sdk已注册成功，广告位填写正确");
        }else{
            NSLog(@"视频内容需要手动导入快手模块（pod版本不支持视频内容）,请参考接入文档");
        }
    }
}
-(void)setBackBarButton{
    //返回按钮
    UIButton *backButton  =  [[UIButton alloc] init];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    backButton.userInteractionEnabled = YES;
    
    //    backButton.frame  =  CGRectMake(12.5, 0, 25, 25);
    // iOS 11 适配
    if (@available(iOS 11, *)) {
        backButton.frame  =  CGRectMake(2.5, 0, 22, 22);
    } else {
        backButton.frame  =  CGRectMake(12.5, 0, 22, 22);
    }
    if (@available(iOS 13.0, *)) {
        [backButton setImage:[UIImage systemImageNamed:@"chevron.backward"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage systemImageNamed:@"chevron.backward"] forState:UIControlStateHighlighted];
    } else {
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton setTitle:@"Back" forState:UIControlStateHighlighted];
    }
    backButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    [backButton addTarget: self action:@selector(closeView) forControlEvents: UIControlEventTouchUpInside];
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 22)];
    [leftview addSubview:backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftview];
}

//返回按钮
-(void)closeView
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark ZJContentPageVideoStateDelegate
/**
 * 视频开始播放
 * @param videoContent 内容模型
 */
- (void)zj_videoDidStartPlay:(id<ZJContentInfo>)videoContent{
    if (self.videoDidStartPlay) self.videoDidStartPlay();
}
/**
* 视频暂停播放
* @param videoContent 内容模型
*/
- (void)zj_videoDidPause:(id<ZJContentInfo>)videoContent{
    if (self.videoDidPause) self.videoDidPause();
}
/**
* 视频恢复播放
* @param videoContent 内容模型
*/
- (void)zj_videoDidResume:(id<ZJContentInfo>)videoContent{
    if (self.videoDidResume) self.videoDidResume();
}
/**
* 视频停止播放
* @param videoContent 内容模型
* @param finished     是否播放完成
*/
- (void)zj_videoDidEndPlay:(id<ZJContentInfo>)videoContent isFinished:(BOOL)finished{
    if (self.videoDidEndPlay) self.videoDidEndPlay();
}
/**
* 视频播放失败
* @param videoContent 内容模型
* @param error        失败原因
*/
- (void)zj_videoDidFailedToPlay:(id<ZJContentInfo>)videoContent withError:(NSError *)error{
    if (self.videoDidFailedToPlay) self.videoDidFailedToPlay(error);
}

#pragma mark ZJContentPageStateDelegate

/**
* 内容展示
* @param content 内容模型
*/
- (void)zj_contentDidFullDisplay:(id<ZJContentInfo>)content{
    if (self.contentDidFullDisplay) self.contentDidFullDisplay();
}
/**
* 内容隐藏
* @param content 内容模型
*/
- (void)zj_contentDidEndDisplay:(id<ZJContentInfo>)content{
    if (self.contentDidEndDisplay) self.contentDidEndDisplay();
}
/**
* 内容暂停显示，ViewController disappear或者Application resign active
* @param content 内容模型
*/
- (void)zj_contentDidPause:(id<ZJContentInfo>)content{
    if (self.contentDidPause) self.contentDidPause();
}
/**
* 内容恢复显示，ViewController appear或者Application become active
* @param content 内容模型
*/
- (void)zj_contentDidResume:(id<ZJContentInfo>)content{
    if (self.contentDidResume) self.contentDidResume();
}
@end
