//
//  ZJContentHorizontalPagePlatformView.h
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <ZJSDK/ZJHorizontalFeedPage.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJContentHorizontalPagePlatformView : NSObject<FlutterPlatformView,ZJContentPageHorizontalFeedCallBackDelegate>

@end
@interface ZJContentHorizontalPagePlatformViewFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
@end
NS_ASSUME_NONNULL_END
