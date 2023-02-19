//
//  ZJContentListPagePlatformView.m
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import "ZJContentListPagePlatformView.h"
#import <ZJSDK/ZJSDK.h>
#import "ZJPlatformTool.h"
@interface ZJContentListPagePlatformView()<FlutterStreamHandler>
@property (nonatomic, strong) UIView *containerView;
@property(nonatomic,strong) ZJContentPage *contentPage;

@property(nonatomic,strong) UIView *contentPageView;

@property (nonatomic, strong) FlutterResult contentPageCallback;

@end

@implementation ZJContentListPagePlatformView
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar> *)registrar{
    if (self = [super init]) {
        
        // 获取参数
        NSString *adId;
        CGFloat viewWidth = 0, viewHeight = 0;
        if ([args isKindOfClass:[NSDictionary class]]) {
            adId = args[@"adId"];
            viewWidth = [args[@"width"] floatValue];
            viewHeight = [args[@"height"] floatValue];
        }
        
        if (viewWidth <= 0.0) {
            viewWidth = [UIScreen mainScreen].bounds.size.width;
            viewHeight = [UIScreen mainScreen].bounds.size.height;
        }
        
        //强持有避免立刻释放
        self.contentPage = [[ZJContentPage alloc]initWithPlacementId:adId];
        self.contentPage.videoStateDelegate = self;
        self.contentPage.stateDelegate = self;

        _contentPageView = self.contentPage.viewController.view;
        _contentPageView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
        
        //直接添加会被拉伸，隔一层添加不会
        UIView *adapterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        adapterView.backgroundColor = [UIColor clearColor];
        [adapterView addSubview:_contentPageView];
        
        // 容器view
        _containerView = [[UIView alloc] initWithFrame:frame];
        _containerView.backgroundColor = [UIColor clearColor];
        [_containerView addSubview:adapterView];

        // 事件通道
        NSString *channelName = [NSString stringWithFormat:@"com.zjsdk.adsdk/content_video_event_%lld", viewId];
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
    NSLog(@"content event -> listen");
    if (events) {
        self.contentPageCallback = events;
    }
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    NSLog(@"content event -> cancel listen");
    return nil;
}

#pragma mark ZJContentPageVideoStateDelegate
/**
 * 视频开始播放
 * @param videoContent 内容模型
 */
- (void)zj_videoDidStartPlay:(id<ZJContentInfo>)videoContent{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"videoDidStartPlay" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

/**
* 视频暂停播放
* @param videoContent 内容模型
*/
- (void)zj_videoDidPause:(id<ZJContentInfo>)videoContent{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"videoDidPause" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

/**
* 视频恢复播放
* @param videoContent 内容模型
*/
- (void)zj_videoDidResume:(id<ZJContentInfo>)videoContent{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"videoDidResume" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

/**
* 视频停止播放
* @param videoContent 内容模型
* @param finished     是否播放完成
*/
- (void)zj_videoDidEndPlay:(id<ZJContentInfo>)videoContent isFinished:(BOOL)finished{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"videoDidEndPlay" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

/**
* 视频播放失败
* @param videoContent 内容模型
* @param error        失败原因
*/
- (void)zj_videoDidFailedToPlay:(id<ZJContentInfo>)videoContent withError:(NSError *)error{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"videoDidFailedToPlay" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

#pragma mark ZJContentPageStateDelegate

/**
* 内容展示
* @param content 内容模型
*/
- (void)zj_contentDidFullDisplay:(id<ZJContentInfo>)content{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"contentDidFullDisplay" forKey:@"event"];
        self.contentPageCallback(result);
    }
}
/**
* 内容隐藏
* @param content 内容模型
*/
- (void)zj_contentDidEndDisplay:(id<ZJContentInfo>)content{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"contentDidEndDisplay" forKey:@"event"];
        self.contentPageCallback(result);
    }
}
/**
* 内容暂停显示，ViewController disappear或者Application resign active
* @param content 内容模型
*/
- (void)zj_contentDidPause:(id<ZJContentInfo>)content{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"contentDidPause" forKey:@"event"];
        self.contentPageCallback(result);
    }
}
/**
* 内容恢复显示，ViewController appear或者Application become active
* @param content 内容模型
*/
- (void)zj_contentDidResume:(id<ZJContentInfo>)content{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"contentDidResume" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

@end



#pragma mark - PlatformViewFactory

@interface ZJContentListPagePlatformViewFactory()
@property (nonatomic, strong) NSObject<FlutterPluginRegistrar> *registrar;
@end

@implementation ZJContentListPagePlatformViewFactory

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
    return [[ZJContentListPagePlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}
@end
