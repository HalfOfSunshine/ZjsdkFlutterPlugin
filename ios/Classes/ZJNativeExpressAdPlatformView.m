//
//  ZJNativeExpressAdPlatformView.m
//  zjsdk_flutter
//
//  Created by Mountain King on 2022/10/9.
//

#import "ZJNativeExpressAdPlatformView.h"
#import <ZJSDK/ZJNativeExpressFeedAdManager.h>
#import "ZJPlatformTool.h"

@interface ZJNativeExpressAdPlatformView()<FlutterStreamHandler,ZJNativeExpressFeedAdManagerDelegate,ZJNativeExpressFeedAdDelegate >
@property (nonatomic,strong)ZJNativeExpressFeedAdManager *feedAd;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIColor *adBackgroundColor;

@property (nonatomic, strong) FlutterResult nativeExpressCallback;

@end

@implementation ZJNativeExpressAdPlatformView
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar> *)registrar{
    if (self = [super init]) {
        // 获取参数
        NSString *adId;
        CGFloat nativeExpressWidth = 0, nativeExpressHeight = 0;
        if ([args isKindOfClass:[NSDictionary class]]) {
            adId = [ZJPlatformTool isEmptyString:args[@"adId"]]?@"":args[@"adId"];
            nativeExpressWidth = [ZJPlatformTool isEmptyString:args[@"width"]]?[UIScreen mainScreen].bounds.size.width:[args[@"width"] floatValue];
            nativeExpressHeight = [ZJPlatformTool isEmptyString:args[@"height"]]?0:[args[@"height"] floatValue];
            if (![ZJPlatformTool isEmptyString:args[@"adBackgroundColor"]]) {
                NSInteger argb = [args[@"adBackgroundColor"] integerValue];
                self.adBackgroundColor = [UIColor colorWithRed:((float)((argb & 0xFF0000) >> 16))/255.0 green:((float)((argb & 0xFF00) >> 8))/255.0 blue:((float)(argb & 0xFF))/255.0 alpha:((float)((argb & 0xFF000000) >> 24))/255.0];
            }
        }

        // 加载nativeExpress
        if (!_feedAd) {
            _feedAd = [[ZJNativeExpressFeedAdManager alloc] initWithPlacementId:adId size:CGSizeMake(nativeExpressWidth, nativeExpressHeight)];
            _feedAd.delegate = self;
            _feedAd.mutedIfCan = YES;
        }
        [_feedAd loadAdDataWithCount:1];
        
//        [_bannerAd loadBannerAdWithFrame:CGRectMake(0, 0, bannerWidth, bannerHeight) viewController:[MobAdPlugin findCurrentShowingViewController] delegate:self interval:0 group:@"b1"];
        
        // 容器view
        _containerView = [[UIView alloc] initWithFrame:frame];
        _containerView.backgroundColor = [UIColor clearColor];
        
        // 事件通道
        NSString *channelName = [NSString stringWithFormat:@"com.zjsdk.adsdk/native_express_event_%lld", viewId];
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
    NSLog(@"native express event -> listen");
    if (events) {
        self.nativeExpressCallback = events;
    }
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    NSLog(@"native express event -> cancel listen");
    return nil;
}
#pragma mark - ZJNativeExpressFeedAdManagerDelegate

#pragma mark - ZJNativeExpressFeedAdManagerDelegate
-(void)ZJ_nativeExpressFeedAdManagerSuccessToLoad:(ZJNativeExpressFeedAdManager *)adsManager nativeAds:(NSArray<ZJNativeExpressFeedAd *> *)feedAdDataArray{

    ZJNativeExpressFeedAd *feedAd = feedAdDataArray[0];
    feedAd.rootViewController = [ZJPlatformTool findCurrentShowingViewController];
    feedAd.delegate = self;
    [feedAd render];
    
    UIView *view = [self.containerView viewWithTag:100];
    [view removeFromSuperview];
    feedAd.feedView.tag = 100;

    feedAd.feedView.frame = self.containerView.bounds;
    [self.containerView addSubview:feedAd.feedView];

    if (self.nativeExpressCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"nativeExpressAdViewDidLoad" forKey:@"event"];
        self.nativeExpressCallback(result);
    }
}

-(void)ZJ_nativeExpressFeedAdManager:(ZJNativeExpressFeedAdManager *)adsManager didFailWithError:(NSError *)error{
    if (self.nativeExpressCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"nativeExpressAdDidLoadFail" forKey:@"event"];
        [result setObject:[self getErrorString:error] forKey:@"error"];
        self.nativeExpressCallback(result);
    }
    [self.containerView removeFromSuperview];
}

#pragma mark - ZJNativeExpressFeedAdDelegate
/**
 * 广告渲染成功
 */
