//
//  ZJContentImageTextPagePlatformView.m
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import "ZJContentImageTextPagePlatformView.h"
#import <ZJSDK/ZJSDK.h>
#import <ZJSDK/ZJImageTextPage.h>
#import "ZJPlatformTool.h"
@interface ZJContentImageTextPagePlatformView()<FlutterStreamHandler>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic,strong)ZJImageTextPage *contentPage;

@property(nonatomic,strong) UIView *contentPageView;

@property (nonatomic, strong) FlutterResult contentPageCallback;

@end

@implementation ZJContentImageTextPagePlatformView
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
        self.contentPage = [[ZJImageTextPage alloc]initWithPlacementId:adId];
        self.contentPage.callBackDelegate = self;
        self.contentPage.imageTextDelegate = self;
        
        _contentPageView = self.contentPage.viewController.view;
        _contentPageView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
//        UIViewController *vc = [UIViewController new];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//        vc.view.hidden = YES;
//        nav.navigationBarHidden = YES;
//        [self.contentPage.viewController.navigationController setNavigationBarHidden:YES];
//        [[ZJPlatformTool findCurrentShowingViewController] presentViewController:nav animated:NO completion:nil];
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

#pragma mark ImageTextPageVideoStateDelegate
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

#pragma mark ImageTextPageStateDelegate

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

#pragma mark =============== ZJContentPageHorizontalFeedCallBackDelegate ===============

/// 进入横版视频详情页
/// @param viewController 详情页VC
/// @param content 视频信息
- (void)zj_horizontalFeedDetailDidEnter:(UIViewController *)viewController contentInfo:(id<ZJContentInfo>)content{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"horizontalFeedDetailDidEnter" forKey:@"event"];
        self.contentPageCallback(result);
    }
}
/// 离开横版视频详情页
/// @param viewController 详情页VC
- (void)zj_horizontalFeedDetailDidLeave:(UIViewController *)viewController{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"horizontalFeedDetailDidLeave" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

/// 视频详情页appear
/// @param viewController 详情页VC
- (void)zj_horizontalFeedDetailDidAppear:(UIViewController *)viewController{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"horizontalFeedDetailDidAppear" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

/// 详情页disappear
/// @param viewController 详情页VC
- (void)zj_horizontalFeedDetailDidDisappear:(UIViewController *)viewController{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"horizontalFeedDetailDidDisappear" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

#pragma mark =============== ZJImageTextDetailDelegate ===============
/// 进入图文详情页
/// @param detailViewController 图文详情页VC
/// @param feedId feedId
- (void)zj_imageTextDetailDidEnter:(UIViewController *)detailViewController feedId:(NSString *)feedId{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"imageTextDetailDidEnter" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

/// 离开图文详情页
/// @param detailViewController 图文详情页VC
- (void)zj_imageTextDetailDidLeave:(UIViewController *)detailViewController{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"imageTextDetailDidLeave" forKey:@"event"];
        self.contentPageCallback(result);
    }
}


/// 图文详情页appear
/// @param detailViewController 图文详情页VC
- (void)zj_imageTextDetailDidAppear:(UIViewController *)detailViewController{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"imageTextDetailDidAppear" forKey:@"event"];
        self.contentPageCallback(result);
    }
}

/// 图文详情页disappear
/// @param detailViewController 图文详情页VC
- (void)zj_imageTextDetailDidDisappear:(UIViewController *)detailViewController{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"imageTextDetailDidDisappear" forKey:@"event"];
        self.contentPageCallback(result);
    }
}


/// 图文详情加载结果
/// @param detailViewController 图文详情页VC
/// @param success 是否成功
/// @param error error
- (void)zj_imageTextDetailDidLoadFinish:(UIViewController *)detailViewController sucess:(BOOL)success error:(NSError *)error{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"imageTextDetailDidLoadFinish" forKey:@"event"];
        self.contentPageCallback(result);
    }
}


/// 图文详情阅读进度
/// @param detailViewController 图文详情页VC
/// @param isFold 是否折叠
/// @param totalHeight 详情总高度
/// @param seenHeight 已经看过的高度
- (void)zj_imageTextDetailDidScroll:(UIViewController *)detailViewController isFold:(BOOL)isFold totalHeight:(CGFloat)totalHeight seenHeight:(CGFloat)seenHeight{
    if (self.contentPageCallback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:@"imageTextDetailDidScroll" forKey:@"event"];
        self.contentPageCallback(result);
    }
}
@end



#pragma mark - PlatformViewFactory

@interface ZJContentImageTextPagePlatformViewFactory()
@property (nonatomic, strong) NSObject<FlutterPluginRegistrar> *registrar;
@end

@implementation ZJContentImageTextPagePlatformViewFactory

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
    return [[ZJContentImageTextPagePlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}
@end
