//
//  ZJContentPagePlatformView.m
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import "ZJContentPagePlatformView.h"
#import <ZJSDK/ZJSDK.h>
#import "ZJPlatformTool.h"
@interface ZJContentPagePlatformView()<FlutterStreamHandler, ZJBannerAdViewDelegate>
@property (nonatomic, strong) UIView *containerView;

@property(nonatomic,strong) UIView *ContentPageView;

@property (nonatomic, strong) FlutterResult bannerCallback;

@end

@implementation ZJContentPagePlatformView

@end
