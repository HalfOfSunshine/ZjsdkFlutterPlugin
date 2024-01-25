#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <ZJSDK/ZJSDK.h>
#import "ZJSplashAdWrapper.h"
@interface AppDelegate()
@property (nonatomic,strong)ZJSplashAdWrapper *splashAd;

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupZJSDK];

  [GeneratedPluginRegistrant registerWithRegistry:self];
    
//  [self showSplashAd];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// 初始化广告SDK
- (void)setupZJSDK {
    
//    // 初始化广告SDK
//    [ZJAdSDK registerAppId:@"zj_20201014iOSDEMO"];
//    NSString *sdkVersion = [ZJAdSDK SDKVersion];
//    NSLog(@"ZJSDKVersion: %@", sdkVersion);
}


-(void)showSplashAd{
    self.splashAd = [[ZJSplashAdWrapper alloc]init];
    [self.splashAd loadSplashAdWithAdId:@"zjad_G9040714184494018" fetchDelay:5];
    //开屏广告加载成功
    __weak typeof(self) weakSelf = self;
    self.splashAd.splashAdDidLoad = ^{
//        [weakSelf.splashAd showSplashAdInWindow:[UIApplication sharedApplication].keyWindow withBottomView:nil];
    };
    //开屏广告展示
    self.splashAd.splashAdSuccessPresentScreen = ^{
        
    };
    //开屏广告点击
    self.splashAd.splashAdClicked = ^{
        
    };
    //开屏广告倒计时结束
    self.splashAd.splashAdCountdownEnd = ^{
        
    };
    //开屏广告关闭
    self.splashAd.splashAdClosed = ^{
        
    };
    self.splashAd.splashAdApplicationWillEnterBackground = ^{
        
    };
    //开屏广告错误-方便查看错误信息
    self.splashAd.splashAdError = ^(NSError * _Nonnull error) {
        
    };
}


@end