- (void)ZJ_nativeExpressFeedAdRenderSuccess:(ZJNativeExpressFeedAd *)feedAd{
    if (self.nativeExpressCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"nativeExpressAdRenderSuccess" forKey:@"event"];
        feedAd.feedView.backgroundColor = self.adBackgroundColor;
        [result setObject:@{@"adHeight":@(feedAd.feedView.frame.size.height)} forKey:@"extraMap"];
        self.nativeExpressCallback(result);
    }
}
/**
 * 广告渲染失败
 */
- (void)ZJ_nativeExpressFeedAdRenderFail:(ZJNativeExpressFeedAd *)feedAd{
    if (self.nativeExpressCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"nativeExpressAdRenderFail" forKey:@"event"];
        self.nativeExpressCallback(result);
    }
}

- (void)ZJ_nativeExpressFeedAdViewWillShow:(ZJNativeExpressFeedAd *)feedAd{
    if (self.nativeExpressCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"nativeExpressAdViewWillShow" forKey:@"event"];
        self.nativeExpressCallback(result);
    }
}
- (void)ZJ_nativeExpressFeedAdDidClick:(ZJNativeExpressFeedAd *)feedAd{
    if (self.nativeExpressCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"nativeExpressAdDidClick" forKey:@"event"];
        self.nativeExpressCallback(result);
    }
}
- (void)ZJ_nativeExpressFeedAdDislike:(ZJNativeExpressFeedAd *)feedAd{
    if (self.nativeExpressCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"nativeExpressAdDislike" forKey:@"event"];
        self.nativeExpressCallback(result);
    }
}


- (void)ZJ_nativeExpressFeedAdDidShowOtherController:(ZJNativeExpressFeedAd *)nativeAd{
    
}
- (void)ZJ_nativeExpressFeedAdDidCloseOtherController:(ZJNativeExpressFeedAd *)nativeAd{
    
}



//#pragma mark - BannerAdDelegate
///**
// banner广告加载成功
// */
//- (void)zj_bannerAdViewDidLoad:(ZJBannerAdView *)bannerAdView{
//    [self.containerView addSubview:bannerAdView];
//
//    if (self.bannerCallback) {
//        NSMutableDictionary *result = [NSMutableDictionary dictionary];
//        [result setObject:@"bannerAdViewDidLoad" forKey:@"event"];
//        self.bannerCallback(result);
//    }
//}
//
///**
// banner广告加载失败
// */
//- (void)zj_bannerAdView:(ZJBannerAdView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error{
//    [self.containerView removeFromSuperview];
////    self.containerView = nil;
//    if (self.bannerCallback) {
//        NSMutableDictionary *result = [NSMutableDictionary dictionary];
//        [result setObject:@"bannerAdDidLoadFail" forKey:@"event"];
//        [result setObject:[self getErrorString:error] forKey:@"error"];
//        self.bannerCallback(result);
//    }
//}
//
-(NSString *)getErrorString:(NSError *)error{
    return [NSString stringWithFormat:@"错误信息:(%@-%ld)",error.domain,(long)error.code];
}
//
///**
// bannerAdView曝光回调
// */
//- (void)zj_bannerAdViewWillBecomVisible:(ZJBannerAdView *)bannerAdView{
//    if (self.bannerCallback) {
//        NSMutableDictionary *result = [NSMutableDictionary dictionary];
//        [result setObject:@"bannerAdViewWillBecomVisible" forKey:@"event"];
//        self.bannerCallback(result);
//    }
//}
//
///**
// 关闭banner广告回调
// */
//- (void)zj_bannerAdViewDislike:(ZJBannerAdView *)bannerAdView{
//    if (self.bannerCallback) {
//        NSMutableDictionary *result = [NSMutableDictionary dictionary];
//        [result setObject:@"bannerAdViewDislike" forKey:@"event"];
//        self.bannerCallback(result);
//    }
//}
//
///**
// 点击banner广告回调
// */
//- (void)zj_bannerAdViewDidClick:(ZJBannerAdView *)bannerAdView{
//    if (self.bannerCallback) {
//        NSMutableDictionary *result = [NSMutableDictionary dictionary];
//        [result setObject:@"bannerAdViewDidClick" forKey:@"event"];
//        self.bannerCallback(result);
//    }
//}
//
///**
// 关闭banner广告详情页回调
// */
//- (void)zj_bannerAdViewDidCloseOtherController:(ZJBannerAdView *)bannerAdView{
//    if (self.bannerCallback) {
//        NSMutableDictionary *result = [NSMutableDictionary dictionary];
//        [result setObject:@"bannerAdViewDidCloseOtherController" forKey:@"event"];
//        self.bannerCallback(result);
//    }
//}


@end

#pragma mark - PlatformViewFactory

@interface ZJNativeExpressAdPlatformViewFactory()
@property (nonatomic, strong) NSObject<FlutterPluginRegistrar> *registrar;
@end

@implementation ZJNativeExpressAdPlatformViewFactory

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
    return [[ZJNativeExpressAdPlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}

@end
