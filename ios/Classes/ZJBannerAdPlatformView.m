//
//  ZJBannerAdPlatformView.m
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/5/11.
//

#import "ZJBannerAdPlatformView.h"
#import <ZJSDK/ZJSDK.h>
#import "ZJPlatformTool.h"
@interface ZJBannerAdPlatformView()<FlutterStreamHandler, ZJBannerAdViewDelegate>
@property (nonatomic, strong) UIView *containerView;

@property(nonatomic,strong) ZJBannerAdView *bannerAd;

@property (nonatomic, strong) FlutterResult bannerCallback;

@end

@implementation ZJBannerAdPlatformView
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar> *)registrar{
    if (self = [super init]) {
        
        // 获取参数
        NSString *adId;
        CGFloat bannerWidth = 0, bannerHeight = 0;
        if ([args isKindOfClass:[NSDictionary class]]) {
            adId = args[@"adId"];
            bannerWidth = [args[@"width"] floatValue];
            bannerHeight = [args[@"height"] floatValue];
        }
        
        if (bannerWidth <= 0.0) {
            bannerWidth = [UIScreen mainScreen].bounds.size.width;
            bannerHeight = bannerWidth /6.4;
        }
        

        // 加载banner
        _bannerAd = [[ZJBannerAdView alloc]initWithPlacementId:adId viewController:[ZJPlatformTool findCurrentShowingViewController] adSize:CGSizeMake(bannerWidth, bannerHeight) interval:0];
        _bannerAd.delegate = self;
        [_bannerAd loadAdAndShow];
//        [_bannerAd loadBannerAdWithFrame:CGRectMake(0, 0, bannerWidth, bannerHeight) viewController:[MobAdPlugin findCurrentShowingViewController] delegate:self interval:0 group:@"b1"];
        
        // 容器view
        _containerView = [[UIView alloc] initWithFrame:frame];
        _containerView.backgroundColor = [UIColor clearColor];
        
        // 事件通道
        NSString *channelName = [NSString stringWithFormat:@"com.zjsdk.adsdk/banner_event_%lld", viewId];
        FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:[registrar messenger]];
        [eventChannel setStreamHandler:self];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (nonnull UIView *)view {
    return _containerView;
}

- (FlutterError* _Nullable)onListenWithArguments:(NSString *_Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    NSLog(@"banner event -> listen");
    if (events) {
        self.bannerCallback = events;
    }
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    NSLog(@"banner event -> cancel listen");
    return nil;
}

#pragma mark - BannerAdDelegate
/**x
 banner广告加载成功
 */
- (void)zj_bannerAdViewDidLoad:(ZJBannerAdView *)bannerAdView{
    [self.containerView addSubview:bannerAdView];
    
    if (self.bannerCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"bannerAdViewDidLoad" forKey:@"event"];
        self.bannerCallback(result);
    }
}

/**
 banner广告加载失败
 */
- (void)zj_bannerAdView:(ZJBannerAdView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error{
    [self.containerView removeFromSuperview];
//    self.containerView = nil;
    if (self.bannerCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"bannerAdDidLoadFail" forKey:@"event"];
        [result setObject:[self getErrorString:error] forKey:@"error"];
        self.bannerCallback(result);
    }
}

-(NSString *)getErrorString:(NSError *)error{
    return [NSString stringWithFormat:@"错误信息:(%@-%ld)",error.domain,(long)error.code];
}

/**
 bannerAdView曝光回调
 */
- (void)zj_bannerAdViewWillBecomVisible:(ZJBannerAdView *)bannerAdView{
    if (self.bannerCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"bannerAdViewWillBecomVisible" forKey:@"event"];
        self.bannerCallback(result);
    }
}

/**
 关闭banner广告回调
 */
- (void)zj_bannerAdViewDislike:(ZJBannerAdView *)bannerAdView{
    if (self.bannerCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"bannerAdViewDislike" forKey:@"event"];
        self.bannerCallback(result);
    }
}

/**
 点击banner广告回调
 */
- (void)zj_bannerAdViewDidClick:(ZJBannerAdView *)bannerAdView{
    if (self.bannerCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"bannerAdViewDidClick" forKey:@"event"];
        self.bannerCallback(result);
    }
}

/**
 关闭banner广告详情页回调
 */
- (void)zj_bannerAdViewDidCloseOtherController:(ZJBannerAdView *)bannerAdView{
    if (self.bannerCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"bannerAdViewDidCloseOtherController" forKey:@"event"];
        self.bannerCallback(result);
    }
}

@end



#pragma mark - PlatformViewFactory

@interface ZJBannerAdPlatformViewFactory()
@property (nonatomic, strong) NSObject<FlutterPluginRegistrar> *registrar;
@end

@implementation ZJBannerAdPlatformViewFactory

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    self = [super init];
    if (self) {
        _registrar = registrar;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args {
    return [[ZJBannerAdPlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}
@end
